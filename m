From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] git-am: less strong format "mbox" detection
Date: Tue, 14 Jul 2009 09:16:24 +0200
Message-ID: <cb7bb73a0907140016r4807c008h9c98f76200e9c3a5@mail.gmail.com>
References: <bb3a84e2b817268a88832dc7043383e4b91a3df3.1247553623.git.ni.s@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <ni.s@laposte.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 09:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQcGB-0006Cm-5i
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 09:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbZGNHQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 03:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbZGNHQq
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 03:16:46 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:62607 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbZGNHQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 03:16:45 -0400
Received: by bwz28 with SMTP id 28so594745bwz.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=B0nWJWnIXG5xbWOKohBB4QVThXC69GDvoMDuf8DoEt4=;
        b=L9Fi+e3uaG0W+iDTvnesKTedlJOltK24ErgpDL1NCsMvcOPIUbL9WkaeZ8+bH3Xdj2
         hNwiHMfIR46HsgSFNKm4lPoHPy5/yhBN3Iv9ZVj1zsRp233HGtIBIsyXjMIwTvdRkDok
         IlS38zVpKs3wOqq4e2biEvUdi5V1ieR4w6sfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xb3rk2Hf4ftF/PfSeC09qNBNxVgeQ27ISKUnkcFNion/BH+Li3HA5xbXDrzy2h6HPy
         s+wlL5seg6SrbBzRk24fcnigDTD1VQTm7XS4PEOYIPck44CsdOgQikFiorvhWHzlc8Gt
         0wuVwakJcayKMWp0rpcxFZSDKrNphodArB9AM=
Received: by 10.204.62.68 with SMTP id w4mr6075399bkh.93.1247555804145; Tue, 
	14 Jul 2009 00:16:44 -0700 (PDT)
In-Reply-To: <bb3a84e2b817268a88832dc7043383e4b91a3df3.1247553623.git.ni.s@laposte.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123224>

On Tue, Jul 14, 2009 at 8:40 AM, Nicolas Sebrecht<ni.s@laposte.net> wro=
te:
> Thunderbird (v1.* at least) likes to start e-mails with "X-Account-Ke=
y:".
> Also, I have some emails starting with "Return-Path:" or ""Delivered-=
To:".
>
> Signed-off-by: Nicolas Sebrecht <ni.s@laposte.net>
> ---
> =A0git-am.sh | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index d64d997..d10a8e0 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -169,7 +169,7 @@ check_patch_format () {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read l2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read l3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case "$l1" in
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "From "* | "From: "*)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "From "* | "From: "* | "X-Account-Key:"=
* | "Return-Path:"* | "Delivered-To:"*)

Nitpick: for consistency, should we either expect a space after the
colon also in the new keys, or not expect i in the From: key either. I
don't think the RFC requires a space, but most clients probably add
it.

--=20
Giuseppe "Oblomov" Bilotta
