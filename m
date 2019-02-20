Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F4551F453
	for <e@80x24.org>; Wed, 20 Feb 2019 20:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfBTUFr (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 15:05:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51893 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfBTUFq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 15:05:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id n19so7901106wmi.1
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xo9RCWQ7grQv1FwGSnDs477aHsbZIvEy9Pd8GSaQGuE=;
        b=HxPFOm1VK62pfgijlRw1PoleaLD7dTvxmqOJw3xC4zB1Esy6Z3Hcw7DNGS6uVghuUe
         mxzhzkOCTrhvDp2r/BPw6JQuMHBRpvaZLzSLUgWiUYXCn30JKaTT4x+HE+emo96hrTG/
         8XlyF3GdBYI75fbV/4tRNGYebm5sDpLO+fugd5gpw2vNRyPUr+3Zo5WTNsaEP/+pl5ju
         yfVIAzBdbKy8PoWfJBdXe6Cl84JUqfEtxf7Nr7NruYG/ECyV1XpG+MCsF0Xk29eQOP+G
         mVHyLJBrpciGozHrxcAqCjzAHzNcviXJ9/vtp51m9AtKnTc+tsUXC3IEUROShfji+Ti9
         CUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xo9RCWQ7grQv1FwGSnDs477aHsbZIvEy9Pd8GSaQGuE=;
        b=BLmdHoryBn8+5aXvv7YeqCCq169yZrhXcaWJqg2l4Y8VfUATrojMkcRyi7S+Xx/Ou0
         vSrOzoEdsdd4c2MaAd1lbbS47r1M97EQRGLdfbqYFXC6PmH1jFUsMofznOBja+ATZ69w
         9uZ/1upyTlQ/Ms3swlVLwfLr0sqSxNJA9XkVgLDHVGe3ndi6bGRFqL0ic7/FHlyxFRwo
         HWony3pp7kqkTfdE14zuHWLsXor7cif1pEmc/GoutOAJ1I67kSbzNKkP9SrG1mqI9h5J
         fDTkxvV2v9o5KAWp/sXE+cD1ixJaXxtEoBxhQaIJ6gGFbhxOwP/qZ2sanAQRd8+4ZD+V
         OWHw==
X-Gm-Message-State: AHQUAubC3cpuMzhF0SvDCnOkxU/2gg1+EuV31PWxmXFeM3AoVRm1mxY7
        ziu7L0myBqCguZyVLM3p6C4=
X-Google-Smtp-Source: AHgI3IZ3L+YNmLVw4Dv+QldRYlQpQ9vshH9NF1G+S4xDmkTFHt9fA8uaYDEtPZZEGmXa5hz2WtaewA==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr8078414wmd.67.1550693143904;
        Wed, 20 Feb 2019 12:05:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 93sm13636607wrh.15.2019.02.20.12.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 12:05:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ismael Luceno <ismael@iodev.co.uk>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v2] git-gui: Handle Ctrl + BS/Del in the commit msg
References: <20190216031051.8859-1-ismael@iodev.co.uk>
Date:   Wed, 20 Feb 2019 12:05:42 -0800
In-Reply-To: <20190216031051.8859-1-ismael@iodev.co.uk> (Ismael Luceno's
        message of "Sat, 16 Feb 2019 04:10:52 +0100")
Message-ID: <xmqqbm36w7hl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ismael Luceno <ismael@iodev.co.uk> writes:

> - Control+BackSpace: Delete word to the left of the cursor.
> - Control+Delete   : Delete word to the right of the cursor.
>
> Originally introduced by BRIEF and Turbo Vision between 1985 and 1992,
> they were adopted by most CUA-Compliant UIs, including those of: OS/2,
> Windows, Mac OS, Qt, GTK, Open/Libre Office, Gecko, and GNU Emacs.
>
> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> ---
>
> Notes:
>     Changes since v1:
>     - Improved commit message.

I do not use git-gui, but as a bystander, the intent of the change
sounds sane.  deleting from the insertion cursor to the end of the
word where the insertion cursor is looks like the right way to
delete the word to the right of the cursor.  I am not sure if going
back by one character from where the current insertion cursor is and
further go back to the wordstart would give the beginning of the
word to the left of the cursor, though.

A larger issue is that we haven't heard from Pat, who has been
helping git-gui.sh maintenance, for quite a while, so we'd need to
find a volunteer to act as a replacement maintainer.  If you are
willing to, that would be great ;-)

Thanks.


>  git-gui.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b878d41..e00d9a345294 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3788,6 +3788,8 @@ bind $ui_comm <$M1B-Key-KP_Subtract> {show_less_context;break}
>  bind $ui_comm <$M1B-Key-equal> {show_more_context;break}
>  bind $ui_comm <$M1B-Key-plus> {show_more_context;break}
>  bind $ui_comm <$M1B-Key-KP_Add> {show_more_context;break}
> +bind $ui_comm <Control-Key-BackSpace> {%W delete {insert -1 chars wordstart} insert;break}
> +bind $ui_comm <Control-Key-Delete> {%W delete insert {insert wordend};break}
>  
>  bind $ui_diff <$M1B-Key-x> {tk_textCopy %W;break}
>  bind $ui_diff <$M1B-Key-X> {tk_textCopy %W;break}
