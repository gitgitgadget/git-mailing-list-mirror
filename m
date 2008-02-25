From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long format
Date: Mon, 25 Feb 2008 10:05:55 +0100
Message-ID: <8aa486160802250105p4f98cb6eu1d6ac4fa700f11fe@mail.gmail.com>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
	 <20080225023634.GK8410@spearce.org>
	 <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
	 <8aa486160802250034ncdf20b6s13856ca8612bc2ea@mail.gmail.com>
	 <7vbq65ju0y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 10:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTZID-0008E7-Oh
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 10:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbYBYJGB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 04:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbYBYJF7
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 04:05:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:34307 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbYBYJF6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 04:05:58 -0500
Received: by ug-out-1314.google.com with SMTP id z38so705841ugc.16
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 01:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IZZkAkMDPiOEKfr3cn/gsQ/FkqbVSIMwRnFVw/3R4os=;
        b=W70cvuMHLGqIrWojaoNlHzWzR6leGjBN0BwHbexo8Col6WGIjRHrO7hOB4VFgGdqWB7JT+BH6epvBWki/SBTNgf+KJHapQJsye6q9O0U0MKN4FfgvtgiW8KIGRaykc5m1C7eA2Th3OT8w3xTYm71Voacm26tIIeuKjvhGuU+Ei4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oUReivja747VTAPF0MYYM4SHXGn0P4CUWwFRgzaim1T2EXlrIFna8WytZdPww/v3pue7Qgv8M85y9SByjcDKq24RkAkPfdYx+OJLCHEeU5JvwI1wge1Nnhv2t3UXkrXuLrgQfM+hhmeobXyvlsUNFQurPLAyI5tuTXO8wC2wlUM=
Received: by 10.150.196.5 with SMTP id t5mr981509ybf.40.1203930355859;
        Mon, 25 Feb 2008 01:05:55 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Mon, 25 Feb 2008 01:05:55 -0800 (PST)
In-Reply-To: <7vbq65ju0y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75019>

On Mon, Feb 25, 2008 at 9:54 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
>  > On Mon, Feb 25, 2008 at 4:08 AM, Junio C Hamano <gitster@pobox.com=
> wrote:
>  >> "Shawn O. Pearce" <spearce@spearce.org> writes:
>  >> ...
>
> >>  > Is this really that useful?  Where is having the tag and the co=
mmit
>  >>  > SHA-1 both useful?
>  >>
>  >>  I had the same question.  The only place that I find this could
>  >>  be useful is when you tag, build and install, and then find
>  >>  glitches before pushing the results out and rewind, rebuild and
>  >>  re-tag.  I unfortunately have this issue almost all the time.
>  >>
>  >>  But even then, I would probably not rely on this patch.
>  >
>  > This can be usefull when more than one person can make "official" =
tags
>  > (or nobody), and then you have a uniqe idendifier with a descripti=
ve
>  > name.
>
>  That's backwards.  If you want reliable unique identifier, you
>  would use 40-hexdigit.  If you want human readable, you would
>  use tags, and if you allow different people to distribute tags
>  with the same name that point at different things, _you_ have a
>  problem at higher level.

Yes, I have a "problem" at a higher level, but I cannot "solve" it.
This patch "workaround" this "problem", we want all to be able to tag
and have descriptive and uniqe names. I think git should allows us to
work this way.

Santi
