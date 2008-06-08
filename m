From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] provide a new "theirs" strategy, useful for rebase --onto
Date: Sun, 08 Jun 2008 04:54:13 +0200
Message-ID: <484B49D5.8080708@gnu.org>
References: <E1K4a1Q-0002hq-QE@fencepost.gnu.org> <7vfxrqrwjm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 04:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5B4G-0004sE-QR
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 04:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbYFHCyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 22:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755101AbYFHCyR
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 22:54:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:20150 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbYFHCyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 22:54:16 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1314012waf.23
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 19:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=nQGIMa6EjKLky22Txc3/XL7N/piUa4wcAyX0EL/oE78=;
        b=Nyzu25gNZgAd5l4WJIhzWyBciku7DinT3Ge2gaTQqAesT2JO1xGHJqmThJmroEYw21
         rasscj9VZSkCli3ktMNWcAN9NoglfBfKWQru7cGfI2W+YS0KFgrpsivtTKFXThtkoY6S
         +XB+sy59pmjiUd1yJjfq0wQn7sOrpbBWRBjSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=r465ovzEiLS1JUPMPRuUZj7xGzuzKnydWfFk2nNm3a4cJogfpraTKDDA0ivk2sbhAQ
         b5vdZCubo4n37dvvnPZ6IfjAz/KNk0ZB4IxXT4Ur/uJbKDLwuVfy03V8JxRh94i0ZUjj
         til9gSH59t4N6SvFgpyH+mzLhqUj3jjeljcf8=
Received: by 10.114.170.2 with SMTP id s2mr1870530wae.170.1212893655633;
        Sat, 07 Jun 2008 19:54:15 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.163])
        by mx.google.com with ESMTPS id a8sm11168932poa.12.2008.06.07.19.54.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Jun 2008 19:54:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <7vfxrqrwjm.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84249>


> Because original E' was an amend of E, its log message explained
> everything E did and more.  You cannot leave that same commit message in
> E''.  What you did in E was already explained in the history, so now you
> would want to talk about the incremental change on top of it when you
> desribe E''.  For that, replaying of E' must stop to allow you to fix up
> the log message. 

Yes, I had suggested in the original thread to follow up with a "git 
rebase -i" to fix the commit message, because "git-rebase--interactive 
--help" did not show a -s option.  However, I found out that it does 
support it, so it is probably better to use "git rebase -i -s theirs 
--onto ..." directly.

> Yes, you may want an easy way to say "the result should have the same tree
> as E'" while replaying of E' on top of E _when_ you have to resolve the
> conflict.  But that is a separate issue ("git checkout $other_head --
> $conflicted_paths", or somesuch).  Using this in rebase is a horrible
> example inviting misuse and a broken history, I think.

You mean that I should a) drop the example from git-rebase.1, b) reword 
it to clarify it, c) drop the patch completely?

Paolo
