Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59E91F576
	for <e@80x24.org>; Wed,  7 Feb 2018 10:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeBGKAs (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 05:00:48 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:37992 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbeBGKAr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 05:00:47 -0500
Received: by mail-qk0-f177.google.com with SMTP id w128so338603qkb.5
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 02:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=i0Y/KFmo8dkzOb/XmvIJZfM+hBcAdKo4E+0dGinKRy0=;
        b=F9MNAST9vuvQwW43rmxm12//oxUng96LAmv0Iiqco7Ya6eWxciDNLYqE3VaLH1a/1i
         FMA7kcXFJZWci12eiZMMS3AjXSuoQnlvXWyX8S6rkLY8RVNC6SBGn4JTQIFKeRSn4MK9
         mZhwfU+Ux5jAx3aF1n5aqIrKUAX8Dt87jJfnCJglgvRCLZ9Wr6ai1BhR0amniPWjTG2Z
         j6KpMqKW1VXCJp6F/5Ht/Q4oSfCyLpmLcC7Cb7sPdZqjh6DrSz4u0JWbTVbS8EdcN8wq
         sO0anU2R7bWI+a5vF/JE/JzycbnF7QZuvUk9PhlpFb5AhXSF2l1eXMBjBNSCckK5bq5f
         Hp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=i0Y/KFmo8dkzOb/XmvIJZfM+hBcAdKo4E+0dGinKRy0=;
        b=LreMj3lgjiu56TDIJgTmjtnYA7t/8gMuMiUDIz15G8l+EWI67szscc6Q9J0xKQkTo2
         ANcah4sJidw8vjvPEzd9uSWs8Zb7sNjWMd2AstG3M/em0V1OEDVoDxKK8DpbaHuYHfdK
         XhGM32h6SVDxCj/pCSeTME3vc4O7N89XYo68iIW0HlKHzlyLuQ8N0Nlyh7Q2WlJTMsgC
         fbt9SC+k7jBo6qF5wHkggVIpByYsfQLIg3hcFCIA/ALZKC+6EedzbXonwKSDGX907RnG
         bjd5jBpfOT6js1wJqV9mcQY+Zy/GIwc+xkuhF9E10r3u+MbEWRP+qvlVPtuh36lVrCJB
         qVEQ==
X-Gm-Message-State: APf1xPA8cUhhDPZXcD/8D4ucXe9FvODUeOUKhmYDzoxknU+Ilqsv0paF
        ZezymHUhVBBQVbF+6OkkRKwgHdP5QzdDe2UJmI8=
X-Google-Smtp-Source: AH8x227aEAIH5yO/H04wFBu3j0vTQ/zLqrPgxaoy1srbql/36+MDksHo6c/Ow+Q0795mi50X5vdv/PuKooFuaTor4jE=
X-Received: by 10.55.123.69 with SMTP id w66mr7961654qkc.326.1517997646346;
 Wed, 07 Feb 2018 02:00:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 7 Feb 2018 02:00:45 -0800 (PST)
In-Reply-To: <88e7c122-599f-4ab1-6d65-c75f7a3ae8bb@suse.com>
References: <88e7c122-599f-4ab1-6d65-c75f7a3ae8bb@suse.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Feb 2018 05:00:45 -0500
X-Google-Sender-Auth: 6vGc10kTu6rDb5-3Cf0X4X_NCMY
Message-ID: <CAPig+cQ=Uvp5k7NprzqU1Cfi1b0jj5T63Nxzqg+O5ucinD9fmQ@mail.gmail.com>
Subject: Re: [PATCHv3] tag: add --edit option
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 3:36 AM, Nicolas Morey-Chaisemartin
<nmoreychaisemartin@suse.com> wrote:
> Add a --edit option whichs allows modifying the messages provided by -m or -F,
> the same way git commit --edit does.
>
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> ---
> Changes since v2 ( https://public-inbox.org/git/e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com ):
>  * Add [-e] to git tag summary

Thanks, I think this addresses all my comments from previous rounds.
Just a couple minor style issues below...

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> @@ -452,6 +452,21 @@ test_expect_success \
> +> +test_expect_success \
> +       'creating an annotated tag with -m message --edit should succeed' '
> +       EDITOR=./fakeeditor     git tag -m "A message" --edit annotated-tag-edit &&

Whitespace between 'fakeeditor' and 'git' is a tab but should be a space.

> +       get_tag_msg annotated-tag-edit >actual &&
> +       test_cmp expect actual
> +'
> @@ -465,6 +480,21 @@ test_expect_success \
> +test_expect_success \
> +       'creating an annotated tag with -F messagefile --edit should succeed' '
> +       EDITOR=./fakeeditor     git tag -F msgfile --edit file-annotated-tag-edit &&

Ditto.

> +       get_tag_msg file-annotated-tag-edit >actual &&
> +       test_cmp expect actual
> +'
