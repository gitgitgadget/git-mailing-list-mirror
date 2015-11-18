From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [BUG] gitk --all and git bisect visualize crash in non-english
 locale
Date: Wed, 18 Nov 2015 22:53:19 +0100
Message-ID: <1447883599.28206.1.camel@kaarsemaker.net>
References: <vpqa8qbrwgc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 22:53:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzAfP-0004yd-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 22:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999AbbKRVxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2015 16:53:23 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36619 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbbKRVxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 16:53:22 -0500
Received: by wmww144 with SMTP id w144so215420515wmw.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 13:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=bxyTyKsVytDdEDIUrgTDJowYyDdw9t24JdTZAzcK70w=;
        b=TGbXk4zVKbL83+uFUinxESbpnHdY7eW6IQotbGVefQw4X1XRy5jNQloYfPqfNbpN1O
         pbYntKjD9153AoS/e1U0yoxR/YKcirboPwSVKjreh2ssmyxw28SJdBleWPKoG32MnIYt
         8Q0igesy6WCCh4ohOksGItS7PayV8kR1Aup8HjtfcswK6Hqjdb2awFWcxgEtQXeK9wfn
         a4muNzCfTxMPPfohFg/2L1SfKJh2xSORE+4Yw70eqYVyxdaCda+vmnGkGG5ABHF3R9WI
         /vIVlENcEgC6vhMs3URqL+mhiz0lsJ5HW9rtqR8hETi7Wv4Gy1KCgInDtyBNBhw09U2j
         g/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=bxyTyKsVytDdEDIUrgTDJowYyDdw9t24JdTZAzcK70w=;
        b=KUyIAz7lucMZDVjKTy6stHW9rlZsqD+ePlFfh+redm4aFS1+jU6FOyCTDQcJXSWhJp
         TWgZJ7LxwxumRHXm0Es3JFHbzkrCWPG0qduj65AtvMRD5Z8ukTrQktEy3hy/w1A8Mw4z
         frKMWwb4rHd0JxhU0upatNWabAtipGzJomLYMvUNVB6rZK+fz3scxIY+HEgdr+YOtekF
         pTFU+AoIPjYNhwWhbppjjDhtr2PpnuqJ7nyRSp54k3f4fP1cHZv7hfRnkFLWZbbSBx4Q
         6n/R6gttUvq75p+GyeI21gUrYuL3RI0Gu69jUMtliC6SzMCiRx/MC0cPHFXnlYAQGuUp
         RmAQ==
X-Gm-Message-State: ALoCoQmoFZbVZqiKxrDgWK4ORdauLFhP+o6JAKfKdfXrAexAmQ9D5+6chs35kmdzu2GxTGpD0GHp
X-Received: by 10.194.202.163 with SMTP id kj3mr4190704wjc.93.1447883600991;
        Wed, 18 Nov 2015 13:53:20 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id lf10sm4771890wjb.23.2015.11.18.13.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 13:53:20 -0800 (PST)
In-Reply-To: <vpqa8qbrwgc.fsf@anie.imag.fr>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281461>

Hi Matthieu,

This has been reported quite a few times before. A fix is in master,
see 482456a^2 and children.

On wo, 2015-11-18 at 19:31 +0100, Matthieu Moy wrote:
> Hi,
>=20
> I'm getting the following crash on recent gitk:
>=20
>   $ LANG=3Dfr_FR gitk --all
>   Error in startup script: bad menu entry index "=C3=89diter la vue..=
=2E"
>       while executing
>   ".bar.view entryconf [mca "Edit view..."] -state normal"
>       invoked from within
>   "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd
> ne {}} {
>       # create a view for the files/dirs specified on the command
> line
>       se..."
>       (file "/home/moy/local/usr-jessie/bin/gitk" line 12442)
>=20
> It's linked to the locale:
>=20
>   $ LANG=3DC gitk --all
>   # Just works
>=20
> but does not seem to be related to French in particular nor to the
> accent:
>=20
>   $ LANG=3Des_ES gitk --all
>   Error in startup script: bad menu entry index "Modificar vista..."
>       while executing
>   ".bar.view entryconf [mca "Edit view..."] -state normal"
>       invoked from within
>   "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd
> ne {}} {
>       # create a view for the files/dirs specified on the command
> line
>       se..."
>       (file "/home/moy/local/usr-jessie/bin/gitk" line 12442)
>=20
> It also works fine without --all.
>=20
> It bisects down to:
>=20
> commit d99b4b0de27a2bd654a40353b65883e368da6d06
> Author: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> Date:   Wed Sep 9 15:20:53 2015 +0200
>=20
>     gitk: Accelerators for the main menu
>    =20
>     This allows fast, keyboard-only usage of the menu (e.g. Alt+V, N
> to open a
>     new view).
>    =20
>     Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>     Signed-off-by: Paul Mackerras <paulus@samba.org>
>=20
> I'm not fluent enough in Tcl to fix this myself, sorry ;-).
>=20
> Thanks,
>=20

--=20
Dennis Kaarsemaker
www.kaarsemaker.net
