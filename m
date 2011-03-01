From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 15:46:46 -0500
Message-ID: <AANLkTi=UX7VNH+biFgn0FQawP-ttCjW2D7SMf2n6XB6w@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
 <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
 <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
 <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
 <20110301194428.GD10082@sigill.intra.peff.net> <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
 <20110301200805.GA18587@sigill.intra.peff.net> <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
 <vpqmxlea7w1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuWTR-0005JL-W0
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab1CAUrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 15:47:08 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56986 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208Ab1CAUrH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 15:47:07 -0500
Received: by vws12 with SMTP id 12so4550184vws.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 12:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=DZQs3tgaQr29/u34nBDL+PfB5aeaKWVXl8KZ6eWJaL4=;
        b=Wv4kdMxMFlgRWfYYN/YMY+K1mUvuKK7N4AV6AXVOFObUlpY81EXwNVkdw0tdzRD+8U
         xOM3epkSIX7en/06m9lvVwLqwF/60DrPO3bzDrxEzHYcr+r91nhJZg/Z/bz2giorOdyw
         MJr5J0Ut73vdEBixk4cPGqL1A30sFWZLhOBS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pID1bF0qfaueRa8ov5nXd64p8S73rtSsmKt+IQrY4FRgC9gZFpkHsJJc8tw4F7aHlt
         w6+0VTH2J2LlKtdiEBJF63kE3r49LEWaJT+symAoGvvUEDsLUZWtaG8J8Vt3078ld5wq
         sgAIsS4vV3iV96R4xVVVGsXfn1H+NlMYTut4E=
Received: by 10.220.178.13 with SMTP id bk13mr1007748vcb.145.1299012426151;
 Tue, 01 Mar 2011 12:47:06 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Tue, 1 Mar 2011 12:46:46 -0800 (PST)
In-Reply-To: <vpqmxlea7w1.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168257>

On Tue, Mar 1, 2011 at 3:43 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Chad Joan <chadjoan@gmail.com> writes:
>
>> I'll do that, but it will probably take a long long time for me to s=
ee
>> the patch. =A0I'm hoping there's some cheap hack I can use to work
>> around it in the meantime.
>
> I'd say grep for "rmdir" is Git's source code, and replace the calls
> with a wrapper that does roughly
>
> rmdir_wrapper(dir) {
> =A0 =A0 =A0 =A0rmdir(dir);
> =A0 =A0 =A0 =A0if (stat(dir, &buf))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chmod(dir, buf.st_mode | 0777);
> }
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>

OK, I'll try that when I get a chance.

- Chad
