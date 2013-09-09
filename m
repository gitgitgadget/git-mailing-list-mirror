From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 09 Sep 2013 09:18:09 +0200
Message-ID: <vpqr4cy4g5q.fsf@anie.imag.fr>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 09:19:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIvkR-0000UD-5g
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 09:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab3IIHSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 03:18:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45734 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab3IIHSy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 03:18:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r897I9NN023294
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Sep 2013 09:18:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VIvje-0003cy-6i; Mon, 09 Sep 2013 09:18:10 +0200
In-Reply-To: <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 8 Sep 2013 19:29:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 09 Sep 2013 09:18:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r897I9NN023294
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379315892.69629@1HxcCL52Dp8SJypeqZLEjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234316>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Sep 8, 2013 at 7:01 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>
>> Yes, that would be me.  My hesitance here is that as the one usually
>> driving git updates (which so far have happened once a year), I will end
>> up retraining forty developers.  I don't think the current behavior is
>> broken or really problematic at all: merging has always been the
>> default, and people have come to expect that.
>
> It may not be broken for you, but it is for other people. Would you be
> so egocentric as to ignore everybody else because "it works for you"?

It's not a matter of "works for me". Git currently "works" for all use
cases because you can already merge or rebase. The proposed changes are
not about allowing the behavior that works, but disallowing the behavior
that doesn't.

I agree that allowing people to reject non-ff merge is a good idea.

I strongly disagree that this should eventually become the default,
though. I think it should really remain an opt-in (possibly with some
non-scary warning advertizing for the feature).

First, the discussions on this thread show that it's hard to find the
right behavior. My guess is that it's hard because we're trying to think
for the users. I've used GNU Arch for a while, and this VCS was trying
to impose what the developer thought was good for me. I had to fight
with the tool whenever I tried to do something "non-standard". I don't
want to go back there. Preventing _users_ to do something because _we_
considered it was bad for them is wrong IMHO.

I already mentionned another reason in
http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=229162 :
"git rebase" is hard to use for many people. With "git merge", doing
things wrong isn't so bad. If you forget to commit after a conflicted
merge, you'll mix your changes with the merge, this is bad, but it
works. With "git rebase", if you forget to "git rebase --continue" after
a conflict, you end up in detached HEAD, with part of your own changes
discarded. If my students end up in this situation, they'll stop using
Git and exchange files by email.

"git pull" is one of the first things one learns with Git, and
_requiring_ users to chose between merge and rebase is a nonsense at
this time of learning.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
