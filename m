From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 3/6] t0040-parse-options: improve test coverage
Date: Wed, 13 Apr 2016 01:26:51 -0400
Message-ID: <CAPig+cTB=bYNxR8yN2CGvkmtCZKomnbdNnZon9HA5uE9aivW=Q@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60965-887d5e4b-b12d-4477-8271-eefa349ceddd-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 07:26:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqDKL-0001Zr-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 07:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942AbcDMF0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 01:26:53 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34248 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327AbcDMF0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 01:26:52 -0400
Received: by mail-ig0-f195.google.com with SMTP id qu10so5187803igc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 22:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=E8heAXeFFRTvc/lZK/Fr9BfOT9wPLRCcIkiCHZB1E9c=;
        b=YI3Pc7uJkE5tphh7NssLhgxkCU78yqryjrgzfEuGNbXigy8mmVuWbf841JXPRY7DBp
         HEldvv9s6EAlLiKRwIvhdGBCiXXCnPM+cyzD9ncTbZngRcLd5K/GFZKn2zTjO00OJA+D
         0dUkyV0qT/iSFnBuB01LKkNtWLrms3z8JV7ZvTk92c4lBeRXFPNHJS3ipj88uQJs16ky
         mvCc04Iw3qEz3sMTPlXx4QOXS1uI4n60HBphtl/S94jSjLDzqf+DvxdWpJU+o1PgVITn
         0/7i9tM4UsfKuizN3p0VeRC2XhkSFh3kntT4qqODub+7DurN+G2J7o4twmWB035P+v7/
         uIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=E8heAXeFFRTvc/lZK/Fr9BfOT9wPLRCcIkiCHZB1E9c=;
        b=f5SJsIPyXnpsd7hoyVo6UcaJAsVACvizhvaEViuKUaYJue0AdB4sMd4M/7qrnb5Yuw
         yrZjuJOWNofLkiDTqVzSXzdkowvjieWp0xdDRStvrpdTHwBjIyIybZmshtHmzhY29Ajb
         ao7C1Vg4gQMk6A4c42I76lqq9/uvNGEGvHI9D8Z0yaMWs8G+zlJPlpkuX++HxnprpX/q
         MsQH4JSeN4uE9MgqNl+vpxC/2wxF0sbZIqdJ61edroVoAt3Oimj7e9reUg55jspU1m9T
         F5EWokLUiGJfbtrIzQNBdfCJ5xd1ch/zA0bs4kAAWPLC7cPcjsYsFthPqy0oMwSl5QTE
         E1Jw==
X-Gm-Message-State: AOPr4FUlOv16L/9GpJLlTNmVVQr6Xjgl1LhHPtGcE0kQ3Q1rD/ZVY/8JTXRQUn5Qu36sUmKkrHvaUEzvS1CLIA==
X-Received: by 10.50.189.233 with SMTP id gl9mr26215680igc.73.1460525211511;
 Tue, 12 Apr 2016 22:26:51 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Tue, 12 Apr 2016 22:26:51 -0700 (PDT)
In-Reply-To: <010201540cb60965-887d5e4b-b12d-4477-8271-eefa349ceddd-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: 5QFOKSISag7LnhoTUVrYb-fe_4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291369>

On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Include tests to check for multiple levels of quiet and to check if the
> '--no-quiet' option sets it to 0.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> @@ -476,4 +476,41 @@ test_expect_success '--no-list resets list' '
> +cat >expect <<\EOF
> +boolean: 0
> +integer: 0
> +magnitude: 0
> +timestamp: 0
> +string: (not set)
> +abbrev: 7
> +verbose: 0
> +quiet: 0
> +dry run: no
> +file: (not set)
> +EOF
> +
> +test_expect_success '--no-quiet sets quiet to 0' '
> +       test-parse-options --no-quiet >output 2>output.err &&

Meh, as implemented, this isn't a very interesting test, is it?
'quiet' started at 0, so all this shows is that --no-quiet didn't
disturb the 0. To really test that it resets it to 0, you'd want:

    test-parse-options --quiet --no-quiet >... 2>... &&

> +       test_must_be_empty output.err &&
> +       test_cmp expect output
> +'
>  test_done
