From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 11:46:38 +0200
Message-ID: <81b0412b0705040246r5a2726b8g4323cadeacee3aa7@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	 <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com>
	 <81b0412b0705040217o54d1d028j6e768bdc3eb0bad0@mail.gmail.com>
	 <56b7f5510705040226o14d55b6euda7df1da7ad9b08a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 11:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjuNP-0000b6-Jg
	for gcvg-git@gmane.org; Fri, 04 May 2007 11:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031356AbXEDJql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 05:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031360AbXEDJqk
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 05:46:40 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:44929 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031356AbXEDJqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 05:46:39 -0400
Received: by an-out-0708.google.com with SMTP id b33so775141ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 02:46:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xbw7Oxn3ajJ2OhZ5DGv+A0rHvGSzT9gNqT+g7ToQXGw1/cDAlXeKYAyTqh64NaSBiZ7t5ly1wR2cY5m8vgbcD0n3Gzd5PbLUcDVGtE9k2V78tpT+wifozpOJdkmB2g71vrvzzxiZnhtdRUhkv4G1W9fgr/+GYuy5j4z1zMEkKcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=McBKqQ4KNj/5GnHsJzVecggBEHh4ymJ/WtRrg18pEmOrt8zzxRMr2tZrTD5uR0ua3SHPEfNAxIhfJgfq65YrYk7AscC6hWTfXm7dsWwSQbYE+a9zA/LnO6kNK3SFwyuVe/ryl0RhLQDhXCRvPyUVQ8tgPkHLy0bij/df06nkA7I=
Received: by 10.101.67.8 with SMTP id u8mr2473571ank.1178271998621;
        Fri, 04 May 2007 02:46:38 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 02:46:38 -0700 (PDT)
In-Reply-To: <56b7f5510705040226o14d55b6euda7df1da7ad9b08a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46154>

On 5/4/07, Dana How <danahow@gmail.com> wrote:
> > I'd suggest to define a special character for _top_ level. Real pity
> > ":/" is taken.
> We could use ://fullpath for top level,

No good. How'd you find a commit starting with "/" than? (without
changing ":/" syntax).

> and :relpath for relative. Then "string" in :/string couldn't start with /,
> which shouldn't be a problem (right?).  I've certainly seen double
> slashes before;
> perforce in fact uses them for the root of the repository (depot).

And I really hate perforce for its stupid redundancy (and changing of
meaning of well-known idioms: why should // be anything special
but plain top level or root?! Why the hell do they need them at if
you cannot use relative paths in client specs at all?! Why can't the
p4 command-line tool figure the fact from context or request the
context be provided by user?! IOW, Perforce is a real bad example
of how you do version control).

> This all depends on deciding that :relpath should be the (incompatible)
> new default, and I'm not sure that's going to happen.

If we are to stay that compatible, maybe ":./" for relative paths and the
old syntax left to mean top-level would the best choice for now.
