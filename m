From: Jonathan del Strother <jdelstrother@gmail.com>
Subject: Re: Expected behaviour of 'git log -S' when searching in a
 merged/deleted file?
Date: Thu, 23 Dec 2010 17:27:39 +0000
Message-ID: <AANLkTinS6i0K4MMdr_E94ig-V3oMFZ+L7N=mqn0S3Y7T@mail.gmail.com>
References: <AANLkTimXk6ei6EAQfvTTfnMzdBqYHkNoaxkEab+atnHd@mail.gmail.com>
 <7vzkrx4qp6.fsf@alter.siamese.dyndns.org> <AANLkTim4z3XvpjnEERuXgTE6CtA7D-dnBxSUgO3mE-FM@mail.gmail.com>
 <7vwrn0328p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 18:28:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVoxR-0006qt-L3
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 18:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0LWR2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 12:28:00 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38559 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab0LWR17 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 12:27:59 -0500
Received: by qwa26 with SMTP id 26so6440420qwa.19
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 09:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wXXo87xZCa5iAh83RpCSkQFGXbDw2oBmLT0dFTJn6N0=;
        b=mrrkSjiJnEQJr/kPM/dh3oSXWQWT/TDjybNmtPw0F4VVhPvWUTtbrjbeMxNCa3xvpX
         ZenDaLyeI1qliEKo0iDSVhoNB3V3XhZvhu7BqdtqtIvA6Kv1imDk9evgcTp9A2bR7JBf
         HRgG+eI8qPhmbp1UusgpawwyE6ohM8JhaP6sE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SuyLNiERwQDsBaEc8y1Dpf/xHwS3m8PTx6Os/l81tczz+9MNRfhoD9W1X0ZqK+93i3
         NzJyPx+PBDn1JD2B5tdmswjbnrksVnxyB3PSAoGPIcttKNS94yW1G8nhWDzNfmpJe5e0
         B9iEhpIBOfETSrfKSHNdcsFZyupxKlABHPXZ4=
Received: by 10.229.217.212 with SMTP id hn20mr6947688qcb.225.1293125279154;
 Thu, 23 Dec 2010 09:27:59 -0800 (PST)
Received: by 10.229.86.201 with HTTP; Thu, 23 Dec 2010 09:27:39 -0800 (PST)
In-Reply-To: <7vwrn0328p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164135>

On 23 December 2010 16:03, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan del Strother <jdelstrother@gmail.com> writes:
>
>> .... =C2=A0If 'needle' was added
>> and removed within the duration of a single branch, I could understa=
nd
>> "git log -S" never finding 'needle' due to history simplication, but=
 I
>> don't understand how simplification applies here.
>
> Ahh, sorry, I misunderstood the scenario. =C2=A0Just like you do not =
see a
> patch output from "log -p", the diff machinery (including -S and its =
newer
> cousin -G) does not kick in by default for merge commits (this is a b=
it of
> white lie as "log -p" defaults to "combine diff", i.e. be silent on a=
ny
> uninteresting merge that takes its results literally from either pare=
nt).
>
> Please try it with "-m" (not "--full-history"). =C2=A0We _might_ want=
 to change
> this behaviour for -S/-G but it needs a bit more thought.
>

Yep, '-m' produces the expected (or at least, *my* expected) results.
