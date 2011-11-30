From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH] git-gui: Set both 16x16 and 32x32 icons on X to pacify Xming.
Date: Tue, 29 Nov 2011 19:02:29 -0500
Message-ID: <CAJYzjmcsGQ8xxmOEvDCZGyT5e=gKkjC7fDxdcbNg4FZRddERpw@mail.gmail.com>
References: <1321640015-6663-1-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 01:02:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVXdS-0007YD-78
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 01:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190Ab1K3ACd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 19:02:33 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47310 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045Ab1K3ACa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 19:02:30 -0500
Received: by eaak14 with SMTP id k14so3803876eaa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 16:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VlExLFFvwlgShHbdCRbH9h6nG2AKeQW2ejQoLy2dRD8=;
        b=QLeTzYOU9Ub5eUTe4olX5LGUTBZc0xJe0302S08D84RNUyUGOnUChe/wFnagWjwKEz
         XhVjyPL1viqI2w5DnvUtAmZwkudiP+Kx52tPnq5V4vadtZuH0FCqhWfjpNdmyE0ejQiw
         vQ2XUZ5szM5xBY1p+dq+N48WIOOp0zn+sRyV4=
Received: by 10.180.104.35 with SMTP id gb3mr49488wib.11.1322611349196; Tue,
 29 Nov 2011 16:02:29 -0800 (PST)
Received: by 10.180.103.228 with HTTP; Tue, 29 Nov 2011 16:02:29 -0800 (PST)
In-Reply-To: <1321640015-6663-1-git-send-email-naesten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186096>

On Fri, Nov 18, 2011 at 1:13 PM, Samuel Bronson <naesten@gmail.com> wro=
te:
> It would be better if the 32x32 icon was equivalent to the one used o=
n
> Windows (in git-gui.ico), but I'm not sure how that would best be don=
e,
> so I copied this code from gitk instead.
> ---
> =C2=A0git-gui.sh | =C2=A0 =C2=A07 ++++++-
> =C2=A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index c190cbe..9d01039 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -729,7 +729,12 @@ if {[is_Windows]} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gitlogo put gr=
ay26 =C2=A0-to =C2=A05 15 11 16
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gitlogo redith=
er
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wm iconphoto . -de=
fault gitlogo
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: should use=
 something equivalent to the 32x32 image in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the .ico file
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 image create photo=
 gitlogo32 =C2=A0 =C2=A0-width 32 -height 32
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gitlogo32 copy git=
logo -zoom 2 2
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wm iconphoto . -de=
fault gitlogo gitlogo32
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}

Hmm. Nothing seems to have happened with this patch yet. Any
suggestions on how to bring it to the attention of the git-gui people?
