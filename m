From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] setup.c: re-fix d95138e (setup: set env
 $GIT_WORK_TREE when ..
Date: Sat, 5 Dec 2015 20:12:17 +0100
Message-ID: <CACsJy8BKbzzE7D0a2HqjU3kvz1SitcJyVxZH=aWAc+bBd8MmQg@mail.gmail.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com> <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1449166676-30845-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 05 20:13:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5IGg-00080G-TV
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 20:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbbLETMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Dec 2015 14:12:49 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34673 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbLETMs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2015 14:12:48 -0500
Received: by lbbcs9 with SMTP id cs9so36887537lbb.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2015 11:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bRLZ9XmRa6scz0W2s/UfGoRxslNy6FA60TDPLSyo7AE=;
        b=pzFrMvkVILMcgoEMuKomZ6lp135RCEKVAAKRyHxcIeZ2Bp6sLA9c1a3YnogYN8CXO4
         ELywOQ9yeO85O4g5jKPNjFS3CRdl2Vl05DWDC9U1xW68BzZqELZHUBZdLQRV4hzkHciA
         5leF5nhxn1qOgT35ptV6RzZi0dinvt22PPDCBGIDnrCUKYIR/zK+Lz2WD15J7BKxnPrQ
         jtwaJfXJXJLXiQ5O0M3M8PerQQYqdJ5xvImx4v1RyO16f20LgCK15L2r+Hh2nuRMVwld
         EUxUMOXmpZGhTg/8jlDE3lILAZU4Xc2DxK9YXiGP7y1jGCcEuaz4AxfkUOi1ECFvZDIO
         oCEg==
X-Received: by 10.112.16.135 with SMTP id g7mr11162396lbd.80.1449342766951;
 Sat, 05 Dec 2015 11:12:46 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Sat, 5 Dec 2015 11:12:17 -0800 (PST)
In-Reply-To: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282037>

On Thu, Dec 3, 2015 at 7:17 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> The solution in d95138e is reverted in this commit. Instead we reuse =
the
> solution from c056261 [4]. c056261 fixes another setup-messed-up-by-a=
lias
> by saving and restoring env for git-clone and git-init. Now I conclud=
e
> that setup-messed-by-alias is always evil. So the env restoration is
> done for _all_ commands  whenever aliases are involved. It fixes what
> d95138e tries to fix. And it does not upset git-clone-inside-hooks.

(Reviewer hat on) I wrote env restoration is done for all commands,
but the patch is actually about all _builtin_ commands. External ones
do not receive this treatment. FIx is in the next reroll.
--=20
Duy
