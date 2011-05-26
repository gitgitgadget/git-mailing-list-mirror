From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 3/3] git-mergetool--lib: Make vimdiff retain the
 current directory
Date: Wed, 25 May 2011 22:05:32 -0700
Message-ID: <BANLkTinWUK8NDDd3i7fRRTEXjSmTtMwL_Q@mail.gmail.com>
References: <1306381034-44190-1-git-send-email-davvid@gmail.com>
	<1306381034-44190-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?RnLDqWTDqXJpYyBIZWl0em1hbm4=?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 07:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPSlS-00046O-Pl
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 07:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab1EZFFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 01:05:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63494 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1EZFFd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 01:05:33 -0400
Received: by pwi15 with SMTP id 15so180715pwi.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 22:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w7ppw67Zb/W4CHq3kwm+ybJVRDcrjUl2em9pdH+UNKw=;
        b=PEc0BWGsGTjKi0ZzEv5jDPY+04thwBppxwlQ/EKuE+smH9qlYJmUDPjOURjzmxwuFv
         FKgsZz3HQUXH1XFSVwfpIoJ0qTYwDuKDB+gtrVf6qkG2pYeXwIzxyl81QIqQDgsDdptO
         oXotA16NXbUgDBkOAiqPBoFBkmYE5LP0PFYlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ggJF4L69/M4V9XYJkUOyVjXUWbRzurAFpNGCq/hNsdHCqqqrhl6Bkv5M8LNmzNqMji
         r+Smglp2L3A515y6Eox1IZKxM7MlKm2h4gPTKxD7DI59tytQM+Pp2kNmb7NPj+jOLRfG
         jyE7SFXI8pokOUHoxoWGu+ZeaYZXil9UKkN68=
Received: by 10.142.74.1 with SMTP id w1mr63085wfa.121.1306386332542; Wed, 25
 May 2011 22:05:32 -0700 (PDT)
Received: by 10.143.58.8 with HTTP; Wed, 25 May 2011 22:05:32 -0700 (PDT)
In-Reply-To: <1306381034-44190-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174494>

On Wed, May 25, 2011 at 8:37 PM, David Aguilar <davvid@gmail.com> wrote=
:
> +
> +resolve_git_prefix() {
> + =C2=A0 =C2=A0 =C2=A0 # If GIT_PREFIX is empty then we cannot use it=
 in tools
> + =C2=A0 =C2=A0 =C2=A0 # that expect to be able to chdir() to its val=
ue.
> + =C2=A0 =C2=A0 =C2=A0 if test -z "$GIT_PREFIX"; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_PREFIX=3D.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export GIT_PREFIX
> + =C2=A0 =C2=A0 =C2=A0 fi
> +}

Oops, I forgot to replace the function call with : GIT_PREFIX=3D${GIT_P=
REFIX:-.}
--=20
=C2=A0 =C2=A0 David
