From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: remove duplicate code and not needed break statement
Date: Mon, 19 Jul 2010 17:43:34 +0200
Message-ID: <AANLkTimHHJnvgFh3Kd7jMqTJJFensZjkD7YCU1gdt-FT@mail.gmail.com>
References: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 17:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OasVL-0002To-5I
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 17:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936195Ab0GSPng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 11:43:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56151 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936160Ab0GSPng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 11:43:36 -0400
Received: by wyb42 with SMTP id 42so4511524wyb.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=1eAtAK6whRT/oXJU7bsoLgHD16XAKGapxQG+IgcGM20=;
        b=b17vjpqA9vCC49yn6QMbssTZRd8xlfE3fVIrWApWwIUrMELbRF7tOvo/mD/xD62FAq
         0kpcJygpJL7MNtg8fr1bru9rsGSnVGZR/KBqrLVzdwtDZSVZAV6punsk82bZKBhO6n8g
         9b6RlHqaf8n1Betd3jNVS0kHPZy7Ay1UtHwcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=MKrI2TEj/rItVQZiIqQQLHNHfohG3C8nB+yNj+fyQjXbZyOVb9TPKSzhX5QONOKDwx
         fsPjA3DjFBsVUqnPYKjs34KOS337usjhQ0FXp/D0/c4Wu6CavkDxTasDfTCCQzM9TySI
         vKU5XIlElZV5aDSqFRAYIXuNFxQhGPpdxi9Ss=
Received: by 10.216.203.71 with SMTP id e49mr4051249weo.60.1279554214568; Mon, 
	19 Jul 2010 08:43:34 -0700 (PDT)
Received: by 10.216.63.145 with HTTP; Mon, 19 Jul 2010 08:43:34 -0700 (PDT)
In-Reply-To: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151251>

On Sun, Jul 18, 2010 at 7:49 PM, Ralf Thielow
<ralf.thielow@googlemail.com> wrote:
> Remove duplicate code and not needed break statement.
>
> On switch statements you can use multiple cases for one
> statement and on a goto statement you not need a break.
>
> From 5b3e7c8f8b81a295b5c58534be250f5a818ccc64 Mon Sep 17 00:00:00 200=
1
> From: Ralf Thielow <ralf.thielow@googlemail.com>
> Date: Sun, 18 Jul 2010 18:48:58 +0200
> Subject: [PATCH] remove duplicate code and not needed break statement
>
> ---
> =A0server-info.c | =A0 =A03 ---
> =A01 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/server-info.c b/server-info.c
> index 4098ca2..9ec744e 100644
> --- a/server-info.c
> +++ b/server-info.c
> @@ -113,11 +113,8 @@ static int read_pack_info_file(const char *infof=
ile)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto o=
ut_stale;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 'D': /* we used to emit D but tha=
t was misguided. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_stale;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 'T': /* we used to emit T but nob=
ody uses it. */

We have a tendency of adding a comment pointing out fall through
between case-statements. Perhaps you should add one? 'git grep -i
fall.\\?through' shows you some of the places we've got it now...

--=20
Erik "kusma" Faye-Lund
