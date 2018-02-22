Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F861F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbeBVSbq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:31:46 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39148 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbeBVSbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:31:45 -0500
Received: by mail-wr0-f194.google.com with SMTP id w77so11554659wrc.6
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hU+cp07QhsX0HZH7e1OoJBR6KzX4gxb2GZrpQMeCCN0=;
        b=CCgHJOTtl/xg71H1QmaSRvM1NqBGUFFrOsFXa9T6WIxf8dCJkpevfasA0mFz+UtVDK
         GRZzrhWrnmbyJ4+2LOQHyAxhVLEVS10ADGhcSVuhgulz5LsWZCkW8Lh5Zkq9kDsPRYd9
         W1JiLSGhjmLRiI9A9lZJtb15fRxTBnQLz9fvdgDb8Kl0G0pJ5k4DK4Np7xNRrVoOuXAm
         5GfaRtoe9e09SDnmyRPp7lJPXeNhXjl3YgWyI2YaYZxp8wXHk6qmE9SLwSws+xky1lwP
         TMoChWbkiQYeNDpekVrAARYTe9a7js2kI0nIMWE5i5hQ3Afit3ntBBU9v3pBV/7rBqMo
         6sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hU+cp07QhsX0HZH7e1OoJBR6KzX4gxb2GZrpQMeCCN0=;
        b=gkbVvr/kk7/HWsKUByE47IT9TjqWwsfYK6yRFXe/AGl9keD1JNpAy535fZZ4zlG3Wl
         xTr3X9ZMea9Ka1Dca02HRJzXI7eHoY4ZxwnFB2gUc7zEa81Z9BQDytLALmdrLqvbbkVz
         qz7uKEQ7IIWOv2+0h8uvhhvYnMpLRpFMQn2oQsdyMRBQ/A1Oj9ZGecPBqDzpUxxFvWE6
         8j2Bw8OAs6oHLz+dnrSF6gsfuY/J1d3NgTD0P3n/K1cMGSvXdhjEKVkjh0tOmRThWGfg
         EwIVubu0zAbxUDHI68h3fRhEYFUnrkHDYZUK5fH78fgPT91m1EBL0OHJKIuRnxCVvYTg
         bJ3Q==
X-Gm-Message-State: APf1xPAnBt3nl7N0na6/38WVTujTKnpzTh9pSoM/VsG0kiWcoqeCvoEk
        GhX4FLvglkAFGSU5B1FmlmYC47E4
X-Google-Smtp-Source: AH8x225u3lubWgLc1SNwePsWC92o4U4Cq45lNFE3Pj7NlQEiPqeP/a8PpcQJ8mjhmcqdSFh7GJZ/WQ==
X-Received: by 10.223.134.136 with SMTP id 8mr7353479wrx.86.1519324303697;
        Thu, 22 Feb 2018 10:31:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b136sm49438wme.34.2018.02.22.10.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:31:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 07/13] commit-graph: implement --set-latest
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-8-git-send-email-dstolee@microsoft.com>
Date:   Thu, 22 Feb 2018 10:31:42 -0800
In-Reply-To: <1519066406-81663-8-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:20 -0500")
Message-ID: <xmqqk1v4x4dt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>  static struct opts_commit_graph {
>  	const char *obj_dir;
>  	const char *graph_file;
> +	int set_latest;
>  } opts;
> ...
> @@ -89,6 +106,8 @@ static int graph_write(int argc, const char **argv)
>  		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
>  			N_("dir"),
>  			N_("The object directory to store the graph") },
> +		OPT_BOOL('u', "set-latest", &opts.set_latest,
> +			N_("update graph-head to written graph file")),
>  		OPT_END(),
>  	};
>  
> @@ -102,6 +121,9 @@ static int graph_write(int argc, const char **argv)
>  	graph_name = write_commit_graph(opts.obj_dir);
>  
>  	if (graph_name) {
> +		if (opts.set_latest)
> +			set_latest_file(opts.obj_dir, graph_name);
> +

This feels like a very strange API from potential caller's point of
view.  Because you have to decide that you are going to mark it as
the latest one upfront before actually writing the graph file, if
you forget to pass --set-latest, you have to know how to manually
mark the file as latest anyway.  I would understand if it were one
of the following:

 (1) whenever a new commit graph file is written in the
     objects/info/ directory, always mark it as the latest (drop
     --set-latest option altogether); or

 (2) make set-latest command that takes a name of an existing graph
     file in the objects/info/ directory, and sets the latest
     pointer to point at it (make it separate from 'write' command).

though.

