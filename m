From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] git-am: print fair error message when format detection 
	fails
Date: Tue, 14 Jul 2009 09:10:41 +0200
Message-ID: <cb7bb73a0907140010o42e9d67di8e871dccb8b41ed4@mail.gmail.com>
References: <beef9dfceed12f279bc27fbecf82118761cada49.1247553436.git.ni.s@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <ni.s@laposte.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 09:11:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQcAS-0004L2-1r
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 09:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbZGNHLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 03:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbZGNHLE
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 03:11:04 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53444 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbZGNHLC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 03:11:02 -0400
Received: by fxm18 with SMTP id 18so2627029fxm.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nXuhELtA+rfHK1o3lK7o+2Vv43K8hchm9L4bw3G3qQU=;
        b=HIV0W5fFaME7qGMtFkLtsaEg1VmQUtNhfY6lAsfWxC+jc1qQqOgDWrC7S8jQVp3sRd
         9QWSr3RmrfPE3QxAJbNZ74cbYqMjq9n5Xm1lKvc108m8M8ByPo5wT55reFObS2XM/UWE
         96j8ZrgFqkzTGXak/cPzjz1LzUj6tVycO2jLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZCpW3axU+2LiO2KtebV/LVkrXeRZRljt75mm/kCayy2005abPBeeKFRql5YEKznrFr
         j1D2xNK0O6uKmfwN/ZeXt3xLp41/6hOKOWAs8KZl63UjuplDuIgE2KFNwe3NF5UNNrIF
         TQj1GzF3LHTGyEVq0p+Uvm/9QxT8lwlACkC6o=
Received: by 10.204.52.146 with SMTP id i18mr6026196bkg.82.1247555461386; Tue, 
	14 Jul 2009 00:11:01 -0700 (PDT)
In-Reply-To: <beef9dfceed12f279bc27fbecf82118761cada49.1247553436.git.ni.s@laposte.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123223>

On Tue, Jul 14, 2009 at 8:39 AM, Nicolas Sebrecht<ni.s@laposte.net> wro=
te:
> Avoid git ending with this message:
> =A0 =A0 =A0 =A0"Patch format =A0is not supported."
>
> Signed-off-by: Nicolas Sebrecht <ni.s@laposte.net>
> ---
> =A0git-am.sh | =A0 =A06 +++++-
> =A01 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index d64d997..ca73c88 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -254,7 +254,11 @@ split_patches () {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msgnum=3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;
> =A0 =A0 =A0 =A0*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clean_abort "Patch format $patch_format=
 is not supported."
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -n "$parse_patch" ; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clean_abort "Patch form=
at $patch_format is not supported."
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clean_abort "Format pat=
ch detection failed."

"Patch format detection failed" maybe?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;
> =A0 =A0 =A0 =A0esac
> =A0}
> --
> 1.6.4.rc0.121.g2937a.dirty



--=20
Giuseppe "Oblomov" Bilotta
