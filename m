Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2271F461
	for <e@80x24.org>; Thu, 29 Aug 2019 22:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfH2WGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 18:06:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfH2WGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 18:06:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id g7so4973137wrx.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8BazFTDgDAQMwNxWkCI0bdmkOwKTqloydv0zt8J85JI=;
        b=RaJDxJrTKsLgjBD7EHCJ0o7Op9c3orVIQR8hyVlM51/NXr/FzFaun88O3WOef1EnVf
         Ail7wLN7pF92g6e9swx1hzaujGmhDIWvjlwEVM/4d3ZJ/alvWL93gWu9me1bDVmhaAE8
         mLxI3kAcM1Ht+o24o/0ZxYCwLOuxHYjU0EDQGugl3ien8cv1l/RvDsLdN27EObU0kfWN
         aGwQf6/rRvdXQ9STlWHejv1z0Z43k3JX3HqgD8jiNozSusFtVKbD1r9FFIaqBhZ/XaA7
         +GWsS0rg4jVOLmiCbCrzwAI741vxecNp88csW+ERROrQXb4ohyVy4eIONff/hMbhGDfY
         G7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8BazFTDgDAQMwNxWkCI0bdmkOwKTqloydv0zt8J85JI=;
        b=KrLrZFhb8xcVe40ZWKWj4Lq+3xA3nHNhny+DX3YztEx0r5ZOTwEclDunRXvd47YoMX
         ZEU9IxGOxEE+UiQLae/hb7xKV69R4dZl6xdL37eSMu+FEBut0pma0aT3vpcFr8vZEvf8
         yaJcCcs32uZm8WYGSoY9dbRHqVLFNSrJh9ODy/nCJdFQq9seEcoQMIoQBQW+0JX42+Mi
         KHivf+gR16R+VgYcB5T/2F+4a9iURiyw//kZ9bhnX+MkhBrkLFXauLS3VHBbyyzdldEq
         s+kJBhLguUVdhlBCzexWUsJxgD9r5gzaBSLVF/6rLtVB032BOg4q4UxhDjJoURvkxwaI
         ROPg==
X-Gm-Message-State: APjAAAVleeYldREtMWmrviM9zhfiVHrCXQxnwqmG8Y7iW0SYtgy0k2SM
        KcVvq52Fhf5w5Dm5DxB0dy0=
X-Google-Smtp-Source: APXvYqw8nPZ3zPfttOe6A/dYZjESCqpXIu2NT1WDXSNYczykUG6bIs/DvXrYCnKEdV9trStDWqa7JQ==
X-Received: by 2002:adf:c594:: with SMTP id m20mr15285754wrg.126.1567116393969;
        Thu, 29 Aug 2019 15:06:33 -0700 (PDT)
Received: from szeder.dev (x4db98d3c.dyn.telefonica.de. [77.185.141.60])
        by smtp.gmail.com with ESMTPSA id b136sm7501278wme.18.2019.08.29.15.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 15:06:32 -0700 (PDT)
Date:   Fri, 30 Aug 2019 00:06:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190829220630.GH8571@szeder.dev>
References: <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
 <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
 <20190829141307.GE1797@sigill.intra.peff.net>
 <131dfa37-0f65-f0c3-6f30-5b6eca12d9c0@gmail.com>
 <20190829143805.GB1746@sigill.intra.peff.net>
 <20190829215818.GG8571@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190829215818.GG8571@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 11:58:18PM +0200, SZEDER Gábor wrote:
> On Thu, Aug 29, 2019 at 10:38:05AM -0400, Jeff King wrote:
> > So any fixes there have to happen on the client side. I am still
> > confused about why the client is writing in this case, per the argument
> > in 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> > 2019-04-13). It would be nice to use GIT_TRACE_PACKET to see what it's
> > trying to write, but I still haven't been able to reproduce the issue.
> 
> It's the "done" line:
> 
>   + cat trace-packet
>   packet:  upload-pack> 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed allow-tip-sha1-in-want allow-reachable-sha1-in-want symref=HEAD:refs/heads/master agent=git/2.23.0.40.g4d780d4382.dirty
>   packet:  upload-pack> 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad refs/heads/master
>   packet:  upload-pack> 0000
>   packet:        fetch< 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed allow-tip-sha1-in-want allow-reachable-sha1-in-want symref=HEAD:refs/heads/master agent=git/2.23.0.40.g4d780d4382.dirty
>   packet:        fetch< 5e26403b4485d7a44fd8b65dc3f71e21c0dd6fad refs/heads/master
>   packet:        fetch< 0000
>   packet:        fetch> want 64ea4c133d59fa98e86a771eda009872d6ab2886 multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta deepen-since deepen-not agent=git/2.23.0.40.g4d780d4382.dirty
>   packet:        fetch> 0000
>   packet:  upload-pack< want 64ea4c133d59fa98e86a771eda009872d6ab2886 multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta deepen-since deepen-not agent=git/2.23.0.40.g4d780d4382.dirty
>   packet:  upload-pack< 0000
>   packet:  upload-pack> ERR upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
>   packet:  upload-pack> 0000
>   packet:        fetch> done
> 
> In the avarage successful run that "fetch> done" pkt-line is
> immediately after the "fetch> 0000".
> 
> The above is on my Linux box; here is a failure on macOS, essentially
> the same:
> 
>   https://travis-ci.org/szeder/git/jobs/578555606#L3453
> 

Try this patch to reliably reproduce this failure:

diff --git a/fetch-pack.c b/fetch-pack.c
index 65be043f2a..e18864458b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -471,6 +471,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	}
 done:
 	if (!got_ready || !no_done) {
+		sleep(1);
 		packet_buf_write(&req_buf, "done\n");
 		send_request(args, fd[1], &req_buf);
 	}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c81ca360ac..ebecc81c89 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1252,7 +1252,9 @@ do
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
 			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+				GIT_TRACE_PACKET="$(pwd)/trace-packet" \
 				git fetch ../testrepo/.git $SHA1_3 2>err &&
+			cat trace-packet &&
 			test_i18ngrep "remote error:.*not our ref.*$SHA1_3\$" err
 		)
 	'

