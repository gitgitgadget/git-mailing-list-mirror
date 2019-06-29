Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF02D1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 17:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfF2RUA (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 13:20:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2RUA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 13:20:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so11416676wmd.1
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ktZCdBAKkxmZIA82kRt94/xNJapKCkASTZFRF6WtUGI=;
        b=SM5AHOdNqAD9x9KMzhZhQDDUQYM3KuEIgv4rXefVvANhV813OOonLJtcBVWjQkNt21
         wLqdaLfGnTguR3qcYaDM9w9i1P0WQBo2FLmLMfTGl5QBNyHXuWByTMKVjsr9Cr3aseOX
         K8c7BFc5O5ztkve+6hajLaq6ewWQpuvMEh6YXVE84RicEMeZuaDuQnq+U9sCFm7s5YmB
         9/EYFbbYqoEAzDm5z60G3OVLqgVsC2JLb6TG2oGuSojOL6geyXFBvvV0PnwHW62pn+D2
         PrZIZKPAhhoygm82OALvqdv5qn9ZM6liZrokEgFEcyg7OBnyG5feHYU+pM2JZYqUIf6F
         h95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ktZCdBAKkxmZIA82kRt94/xNJapKCkASTZFRF6WtUGI=;
        b=lYCnhUiyOXtRP9ibbtVZ8Ri+ULODV563vSWYoMEkhX3LbUJwIzPRV2gJXCDJEJzuRf
         CFuM74UXOzz7Ollr1cYI0bmoKCkzhTQPwwBwdOQsIasyoMUNb7q9WP+nMfVywIwzMyGT
         1ylFZaOm03HFPQs4cJePmpiBu/5EAar5d6u8ZHpbdda2Ls06HIcUPn1V0w4IV3biuyi2
         KI/DbNF0ViedsdP8QPBgZ6IckyhGuj1Y23XT3uauBhs55Hl/ECVnEfBA8wY7yMhD5tVg
         yl516cSklyGqtt2t5qxMROgXTh4M1wE/0FrjyNuOTCIdnO/acn07K+lGzAlG7OEXtNXC
         u+wQ==
X-Gm-Message-State: APjAAAWtXAb6NOT81VbymLhJUUXbpRWj9ThIo9hSfUOVmqVODrBN3YOO
        69dspx5Nqot/7aQ8Xecn9iA=
X-Google-Smtp-Source: APXvYqz3MNNqT6CGzojygyeZJZsEj621+2i77cD0kmYxvXVlamjxQisFl84w1MBKIZ/Ft6ghzrBOxQ==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr11779850wml.90.1561828797916;
        Sat, 29 Jun 2019 10:19:57 -0700 (PDT)
Received: from szeder.dev (x4db511ea.dyn.telefonica.de. [77.181.17.234])
        by smtp.gmail.com with ESMTPSA id g8sm10623565wme.20.2019.06.29.10.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 10:19:57 -0700 (PDT)
Date:   Sat, 29 Jun 2019 19:19:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Michael Platings <michael@platin.gs>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v9 7/9] blame: add a fingerprint heuristic to match
 ignored lines
Message-ID: <20190629171954.GG21574@szeder.dev>
References: <20190620163820.231316-1-brho@google.com>
 <20190620163820.231316-8-brho@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620163820.231316-8-brho@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 12:38:18PM -0400, Barret Rhoden wrote:
> diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
> new file mode 100755
> index 000000000000..844396615271
> --- /dev/null
> +++ b/t/t8014-blame-ignore-fuzzy.sh
> @@ -0,0 +1,440 @@

> +test_expect_success setup '
> +	{ for i in $(test_seq 2 $last_test)
> +	do
> +		# Append each line in a separate commit to make it easy to
> +		# check which original line the blame output relates to.
> +
> +		line_count=0 &&
> +		{ while IFS= read line
> +		do
> +			line_count=$((line_count+1)) &&
> +			echo "$line" >>"$i" &&
> +			git add "$i" &&
> +			test_tick &&
> +			GIT_AUTHOR_NAME="$line_count" git commit -m "$line_count"
> +		done } <"a$i"
> +	done } &&
> +
> +	{ for i in $(test_seq 2 $last_test)
> +	do
> +		# Overwrite the files with the final content.
> +		cp b$i $i &&
> +		git add $i
> +	done } &&

All three loops above have a pair of {} around them...  but why?  I
don't think they are are necessary and the test does pass without
them.

