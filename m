Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A4B51F453
	for <e@80x24.org>; Mon, 11 Feb 2019 22:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBKWmx (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 17:42:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45188 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBKWmx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 17:42:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so544473wrn.12
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 14:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YQD5VggZXzalVbixmGA+4Aj5e25QHDfyoBNNq40a2P8=;
        b=AykjjWUtBraOZq6qJM8GtH3UgqtUxHyPqVKUzHBZ4FjFgHXr/QhOCb5Btg6XP4iwyn
         VghojK9I98spkpUP8o5th+Hnn1gTwTvBG4+a5wKqsHa0tqV3aM81s+hm0y06ansAGNve
         94XF16zQVP+b2rolef4x70mpNRn2EGg5gi+vrN91w1CSu8u0dXmHdMEXCLZqThPstuEM
         RAUYMexw+VgaYBEXT1v/cQrryDiqk1E9q9/MfEag69bYGe9O9CjdavTvVnyf/pAE3rms
         nuRjeacuGmJ3scl1hArgfWwSkk/SL2+YzxPmX0rCCs8VGgy8nIGbyHG8prjxukWdntnG
         jlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YQD5VggZXzalVbixmGA+4Aj5e25QHDfyoBNNq40a2P8=;
        b=U32roqO/GcEF27YytGjzP/8FWOY+M+f4vhMIpGkUmmi2V6la1RvTIFBtBWR3+NeVly
         OUcK7SV9LKhlpHKsYb5s9n9JOJ/DXStMQGFMaJrw+Ud1asHDGlQc+ponSvZXMBIAKUBf
         6GN5ui4T1veWL+PPsljFrSHiHhi3hWl+KCEzVv/f18UQLMsvoI5kthQ1regodLvOQzVw
         YMNRXPt/oywAoUCGy77Aj722EORFYfggzOeHbA91De0/s7Q7GQ0EiWlJjLIxfN5F+Oug
         rgVEC6Dx2oKtGnZ9EBob6cS686Vv1mJyE6wf6RwVQFeD6cumvVpfDyNb9SCrCpcD5lYf
         wVuA==
X-Gm-Message-State: AHQUAuavH3s1LNC5Dre0lQ5TcbiLsCqkAuur3+l0mz3o3bSjcuuM7Odp
        STV6ilw5ycR+T828X2gZJec=
X-Google-Smtp-Source: AHgI3IZXaTEGp83YoDVUKR9OskzMlOOo9TmTiYu7trFFwpYjzhFdDhoXe3yElsMBFRAyTSkDGbJlPg==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr380072wrw.160.1549924970704;
        Mon, 11 Feb 2019 14:42:50 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u25sm914070wml.31.2019.02.11.14.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:42:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t0028: fix wrong octal values for BOM in setup
References: <20190211213818.4941-1-me@ikke.info>
Date:   Mon, 11 Feb 2019 14:42:49 -0800
In-Reply-To: <20190211213818.4941-1-me@ikke.info> (Kevin Daudt's message of
        "Mon, 11 Feb 2019 22:38:18 +0100")
Message-ID: <xmqq36ougd5i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> The setup code uses octal values with printf to generate a BOM for
> UTF-16/32 BE/LE. It specifically uses '\777' to emit a 0xff byte. This
> relies on the fact that most shells truncate the value above 0o377.
>
> Ash however interprets '\777' as '\77' + a literal '7', resulting in an
> invalid BOM.
>
> Fix this by using the proper value of 0xff: '\377'.
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
> I do wonder why this code is using octal values in the first place,
> rather than using hex values.

Most likely for portability to non GNU and less widely used systems.

Thanks for spotting these \777s.

Will apply.
