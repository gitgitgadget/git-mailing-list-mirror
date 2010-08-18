From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 5/5 v2] autoconf: don't use platform regex if it lacks REG_STARTEND
Date: Wed, 18 Aug 2010 08:49:08 +0000
Message-ID: <AANLkTim0drguFeYZmOKOnkSL=BouNiHpBOaoTdT0EH7D@mail.gmail.com>
References: <mtranet.20100817145038.1501455151@telekom.at>
	<20100817214709.GB2221@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j6t@kdbg.org, git@vger.kernel.org,
	Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 10:49:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OleKh-000300-UA
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 10:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab0HRItK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 04:49:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61075 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab0HRItJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 04:49:09 -0400
Received: by iwn7 with SMTP id 7so428302iwn.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i1OfdIHdPZtK/4ga4JOAMcqgBgZmEHS7VoR+NaUocFM=;
        b=YSCKtYd8s8SclfUEXR3Khq0LcJR7zEchfkPJ+QQnJb2OP88Vcq6nVpa5hdEumZ7Pmy
         hZsKf+KqPxlfo6xXImWplsWRPRHQcht+TAGf23SbS17TwwD5LeskE1e2xU07Vao6cooC
         0E80UWQPSCvj76CtHDRWxp1RxJigFxhWDKTOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P6VnGs3Iij8oMwg0U4Sh18u1KiMg8ffZiz4YDGpg0OLTUX10WNDh14cKzItP8NsEWo
         PXns6Bduwb0hdi0K/h6bDdWkCrMOncrJqPYgu6tKscqlOsAJNfdVSNTMymAFl6x/3MaU
         MOyJgEnPZKmvvpmz7q5nH+19ltweWqyHzBaL0=
Received: by 10.231.17.140 with SMTP id s12mr8974721iba.49.1282121348829; Wed,
 18 Aug 2010 01:49:08 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Wed, 18 Aug 2010 01:49:08 -0700 (PDT)
In-Reply-To: <20100817214709.GB2221@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153817>

On Tue, Aug 17, 2010 at 21:47, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Good catch. =C2=A0Warning: I only tested the following with glibc.
> Testing on platforms with missing or ancient regex support would
> be very welcome.

I tested it on Solaris (which I should have done in the first place),
there it sets NO_REGEX=3DYesPlease as expected as Solaris doesn't have
REG_STARTEND.
