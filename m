From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-svn and mergeinfo
Date: Wed, 31 Aug 2011 15:59:26 +0200
Message-ID: <CAGdFq_h+KjWQUwwLdaqA-0j0p1zQznZkNNEVgfS46_o-Zfr3oQ@mail.gmail.com>
References: <20110829132052.0ad7a088@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 31 16:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QylKx-0000E4-BI
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 16:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab1HaOAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 10:00:08 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:45684 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1HaOAH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2011 10:00:07 -0400
Received: by pzk37 with SMTP id 37so1359715pzk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vqlkEAV/UwKMTOSPZ4DIC9eJ88T/m3CfsEv7ANLSTWA=;
        b=YI9445UAYlTRnoglz6MhSzB0vcRiwR/zlP53w4t3V+k1JTlg6Ks8TOc+cmJSnp+VF6
         dDqFB9comnBKD/W9WtVR/ok3qp2wQyPaKtLeOWDnTReGZuM5Wijt1BHYsDZb/x0qNsbx
         PbM/IvhiJC+I2xPPbrp4sDdLCg1RQfhJ45D3E=
Received: by 10.68.28.103 with SMTP id a7mr584785pbh.160.1314799206352; Wed,
 31 Aug 2011 07:00:06 -0700 (PDT)
Received: by 10.68.55.7 with HTTP; Wed, 31 Aug 2011 06:59:26 -0700 (PDT)
In-Reply-To: <20110829132052.0ad7a088@robyn.woti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180470>

Heya,

On Mon, Aug 29, 2011 at 19:20, Bryan Jacobs <bjacobs@woti.com> wrote:
> Apologies if this is not the right forum for bug reports. I was unabl=
e
> to find a Bugzilla/Redmine/Flyspray instance for issue maintenance, n=
or
> some "proper procedure" on the git web page.

This is indeed the correct way of reporting bugs :).

> However, to make this work with git 1.7.6, I needed to make *one* cha=
nge
> to the git internals: --merge-info does not allow setting mergeinfo f=
or
> more than one branch. Because it's a complete overwrite operation
> instead of an update, this is a serious issue preventing its use for
> nontrivial branches.
>
> Might I suggest adding a block like the following around line 552 of
> git-svn?
>
> =C2=A0 =C2=A0if (defined($_merge_info))
> =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$_merge_info =3D~ tr{ }{\n};
> =C2=A0 =C2=A0}
>
> This will replace any spaces in --merge-info with newlines, allowing
> specification of an svn:mergeinfo that contains merges from more than=
 a
> singe branch. So the user can provide "--merge-info
> '/branch1:r2323-3849,r8888 /branch2:r9999'" and the like.

Why not submit this as a proper patch [0] to the list, I reckon Eric
(cc-ed, the maintainer of git-svn) wouldn't mind including it.

> Thank you for your consideration. I am not subscribed to this list, s=
o
> if there are any replies, please copy my address.

That's the policy on this list anyway :).

[0] http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3DDocumentation/S=
ubmittingPatches;hb=3DHEAD

--=20
Cheers,

Sverre Rabbelier
