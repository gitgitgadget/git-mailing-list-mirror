From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/3] bisect: improve error message of 'bisect log' while
 not bisecting
Date: Mon, 11 Oct 2010 06:44:42 +0000
Message-ID: <AANLkTi=KZyhJrYw+L2U6gsu=jNcBe8eRJTG4jSuPTYsT@mail.gmail.com>
References: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Oct 11 08:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5CAH-0007V2-It
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 08:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab0JKGoo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 02:44:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54792 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab0JKGon convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 02:44:43 -0400
Received: by iwn6 with SMTP id 6so2957991iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rgWjUHvcEGd054m6nMUvtZdj4+lQYZl1x38oRGV3gGs=;
        b=QNwIRE2cMarCoGFPwNL3s1O4I07/rYqGvNctpPKn6JQ/c+hx+UGvNfCLkSXGcgj1Yc
         2VSZP59aZQk6CerOUxcuP8WGd/mLzVZP4gajeb8Qwibs6UASW2Kpp1lXajqRb6d9LMS6
         Hws+S5M9WOeZVL1Ohm4cfucVuBPKj1dKqarQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NxDB3HBdTHh9cZlECxY4q93AWV1qWzcUr2nWj6GtcnyJcnGDXRUXj7qNN/8v+KyxN4
         jkcRoiH45Me1yqcNH1Nunfs8VEC+SY7eKKmbe5oyXVVg65X2SeiXNqbJ92yqwk9w08b5
         gSgkkkpyWczNQbGuSmIdYvSSq76Ti0Hgn7gfY=
Received: by 10.42.89.3 with SMTP id e3mr1430470icm.361.1286779482258; Sun, 10
 Oct 2010 23:44:42 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 10 Oct 2010 23:44:42 -0700 (PDT)
In-Reply-To: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158750>

2010/10/10 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> 'git bisect log' is implemented by a direct invocation of 'cat
> "$GIT_DIR/BISECT_LOG"', without any sanity checks. =C2=A0Consequently=
,
> running 'git bisect log' while not bisecting leads to an error,
> because the bisect logfile doesn't exists. =C2=A0The accompanying err=
or
> message

Nice, in case you want to fix this for git-rebase too:

Applying: gettextize: git-add "no files added" message
Applying: gettextize: git-add "Use -f if you really want" message
Applying: gettextize: git-add "pathspec [...] did not match" message
Applying: gettextize: git-add "remove '%s'" message
^C
v t ((5cab536...)|REBASE) $ git rebase --abort
cat: /home/avar/g/git/.git/rebase-apply/head-name: No such file or dire=
ctory
cat: /home/avar/g/git/.git/rebase-apply/orig-head: No such file or dire=
ctory
HEAD is now at 5cab536 gettextize: git-add "remove '%s'" message
v t ((5cab536...)) $
v t ((5cab536...)) $ git rebase --abort
No rebase in progress?
v t ((5cab536...)) $
