From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 3/4] git-am foreign patch support: StGIT support
Date: Wed, 27 May 2009 10:29:06 +0200
Message-ID: <cb7bb73a0905270129j375ac104yb9ca8601312ddbde@mail.gmail.com>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1243298290-5909-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <7v7i03j9mb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 10:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9EW6-0008Ip-KQ
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 10:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236AbZE0I3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 04:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbZE0I3J
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 04:29:09 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:61860 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbZE0I3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 04:29:08 -0400
Received: by fxm12 with SMTP id 12so2643533fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KWbe0PkrN2jLtHbBc8Eonh6KdZ6+SB+qpHsGED8ZJd4=;
        b=salNdjlWGn7Lvsqy+7sQuTgXknfOC08ALr8ciaW81CAOPcIhNI3Uc84cG/R9gXaXxf
         AW6nB7HX0imsENI1Nut1YnJinzC53bjOz+OkNfNyDCX9w0sQ+YTZHFEAmuXyPdmxORPA
         mhB4uEdscT23DaM+53/X0qGZJZ29WiGlTYaoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pUL9TrJUnusJZYIcsIi5+gB2Ajbwkr6+G9WMVE4Qhz8sMUza09Hde2XhHhrInu5obw
         yBEW4r9n4C85xo0KSi44vPkzuwIPGa7QWSAxmz2mChLDKHOG08wFyxI5GlwJMlTqiz/G
         tAaEV+76owaLh+Zdj2S6H8LS6KCPp8BlwhArs=
Received: by 10.204.112.1 with SMTP id u1mr8929667bkp.208.1243412946702; Wed, 
	27 May 2009 01:29:06 -0700 (PDT)
In-Reply-To: <7v7i03j9mb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120049>

On Wed, May 27, 2009 at 9:19 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 # set the patch format appropriately
>> + =A0 =A0 =A0 =A0 =A0 =A0 patch_format=3Dstgit
>> + =A0 =A0 =A0 =A0 =A0 =A0 # now handle the actual StGIT patches
>> + =A0 =A0 =A0 =A0 =A0 =A0 split_patches "$@"
>
> Can an stgit patch file (or the leading pathname for that matter) hav=
e IFS
> character in its name?

StGIT sanitizes filenames in a way similar to what format-patch does.

>> + =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> + =A0 =A0 stgit)
>> + =A0 =A0 =A0 =A0 =A0 =A0 this=3D0
>> + =A0 =A0 =A0 =A0 =A0 =A0 for stgit in "$@"
>> + =A0 =A0 =A0 =A0 =A0 =A0 do
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 this=3D`expr "$this" + 1`
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msgnum=3D`printf "%0${prec=
}d" $this`
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch "$dotest/$msgnum"
>
> Portability tip from an old timer: do not create a new empty file wit=
h
> "touch" (only use that command to update the timestamp of an existing
> file).
>
> Instead say
>
> =A0 =A0 =A0 =A0>"$dotest/$msgnum"
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # Awk version of StGIT par=
se_patch. The first nonemptyline
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # not starting with Author=
, From or Date is the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # subject, and the body st=
arts with the next nonempty
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # line not starting with A=
uthor, From or Date
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 awk 'BEGIN { subject=3D0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (subjec=
t > 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 print ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (/=
^$/) next ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (/=
^Author:/) print sub("Author", "From"), $ORS ;
>
> Can any token that match Author other than the initial "Author: " app=
ear
> on this line?

Irrelevant, sub only substitutes the first hit so only the initial
Author: is replaced.

> Since we rely on Perl but not awk in core-ish part of the scripted
> Porcelains, it might be a good idea to write this in Perl as well.

By 'as well' you mean in case awk is missing, and have both, or by
only keeping a perl version?

--=20
Giuseppe "Oblomov" Bilotta
