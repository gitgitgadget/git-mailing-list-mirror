Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FA8202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbdJZT4a (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 15:56:30 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46390 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbdJZT42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 15:56:28 -0400
Received: by mail-qk0-f193.google.com with SMTP id k123so5818283qke.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuqJv3GIrldbnS0jZ2um5YvJ9DwLLOAdB9ggyajLHCc=;
        b=acduC1Naze/ILPZRT7pnfjynVx0OFUrsNupm9pM0UZzQ511YZeycw/K9ZOX0Dbsbfz
         lDvhjc4wYJnPr0VizGf7wk1RCHfjo7iBKCLOBWP0vKkfA0SppoJupJXZrMJ+/HX+1r+o
         zwLxSE7ObcZIpUoyERrT8Le21OcC+hJ36S54egQ0/oXlRhC/jZfTmSseCu2U6fCUHPxF
         ds4EHKPrx50E1X1VdktP5tNUzE7BzEVubuJsaoAVUSPEXS3YqbhIqOq7ZMgqOPYQZkUV
         wL+YNkfPg9K1mCF9yV5OpBfDk4a9VEyFzu5RQ4fU2E9Wl/uc1HDXu3o/1QJ7oUcAb5nU
         pJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuqJv3GIrldbnS0jZ2um5YvJ9DwLLOAdB9ggyajLHCc=;
        b=T2o2vK21A/o+apQLdvcjcyIV4uPAV4I48JzJEQSIqvCO6B5i+53e+iv4ObFbiTMVUp
         AqW2Sec5mwgpnv+AztliX+F6/fXgN9zs09BDOH16a2+qnLIyFwtO9NwawS5wOGGL75cQ
         6j9rIW2ADdN9eC/k9/qSTW4TmUjyw6ztScBD2VYmAf5FDK9ziO8dM2tHlhPJvLKI3Nnn
         vS4w/ashqaFVjHlQwpWYCUI/mC2gP4gJfrRwid6PKiv/PK0B7QuWGYQC9zRLP7q2Mv51
         TZBUW42NbWJA3MxZW3vPNakv2eclp8JaHChoORKpHN1I04H+5240iwc8qnvVxvVmmQcV
         3v0w==
X-Gm-Message-State: AMCzsaXLJHyKhvHUXo1inhTwA3DcF/2Vp0UKUJpEc6Tr95gBJqeN/xsd
        0wRrWru/7Dbuy/ULU2518t8zUlqq
X-Google-Smtp-Source: ABhQp+TlTJ61OVHfl9ZxBJMHrrDTsOZSvcLY0F7aIWsGoniNuH/KiNC/oarSVaKorRFrwSGWJSwXxQ==
X-Received: by 10.55.65.22 with SMTP id o22mr10333030qka.272.1509047788160;
        Thu, 26 Oct 2017 12:56:28 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 64sm4004944qkz.51.2017.10.26.12.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 12:56:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] fsmonitor: Set the PWD to the top of the working
 tree
To:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20171026013117.30034-1-alexmv@dropbox.com>
 <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5a389621-961d-48e3-339a-ef182d3ed628@gmail.com>
Date:   Thu, 26 Oct 2017 15:56:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 9:31 PM, Alex Vandiver wrote:
> The fsmonitor command inherits the PWD of its caller, which may be
> anywhere in the working copy.  This makes is difficult for the
> fsmonitor command to operate on the whole repository.  Specifically,
> for the watchman integration, this causes each subdirectory to get its
> own watch entry.
> 
> Set the CWD to the top of the working directory, for consistency.
> 
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>   fsmonitor.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 7c1540c05..0d26ff34f 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -121,6 +121,7 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
>   	argv[3] = NULL;
>   	cp.argv = argv;
>   	cp.use_shell = 1;
> +        cp.dir = get_git_work_tree();
>   

I'm not sure what would trigger this problem but I don't doubt that it 
is possible.  Better to be safe than sorry. This is a better/faster 
solution than you're previous patch.  Thank you!

>   	return capture_command(&cp, query_result, 1024);
>   }
> 
