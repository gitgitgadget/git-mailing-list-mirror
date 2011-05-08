From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/4] i18n: Add shell script translation infrastructure
Date: Sun, 8 May 2011 23:38:02 +0200
Message-ID: <BANLkTikmj_urw389ad0r86OR+26AvXTVzg@mail.gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
	<BANLkTi=nTSf0CQWs-ODxw=P+eX=Dc7Yf-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 23:38:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJBg2-0006mO-Ey
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 23:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab1EHViG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 17:38:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64605 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1EHViD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 17:38:03 -0400
Received: by bwz15 with SMTP id 15so3559120bwz.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IMXwHQRPHdDc611ISYiqZiMgIctDXqBp3jLSWiPfhPI=;
        b=a6N6Iwfvz2eb+dAhRb9T2P2ICLBkND4HiE5bnS1Pg0zN+RVwDulQ+WueDBRFLipXyG
         KkXgejqzT+5Y7TZVUP2bEERHdAkV6oaENvbLn4plIwz36iWibAoLFAGnqnBdHa/Xwx/P
         xDmIR91WyxMfIPH5NnPK1no/g4UlllrMCGStE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qtTKxVuRz9/dx6KeO5dCjTblArzr2cCs0kqkaCJ0ykO0CAI6yeDvQyGdiHH3H7sVaJ
         cLR47f8/SchVCDrasXC062AKp5cbg+KMw1q46fxYYfsyaScoU5iVNFBLyKCDdoVaZJFO
         Jx3HQsXh34IWCjCon3IT8zcvM2BpMVSLd2oLo=
Received: by 10.204.20.143 with SMTP id f15mr1853899bkb.173.1304890682198;
 Sun, 08 May 2011 14:38:02 -0700 (PDT)
Received: by 10.204.101.132 with HTTP; Sun, 8 May 2011 14:38:02 -0700 (PDT)
In-Reply-To: <BANLkTi=nTSf0CQWs-ODxw=P+eX=Dc7Yf-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173184>

On Sun, May 8, 2011 at 19:03, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> Heya,
>
> On Sun, May 8, 2011 at 14:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> This adds skeleton no-op functions to git-sh-i18n.sh analogous to th=
e
>> gettext.c skeleton functions for C, adds *.sh scripts to the "pot"
>> target for message extraction, and updates the git-sh-i18n--envsubst
>> tests to use the new test_i18ncmp function.
>
> I seem to remember there were some concerns about performance with a
> previous version of this series. Have you done any before/after
> timings on, say, the git test suite? Or am I remembering incorrectly?

When I benchmark this on my (Linux) system it runs at 0% difference
between the current test suite and the one with this series.

The concern was about Windows, where forks are more expensive, so
e.g. every time we shell out to sed/awk/perl/grep or
git-sh-i18n--envsubst we incur a larger speed hit than on Unix
systems.
