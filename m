From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 19:19:28 +0100
Message-ID: <200702021919.28669.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org> <20070202175923.GA6304@xanadu.kublai.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	mercurial@selenic.com, git@vger.kernel.org
To: Brendan Cully <brendan@kublai.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 19:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD2zI-00040a-Il
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 19:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945995AbXBBSSK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 13:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946010AbXBBSSK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 13:18:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:22409 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945995AbXBBSSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 13:18:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so830442uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 10:18:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kagsrFHvpNTM12gfNNozOOO965QzhowlqlWeet8gKUKOonRMqrhQ7CWry/x5qY6DV6iqn7WbWq8kPxSP9+x42hlmio+tK0bDSmSLw1O+t+pPwOGNKjkny5JSU0/UvTxlvwqlEZoxLQkUeGBHjrVW/WkdTpOqH4aa7Q/SWRImLQk=
Received: by 10.66.244.10 with SMTP id r10mr4758254ugh.1170440287457;
        Fri, 02 Feb 2007 10:18:07 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id m1sm4671718ugc.2007.02.02.10.18.06;
        Fri, 02 Feb 2007 10:18:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070202175923.GA6304@xanadu.kublai.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38522>

Brendan Cully wrote:
> On Friday, 02 February 2007 at 08:42, Linus Torvalds wrote:
>> 
>> The mistake seems to be to think that tags get "versioned", and are part 
>> of the tree history. That's insane. It means that you can never have a tag 
>> to a newer tree than the one you are on.
> 
> The tags you use can simply be those from the tip of the repository,
> regardless of which revision you've currently checked out.

_Can_ be or _are_ (in Mercurial)? Besides, there can be more than one
tip of repository (branch are tips of history), and making set of tags
dependent on which branch you are on is not a good idea either.

>> Tags are *independent* of history. They must be. They are "outside" 
>> history, since the whole point of tags are to point to history.
> 
> Tags have history too. They are added at particular times by
> particular people, and sometimes changed (this wouldn't happen in an
> ideal world, but it happens). It's a shame not to be able to find this
> history.

That is what reflogs are for, although you usually don't enable this
for tags (because tags are meant to be immutable, especially signed
release tags).

Besides, in git annotated tags have tagger info, i.e. who and when
created a tag.


Besides tags point to history. Having them inside history is abstraction
breakage, IMVHO.
-- 
Jakub Narebski
Poland
