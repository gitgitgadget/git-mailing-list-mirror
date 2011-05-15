From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] Submodules: Don't parse .gitmodules when it
 contains, merge conflicts
Date: Sun, 15 May 2011 12:00:45 +0700
Message-ID: <BANLkTim_J7gW1rW+yO74ETEjFcHhyArBRg@mail.gmail.com>
References: <4DCEACF8.50503@web.de> <4DCEAD52.60707@web.de>
 <BANLkTinvkxDYqNs3Pv0CniGtAHm5dJf0wg@mail.gmail.com> <7vfwoh5fom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 07:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLTSI-0004QV-A8
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 07:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab1EOFBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 01:01:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48749 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1EOFBQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 01:01:16 -0400
Received: by bwz15 with SMTP id 15so2993113bwz.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 22:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Xzm2h/R4OfCKGp+qYvz2j7goeipO/zEcOBRYPfK2k6w=;
        b=J9aA/bvPGyIrgmHnMqWcFiWp5SdduGP93tyh4x+tn6Hus8j0+aH7Kgng3iBA551Nyt
         8DCOOSvb96MWUGwsm1PC/6PW8WgrMyulmRCLawnJB3PXQuHtTq20MWOhQMJZTxo7ReYN
         I/sARuhjsJZo4efqeqw7Fh2AYA1Vs/8NNN8o0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iTHmGcsps2B8EUz4uRzbHC50hCbkxtdDngLp5ReAHqhzOuuASxgeNM7IVKphP953gK
         L2mg+sijqPCjWMyOSDQswZnGy/xCsypgpIQvdx9ttwypUErXmJmoFHRVNCxDilTlZTzW
         Airlboq47tsvLqZIbE2KLRrXp1fKQmJ502wUo=
Received: by 10.204.7.213 with SMTP id e21mr2734335bke.209.1305435675202; Sat,
 14 May 2011 22:01:15 -0700 (PDT)
Received: by 10.204.177.147 with HTTP; Sat, 14 May 2011 22:00:45 -0700 (PDT)
In-Reply-To: <7vfwoh5fom.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173621>

On Sun, May 15, 2011 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Sat, May 14, 2011 at 11:26 PM, Jens Lehmann <Jens.Lehmann@web.de>=
 wrote:
>>> Commands like "git status", "git diff" and "git fetch" would fail w=
hen the
>>> .gitmodules file contained merge conflicts because ...
>>
>> Side note. .gitattributes and .gitignore likely suffer the same.
>> Perhaps the unmerged check in this patch can be generalized for reus=
e.
>
> I am somewhat skeptical about that statement. =C2=A0These files are d=
esigned to
> be one-entry-per-line so that useful information in the non-conflicte=
d
> parts in a conflicted file (which should be majority) can still be us=
ed.
> Only the .gitmodules is an oddball.

True for .gitignore. A line in .gitattributes is more complex, it's
easier to break the parser with conflict markers. Anyway unmerged
entries should not be used until they're cleaned up, or can be used
with a big fat warning.
--=20
Duy
