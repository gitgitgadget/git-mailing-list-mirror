From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use "--no-" prefix to switch off some of checkout 
	dwimmery
Date: Mon, 19 Oct 2009 08:12:13 +0200
Message-ID: <81b0412b0910182312h583e74e4v2678eb4375164c34@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
	 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
	 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
	 <20091018210222.GA5371@blimp.localdomain>
	 <7vzl7omi5z.fsf@alter.siamese.dyndns.org>
	 <81b0412b0910182307n53b4a51cvaa14829ea8b40207@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzlTg-0000uP-Oo
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 08:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbZJSGMK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 02:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbZJSGMK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 02:12:10 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53032 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbZJSGMJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 02:12:09 -0400
Received: by fxm18 with SMTP id 18so4632959fxm.37
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 23:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AyBBIgWsl5h+ibmIDcFpLyvH2aAMsaDhloqoxaIeCTg=;
        b=BqCio/S1SP7m1FT5cIC6XUJZQBYn9/mKrXIQaykByTws0NybFtlHtVJW8iVAZemP6g
         RfQFT78E9vVTDn0SKAwGKcbsxOdceysnyZ76sjnKsXvKCJxxH2rDssVvaG1qIVcRkAML
         cQ2clzhz34iZ66T8wsilDmRw2HYrGgJfS3NQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZHYU/5lu1dr5z+h7vpR9RNtuiuGroa4Gvyrio29WAGONWeVbCmwTaqSaHPPh45kTML
         VHVxa6H+C5Q/Nh6LA4DYjefNYMBc7VaYu/CvbOCZs48SpAyGyHP7au6qbxbCj97codi+
         8/DoMQ+DALuGQthDGQ2z/78uYUxVYFvmv16xs=
Received: by 10.204.49.68 with SMTP id u4mr4348795bkf.42.1255932733125; Sun, 
	18 Oct 2009 23:12:13 -0700 (PDT)
In-Reply-To: <81b0412b0910182307n53b4a51cvaa14829ea8b40207@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130657>

On Mon, Oct 19, 2009 at 08:07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Mon, Oct 19, 2009 at 00:49, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_SET_INT(0, "dwim", =
&dwim_new_local_branch,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "Guess local branch from remote reference (default)",=
 0),
>>
>> Humph, how does SET_INT know to set it to 1 with --dwim and set it t=
o 0
>> with --no-dwim?
>
> It seems to do, though (I checked before sending).
>

Right, just looked at the parse-options: it is defined for all types.

parse-options.c +/get_value

	const int unset =3D flags & OPT_UNSET;
=2E..
	case OPTION_SET_INT:
		*(int *)opt->value =3D unset ? 0 : opt->defval;
		return 0;

Very useful.
