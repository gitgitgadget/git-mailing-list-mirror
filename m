Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14FAD1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 18:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934257AbeFLSJU (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 14:09:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37292 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934379AbeFLSIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 14:08:50 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so14806541plc.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tVKuRoEf6ZLpcxRJgQd8asKKm9CYteVi2cMazlYr3HE=;
        b=ccrvz4jf/v26gn3zePqQShMdkqRCMiI5XAQaIzDsbxgZrKpzzz0ZTdIyhiLqwblvAl
         RyB2VgRH6/kG8hJSwmDbcdZm4Om6sIBQ61Nhnh3V80DBA5w3RkgxEgXXv/VHbGGKoeau
         lQavcThE2Eb4W+XS9U1Jls+pz/aJDn43CyTSR5fBrToUuBtPW7wIpE4A1Dhb29e6eagD
         7QNRsih/9bAyGvUoJGTHuNChS2Myorw50/2WmvOQQN1yUzcrUBSL9UX1elv+IgEctgT+
         pMyUzqrbt5JwhYnFj80kMa73TOJsz54L0X6ZHFgzY+G7fvSgW+iGtSFA4Iqc75wCuzSU
         HmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tVKuRoEf6ZLpcxRJgQd8asKKm9CYteVi2cMazlYr3HE=;
        b=qY9hPd8FNsonc2DuLEin7zfs34nWqBk/gOOGn7/2RUxLKiopwvXZhZ419htOcCNEPm
         oNgmfG9SEj+ZwDKtPir6LamHCcAzNHshXAamVNt6Q4fEptx+BvIWPCV5r2uBA6zqhU25
         UxuoOoaX/hwAokZo6RgegIiZYb2saIbDAHPZf+HvK5eroFhIJB/jyOiMHm6NiPJqzZoN
         4nLU13sKLcYYpOi1l1CeG+VtOlp/Ia/Tltd5K/NllEn3CA9KuJIo+ZDxU1zL61LkaM5T
         aZS1JCzDLjwUcXXXCmnoPdz/szOSiwFxDck9Mtjv1wUFt3dkxrrQ/E4A+2YAolZ9XFNk
         3woA==
X-Gm-Message-State: APt69E0WzttMmwn5an+HxWZc24qPLGl241+LcbrC+VpnobLs/Dia4BLK
        ElUeuPmPUr4/1J71CPX6hdE=
X-Google-Smtp-Source: ADUXVKJNU8T+O2M+8PtYFNTktSsDzufBPJjudBRJTiIbxZ3FAtzk6njXdAKMUKGooazRnjCLg7vYIQ==
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11-v6mr1607351plo.20.1528826929467;
        Tue, 12 Jun 2018 11:08:49 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h8-v6sm738545pgv.29.2018.06.12.11.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:08:48 -0700 (PDT)
Date:   Tue, 12 Jun 2018 11:07:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, masayasuzuki@google.com
Subject: Re: [PATCH] builtin/send-pack: report gpg config errors
Message-ID: <20180612180705.GA28554@aiede.svl.corp.google.com>
References: <xmqqk1r3aorh.fsf@gitster-ct.c.googlers.com>
 <20180612175344.65466-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612175344.65466-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Any caller except of git_gpg_config() except the one in send_pack_config()
> handles the return value of git_gpg_config(). Also handle the return value
> there.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/send-pack.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

The other callers do

	int status;

	if (!strcmp(k, "key.i.handle")) {
		...
		return ...;
	}
	return git_gpg_config(k, v, NULL);

or

	int status;

	if (!strcmp(k, "key.i.handle")) {
		...
		return ...;
	}

	status = git_gpg_config(k, v, NULL);
	if (status)
		return status;
	...

Should this do the same?  That way, if config_fn_t learns to return
more fine-grained errors (e.g. a new return value of -2 or 1) then it
would be propagated.

Thanks,
Jonathan
