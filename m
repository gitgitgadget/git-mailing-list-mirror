From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sat, 8 Jun 2013 09:44:45 +0700
Message-ID: <CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com> <1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 04:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul99r-0001Aj-G0
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 04:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930Ab3FHCpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 22:45:18 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:57032 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3FHCpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 22:45:17 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so4214842lab.6
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IvY86PO0u60yNAn9jvUopMTPVFXEB3xFFe4VVUtofvc=;
        b=SDAC1G0GOdssEpdsgdb71L90Me/GKNWNQvP5tNW57mkOKqcC40XIIOI2mZlosbrbBL
         H3M5vFhWYdnN9n/Pi5KUKZ1McLY9VA4LGVoik039Qgbxbr/jwgi3Gl5EtvRrPZbqsg1s
         0PAhQYky7flr9Ke40SlguVYLcrfKo3wZ4XGKNbbhNSSKmOKopdCbA6IQbK6GEjw6kNMy
         zV5HCFk5OANacJfRgTj0Ypf+bSpCL6iOvfFJpAHa5DV1pwtphj+e3+sx3rvAuAHZ0s6H
         ITu6sIkc3o/9cEvANyWYMsxJRxdXpaqXJ0s65j9b9hPSnmTfjvGg+4uAF27+S7rNOiX9
         p6Yw==
X-Received: by 10.112.210.166 with SMTP id mv6mr2348572lbc.51.1370659515778;
 Fri, 07 Jun 2013 19:45:15 -0700 (PDT)
Received: by 10.114.24.234 with HTTP; Fri, 7 Jun 2013 19:44:45 -0700 (PDT)
In-Reply-To: <1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226781>

On Sat, Jun 8, 2013 at 3:32 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Let's show the output so it's clear why it failed.

I think you can always look into trash-directory.t3400 and figure why.
But if you show this, I think you should use test_cmp to make it clear
what is not wanted. Something like

: >expected &&
test_cmp expected output.out

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t3400-rebase.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index b58fa1a..fb39531 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -185,6 +185,7 @@ test_expect_success 'default to @{upstream} when upstream arg is missing' '
>  test_expect_success 'rebase -q is quiet' '
>         git checkout -b quiet topic &&
>         git rebase -q master >output.out 2>&1 &&
> +       cat output.out &&
>         test ! -s output.out
>  '
>
> --
> 1.8.3.698.g079b096
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Duy
