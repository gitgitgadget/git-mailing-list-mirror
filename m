From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 20:41:25 -0500
Message-ID: <CAPig+cRCKQ8Vpr11XB-MSNsjDXjMHstaEAz333nMZxuKC8xmEg@mail.gmail.com>
References: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
	<1455671495-10908-2-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 02:41:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVr7S-00022J-EC
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 02:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbcBQBl1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 20:41:27 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34852 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964799AbcBQBl0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 20:41:26 -0500
Received: by mail-vk0-f48.google.com with SMTP id e6so1905179vkh.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 17:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Dxwyr7eqIkI7+pGuzRKa4VAJ+yAdc0vClFFBmwBixkU=;
        b=Iz1bZeGBLiAZ8NREZRJd1yv4dPWFU8kk9IjRJF1rgWRGyfqUQ8OSWtjzQYw29OGHoY
         0wJwCmgTMN9+JmkfMKKh07kqTAuPzEbpQkaAbUQzsb4Nb2Ms58aYCSc+JZZ88retWOno
         zxK5h91C3DXMEktbkXWCet2x0JkMeCjCqc/mxFQcZ5O6YSYNCc2eH/phNycJ1qDm2EeW
         5SI+u1+iPJtpsjmwyX655UW5F1jhEwrAupNSCCET9TV6TDARUOUc13Bty8hg8XMKRwyv
         hCnANvUAjAtbCFTNJwyGxIlZ4GynKUxzat3oqgo+A0LDuHV/SrDC6xpgpPiaX/cl6td8
         fgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Dxwyr7eqIkI7+pGuzRKa4VAJ+yAdc0vClFFBmwBixkU=;
        b=NrAjsaiEfUJ2sH74GqXZY6QXwRamQyd7tAVn7VrkFrJGaI6e8BRpwPRQ/iLtdQfwNw
         q1qXKPYeFkqcE/TI9cdeES3yaVV4pOKhP1OqokLyEXuaqnrzcFMMdRIU2C4uWfSBuR+C
         hYTvcjnl+x9W26GekSnVUC8MV404HxULXRyUBfOy1NNAar45UyK73yHRAXDvKjt1qDDP
         eT91ZPSNkyrIb0WkE6d5IgxcB84Gso5t0GGPD6x3XxftnyalNXAKQWk52LJ81QC6XwRF
         DE7avDICFjrnDLvCrcG8Cc7c9clFtCcWYux71/m0EPGpJC5oRF8GcAc7CBx+UsvSFM+R
         ZgTw==
X-Gm-Message-State: AG10YOTurcSO0go7FCAleM94qVluL3qjRzzKkUXgnp2Y6P0/36htr+boRm+FUfTIIAmAMEV6l6GACBjH9e43Cw==
X-Received: by 10.31.41.14 with SMTP id p14mr21228590vkp.151.1455673285709;
 Tue, 16 Feb 2016 17:41:25 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 16 Feb 2016 17:41:25 -0800 (PST)
In-Reply-To: <1455671495-10908-2-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: -WZNJRjChzQzFa8LHpolmCqsbKI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286473>

On Tue, Feb 16, 2016 at 8:11 PM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> The recursive strategy turns on rename detection by default. Add a
> strategy option to disable rename detection even for exact renames.
>
> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
> ---
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge=
-strategies.txt
> @@ -81,8 +81,14 @@ no-renormalize;;
> +no-renames;;
> +       Turn off rename detection.
> +       See also linkgit:git-diff[1] `--no-renames`.
> +
>  rename-threshold=3D<n>;;
>         Controls the similarity threshold used for rename detection.
> +       Re-enables rename detection if disabled by a preceding
> +       `no-renames`.

I'm not sure that it is necessary to mention the "last one wins" rule
here, but if you do so, does --no-renames documentation deserve
similar treatment?

>         See also linkgit:git-diff[1] `-M`.
