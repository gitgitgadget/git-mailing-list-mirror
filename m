From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] t6030: explicitly test for bisection cleanup
Date: Tue, 7 Jun 2016 19:21:12 -0400
Message-ID: <CAPig+cRxGAR8s_Yn7EmCs0zQe2=F7RnhSw+0mtiZOfJtFkD_FQ@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com> <20160607205454.22576-2-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:21:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAQJC-0005N7-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 01:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbcFGXVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 19:21:14 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35920 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbcFGXVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 19:21:13 -0400
Received: by mail-it0-f43.google.com with SMTP id h62so51288409itb.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Dcboa46TluL3hduc176rk88C7QN7yfrVHKxWFtixSwQ=;
        b=HH61aHdj22KAEq5vEPJbM3d8Z1yZeP0Kxj26GzpMiCQ/JEehZPCsFp9lTV/2NshtRV
         CncR/u8LAm27JW/VfLUPulZnBE/9x9ERH0rIPhOnr+1vVBjHNotclZyWa8g8JatV2mSt
         +VigMQtI9ts/tG5zHwWlDnm52AOWZJYNLaEVeibm48R5Bq2gG+REUK8hcnrL9VWq2nP5
         294WKoOoe9brvA3sPVY92pFwLmtnSY0CPUE/LmMxjs6UZgyLPeEVcPOnximiCxLfG8F5
         X9O/mGQ6I+E0HvQPvH0qoWPAoT8QiF6fHmC50/OYaJh7FnNn9ghz/eboZiXZDpKeQMPm
         t1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Dcboa46TluL3hduc176rk88C7QN7yfrVHKxWFtixSwQ=;
        b=C4wcMT987ki3xeS8wYvOEAf30FjndMrX6EyrrrlTawtaRhXEc48E8HWKpRrc3uQw2w
         44ia7Kck8zIQkrUMDZFRTrzH56AVZNjGS3+0wDPHX0mz3ZCAq2+fP6C3njPTOdoRkU1G
         bqSls7Jwp5LcC7qJu5t35hLUyXfZ27eZkkfxf0F05Nm2ZDQHj2qxKVhTbxV7uSHosc3U
         wxWmgrQi1OoimEGmOxHN9nqjVc64qiEt+QcLyFyFsPXg61887BGIyE/+R/mFnHsUpq8V
         ZtOzWFNBobWNNSsZMrxJchVjHDgMOeUFyPWrL5TRilZ9MCQYqvVqI5cfAhOyKGCAbCaB
         M9iQ==
X-Gm-Message-State: ALyK8tJJJhSPaphq1e/hXr56S0zSWTLlFXEP3iJiHuj1cZzmaK8/gb5cfX83nKGAOy+ySiGMKEJIJfBkoUwlBw==
X-Received: by 10.107.25.13 with SMTP id 13mr3690154ioz.104.1465341672954;
 Tue, 07 Jun 2016 16:21:12 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 7 Jun 2016 16:21:12 -0700 (PDT)
In-Reply-To: <20160607205454.22576-2-pranit.bauva@gmail.com>
X-Google-Sender-Auth: uuPvl0sFCdJhAP7fid3zVFI5a0M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296750>

On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> This is not an improvement in the test coverage but it helps in making
> it explicit as to what exactly would be the error as other tests are
> focussed on testing other things.

It's not clear why you consider this as *not* improving test coverage.

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> @@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
> +test_expect_success 'git bisect reset cleans bisection state properly' '
> +       git bisect reset &&
> +       git bisect start &&
> +       git bisect good $HASH1 &&
> +       git bisect bad $HASH4 &&
> +       git bisect reset &&
> +       test -z "$(git for-each-ref "refs/bisect/*")" &&

I wonder if this would be more easily read as:

    git for-each-ref "refs/bisect/*" >actual &&
    test_must_be_empty actual &&

> +       ! test -s "$GIT_DIR/BISECT_EXPECTED_REV" &&
> +       ! test -s "$GIT_DIR/BISECT_ANCESTORS_OK" &&
> +       ! test -s "$GIT_DIR/BISECT_LOG" &&
> +       ! test -s "$GIT_DIR/BISECT_RUN" &&
> +       ! test -s "$GIT_DIR/BISECT_TERMS" &&
> +       ! test -s "$GIT_DIR/head-name" &&
> +       ! test -s "$GIT_DIR/BISECT_HEAD" &&
> +       ! test -s "$GIT_DIR/BISECT_START"

Is it the intention that these should verify that the files don't
exist? Maybe use test_path_is_missing() instead?

> +'
> +
>  test_done
