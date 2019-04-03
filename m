Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406A1202BB
	for <e@80x24.org>; Wed,  3 Apr 2019 07:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfDCHKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 03:10:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCHKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 03:10:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so6760798wrw.13
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IiYVRj+vyk8QJPx5iX5DF326hdqtPoqi6C875yES48o=;
        b=qd56gdQFrmFA+ZcbIf28CxwN4ZpyrdAvGNW7LkCg2vfAT0rlPEvBQjA0GGjw1LF5HP
         1qp+UGFr4wUn5bnvG0q08GpFqJREu5T9OzHkx+pcKtPAGscXDX10oRIv3+dxvzTbECHd
         eZag+447MoGD4RjwBsAwbDOoO4g8hQB3+MHHLDU1mkGuPFfoCaJ/3XahJXHuk5/caHXc
         7mwKA1peTXT6P5tMhN8dQIIMzqMWRgP+JGfS/dwNbVVnVYHRS8Jk0eWpg9KZJvpjy+Fv
         OQU1hImUNEp61p1EqhXKzNONhhO43Ytv3hzXaEFaSY9Ps7Foqehjc4XaUyH8VNJcb6kD
         b+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IiYVRj+vyk8QJPx5iX5DF326hdqtPoqi6C875yES48o=;
        b=HIPFGL6p74odUKIzCXk3Wuormn2PERMztlYWI9m07kzCIqv8UO+MbHfeRYPhB9qPqP
         Nf54oq9zc98n7bsCcRb+d26pC/jgPLAdjERHXqVvv0TR7x3dq44jBNaBGkhp9IWYIdWo
         MJOPqfXMfVIUyvANmanfXGUkOqCaJtoTYLy5+D1CwzbienqxYbldLT52EWcjnVd/Me7d
         HwkU6kJI77UcWF5PqjkeumeozSh3dKRQWCgf+eFX/p++wVjJj5RGQfd4Wp5REg/X2JO+
         //lUFIvEzA0q4v2DMEwYNrIQXpCfSIkdtftxA2fiMRF2bsiGEkdcKPXgUCbV2M9aWiEA
         eN9A==
X-Gm-Message-State: APjAAAUw5GjVHIZzw6W5pc3ivhc9zE2yLQKm/cSOWwsCcsJsTS3TfPR6
        Lyhbp825buyYbAZuhvF0bvg=
X-Google-Smtp-Source: APXvYqyqpres1yn2ov6T33uIq5tIEVVs0pbAmJOfrZwyMK/lW9ApGDN3IOzDxSCT84hM18577TQMYg==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr47085950wrl.26.1554275451921;
        Wed, 03 Apr 2019 00:10:51 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x192sm19156113wmf.48.2019.04.03.00.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:10:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     "Mazo\, Andrey" <amazo@checkvideo.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        Andrey Mazo <ahippo@yandex.com>
Subject: Re: [PATCH v3 2/8] git-p4: add failing test for "git-p4: match branches case insensitively if configured"
References: <cover.1553207234.git.amazo@checkvideo.com>
        <cover.1554141338.git.amazo@checkvideo.com>
        <68b68ce1e4782bba552a016867bfc629f0d5e24f.1554141338.git.amazo@checkvideo.com>
        <20190402120537.GK32732@szeder.dev>
Date:   Wed, 03 Apr 2019 16:10:50 +0900
In-Reply-To: <20190402120537.GK32732@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 2 Apr 2019 14:05:37 +0200")
Message-ID: <xmqq4l7ftvgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> I wonder whether it would be worth amending 07353d9042 to keep
> 'kill_p4d' around as a wrapper around 'stop_and_cleanup_p4d' for the
> time being.

I think renaming was the right thing to do; "show --cc" shows that
the post-image lives in the new world order where calling kill_p4d
is not usually needed clearly with a hunk that replaces kill_p4d
(which only existed in the old world) with stop_and_cleanup (which
exists only in the new world).

Will redo the merge and teach my rerere database.

Thanks.
