From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 01:53:14 -0700
Message-ID: <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 10:53:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjtXT-0006jP-RE
	for gcvg-git@gmane.org; Fri, 04 May 2007 10:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767740AbXEDIxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 04:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767747AbXEDIxQ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 04:53:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:38059 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767740AbXEDIxP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 04:53:15 -0400
Received: by nz-out-0506.google.com with SMTP id o1so793608nzf
        for <git@vger.kernel.org>; Fri, 04 May 2007 01:53:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nqpTAxG24YcnEGzpLZtARKYfGT6m7vktbloxcO6e1UPg1Z+iO8OTuqNRAqk982ZgADAQeYdp5gAz7IR+pawkTKTCQfikL37SEtZa1b6zHsg5Jweg95DweumLJwKMp5C8pwz690SKmq971Jcovli4ul9C6S3/cEk0Ib4wSPnOvIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X3jYAU6FtLvcBkNg5us4fwrSRuQh1GAYPySXyFap93yodpcepq04sgRXPdnXlqpX65r4h0wpMHVsXnBW+DDh000vgoXoaJ8BP8ZhUaYtI4CJEqHu3I+e/uh3jw0hN3brgB/eOgu/g2iOn38aBCKO1bUEOkQ5WTWZ9Z4+ulqjzb8=
Received: by 10.114.112.1 with SMTP id k1mr1046817wac.1178268794487;
        Fri, 04 May 2007 01:53:14 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 01:53:14 -0700 (PDT)
In-Reply-To: <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46148>

On 5/4/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> >  (1) we say it was a mistake that we did not make it relative to
> >      the current directory when we introduced the X:<path>
> >      syntax (X could be empty or :[0-3]: for index, or a commit
> >      or tree object name), and change the semantics in a future
> >      major release for everybody, apologizing for potentially
> >      breaking existing scripts; or
>
> That would be my first prio preference
Mine too,  but I don't want to break anything.

> >  (2) keep the current behaviour as is, and come up with a
> >      different syntax to use relative; or
> >
> >  (3) do nothing.
> >
> > My preference is (2), (3) and then (1), but I do not have
> > offhand a suggestion for a good metacharacter we could use.
>
> "./" :)
Heh.  Yes, that works in the current patch.

I'm really starting to like the idea of introducing "="
as an alternative for ":" :
"=" assumes relative paths, ":" assumes absolute (full) paths.
That could be Junio's new metacharacter.

Since "=" is slightly easier to type [ ;-) ], and looks like a stretched ":",
it's almost ingenious...
(Definitely getting carried away!)
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
