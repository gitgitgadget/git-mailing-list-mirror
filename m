From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Bug?] "am --abort" broken?
Date: Thu, 13 Jun 2013 09:30:31 +0530
Message-ID: <CALkWK0ksCupC183X-XDwCcscHkQXq9whxxYeWLjR2FpH50ycHA@mail.gmail.com>
References: <7vsj0nymyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 06:01:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umyiq-0000tx-OW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 06:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604Ab3FMEBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 00:01:12 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46771 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab3FMEBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 00:01:12 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so11004694ieb.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 21:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C2LfFVTc6TMCYfW20IXTxI0j2DvY3gPLt891xx1NTSQ=;
        b=Ifccr3vFfUVLi2vf2jAZ85hsTCqYu87Ve0wo5Jb8/BbFyG3Kn92IPt5jZWToeC2gmO
         heeoyPOfGP7K1s6dhX2akr4fnInszsk1hUSz1QZ3bbsiOFIPYvJV0+k6paTF5zsKen6i
         5DePd3D8GsX7gVkx9n417SaUTUBsgenOM3eKTe5dqQQS4RwRVZWV2082avZr+VXR9rex
         VkHPpuFS6NqxYAP/bFv0Ms9T1H2TlmNsFmV8Ho02evJFmEHohT6YhmmwncV8Zp91fgkW
         /XJJYbWroxs8SWyruKQ1Nfz9loL3nKZqmKUMoLmbdRFJ4vwLYKRpfEIt0qu1iyT9vfla
         Nw3A==
X-Received: by 10.42.73.138 with SMTP id s10mr4678861icj.10.1371096071653;
 Wed, 12 Jun 2013 21:01:11 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Wed, 12 Jun 2013 21:00:31 -0700 (PDT)
In-Reply-To: <7vsj0nymyd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227695>

Junio C Hamano wrote:
>     $ git am ;# no input file
>     ^C
>
>     $ git am --abort
>     Resolve operation not in progress, we are not resuming.

I tried it on git 1.8.3, and this only incidentally "seems" to half-work (?)

% git am
^C
% git am --abort
cat: /home/artagnon/src/git/.git/rebase-apply/next: No such file or directory
% git status
# On branch master
# Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
#
nothing to commit, working directory clean

In the process of aborting, it blew away one commit!

> I think this is a recent breakage after merging the topic to add
> "rebase --autostash", but I haven't looked into it yet.

Yes, I can confirm that my topic introduced this bug, and I apologize
for not having caught it.  I'm looking into the problem.

Thanks.
