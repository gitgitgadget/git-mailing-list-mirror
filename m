From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb: buggy 'commitdiff_plain' output
Date: Fri, 10 Jul 2009 19:38:11 +0200
Message-ID: <cb7bb73a0907101038t10494806k64380a5e33f1bc16@mail.gmail.com>
References: <alpine.LFD.2.01.0907100941060.3352@localhost.localdomain> 
	<200907101933.39424.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:38:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPK3T-0007Eu-8q
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbZGJRid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbZGJRid
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:38:33 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:47250 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbZGJRid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:38:33 -0400
Received: by bwz25 with SMTP id 25so1034252bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1uNd1e8zfV97ZDpFv/INH+XsYERufrxQEMT+xBjmj1A=;
        b=Rinq6AeLJROtV8USCYGCu650lak+I4+VcnhUytj+etvj4ruwv/ISO51xzJbokEZq4B
         Efkl5vdc4FO/GmOxQIfK0pAA9BwUVDVgmidekNr9f3rwuvK9HfyCDNxBCp0lVI5IBFVz
         83qH6ny3xkrCH2gPoU8jpnzPQxK1HmKispzlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qe55UOkczqtC9j9crC76npCB3ycigcHqsmuDkA4Aw+a3f3mRdpqHUjgqmlD/5TH4TH
         sNp4260XAtImKI8QvRLOedEvLLWyexRzRfR/DuZTMRPanUTbl1FX3PQL86+qJlnVRW9Y
         9M6akVBhRa1QsMShDYax4hP+m7tqAPN+qGvm8=
Received: by 10.204.112.1 with SMTP id u1mr2179585bkp.37.1247247511142; Fri, 
	10 Jul 2009 10:38:31 -0700 (PDT)
In-Reply-To: <200907101933.39424.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123073>

On Fri, Jul 10, 2009 at 7:33 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> Actually the problem is deeper; both 'commitdiff' and 'commitdiff_plain'
> try to do two things at once: an equivalent of "git show <commit>" _and_
> equivalent of "git diff <commit 1> <commit 2>"... and they fail.

I think the time might have come to break backwards compatibility and
fix commitdiff view once and for all ... of course we would have to
choose HOW to fix it ...

For single commits, we could have commitdiff = commit + diff and
commitdiff_plain = patch.

For multiple commits, we could have commitdiff(_plain) output a list
of subjects for each commit involved, + the output of git diff.

How does that sound? (read?)

-- 
Giuseppe "Oblomov" Bilotta
