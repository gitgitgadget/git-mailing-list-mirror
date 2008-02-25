From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Mon, 25 Feb 2008 21:29:22 +0100
Message-ID: <8aa486160802251229x778c7427nd51093bc23ec6c8c@mail.gmail.com>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
	 <7vlk58j0k1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjxb-0001hl-LQ
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbYBYU30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 15:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755712AbYBYU30
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:29:26 -0500
Received: from gv-out-0910.google.com ([216.239.58.184]:24143 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbYBYU3Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 15:29:25 -0500
Received: by gv-out-0910.google.com with SMTP id s4so683813gve.37
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 12:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1ygird5LDBzrZlXFYXibfy5EaWDY9Nx57TQ33CxSzho=;
        b=DPQ9BIETGfWmpuXgi/MbG0CyusCX6tV4zklXr5M0oE7y2highzq2XFoc1Nm4yP3Z7Goqy+SXd+jHLUCMDm70hdjO36t1LanyjhbWQCpUYTi/WJNb4icmg9t1K8q7+I2+2JgH4kpoxGrHDJm1xWA66efLir/rhvdKHXa+eP1C9/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EiO09ivA+KR3WAXNKTKq31V/tjET+6+86xMCjPOkbsGPoHxFxq50iWppsJ+mXEdnb3xvihmB7us6GVjO98xLiNVFPO4Ok6LEtNkEzlz95Kw5SvEl75+jDLMK0X3w+qsdquxU6n9Ctl+godrJ6Pm3n219zfWT6HCgLpzh3XaUSZI=
Received: by 10.151.9.1 with SMTP id m1mr1266591ybi.81.1203971362776;
        Mon, 25 Feb 2008 12:29:22 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Mon, 25 Feb 2008 12:29:22 -0800 (PST)
In-Reply-To: <7vlk58j0k1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75063>

On Mon, Feb 25, 2008 at 8:30 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
>  > Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
>  > ---
>  >
>  > Hi *,
>  >
>  >   while waiting for the C port of git-clone I've updated my patch =
to
>  > support bundles in "git clone".
>
>  I do not recall the v1 round of this patch, but it does not look
>  too bad.

Well, it was during the freeze, you probably had more important things =
to do :-)

http://article.gmane.org/gmane.comp.version-control.git/68035

>
>  I was hoping, however, if we can replace "git fetch-pack" there
>  with "git-fetch" so that you do not have to have the if
>  conditional based on "$repo"'s type.  Isn't "git fetch" capable
>  of fetching from a bundle already?
>

"git fetch" is capable to fetch bundles, but to use "git fetch"
instead of "git fetch-pack"
you need to reorganize other things (not the same output, to download
all the refs you need to write a config with refs/heads/*:..., "git
fetch" does not have a --no-progress), so I opted for
a minimal path (and not break the most used path :-).

I sent another patch to convert every transport to "git fetch" in:

http://article.gmane.org/gmane.comp.version-control.git/65669

but it had some problems (ups now I see I didn't answer to Johannes
Schindelin's reply, sorry, or I cannot find it). At the end as
git-clone was going to be ported to C...

Santi
