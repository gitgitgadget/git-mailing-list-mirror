Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4900820A26
	for <e@80x24.org>; Tue, 26 Sep 2017 00:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964985AbdIZAB0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:01:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35061 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935639AbdIZABZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:01:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id i23so4259740pfi.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 17:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xybtb8n9uyZnh9wdIa3kR8AmHCQZVPBgKVgWNJYJPg0=;
        b=lFoVU7pwAv9m6w1yMC9r9iJsK9+U06MCwzvVE5TpJdNtWGSeecNzRYdu+otun4vkPp
         Qq4y0Z0ndNqMX7RUfWxYBJlqrgV2iiYeTCrKJr5khCNB/wpKUTw6o93/jXUJ32oidTS9
         pQh4Em+z0PDbKbIBI7k3fyALbUvAqplGaDWyhGAKyISinL3oEVhsz+C+0q3fOtGIF+Bs
         eVNQ2Yfq8rX/9aPmqZNkZIIiw3YPZis/EfYIkX+8sLmFXb+LZHaTLNdmEBaAlI9z++OS
         vK5dmtiFhM0ffhSV2vNNIEt8JQKLaO2ZIN8bPsdseN+jJPSHHH+u1gUGkjHBPwOXEoEk
         kkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xybtb8n9uyZnh9wdIa3kR8AmHCQZVPBgKVgWNJYJPg0=;
        b=hVBZyemN8QegZbzEa8XYfqOUhuyFK57ydZ2xkMdh2sTbB11107GEVxWCou+hDNq/Cn
         cNt+oDXqIznOrgywwVcOEdWkIzBhzNBNbF20pxUp5xsHyx3TilHIFZjqp6AkjIEqz5+T
         vBpt4GD7YfpNT6qCj+4yhsqamA17eANxETHm0THNJR5NLwi+3LfaYFWoFGun9BlBBvgE
         z7QBIJnPn/IOKkygjtHmoIy6fQgteGlYjbBppmk0q0lLBMOMCxkiewWwLECZtPeYhyTb
         GPKSL3NX2EV7x4lbZ7DbNP7MLnr2VNfdvxLXqNTggh7SkybVGyS0/BIN1z9G4GIeQVGa
         TyZg==
X-Gm-Message-State: AHPjjUgcqMgfgRA8D9Ep6tIH+Mt86d/NWg3WYWlbAteve7dZKRxWW1zI
        aIGNlCU3O1sLkD3fbyieUb0=
X-Google-Smtp-Source: AOwi7QCZUrWK9TDoG5z0K8eO3Kio31KOtTx3ZflVvYB4bDe7/5oJqpBuMjPQjex0P84h9wiDEb4/hw==
X-Received: by 10.84.247.8 with SMTP id n8mr9250643pll.318.1506384084322;
        Mon, 25 Sep 2017 17:01:24 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id e66sm12855023pfb.48.2017.09.25.17.01.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 17:01:23 -0700 (PDT)
Date:   Mon, 25 Sep 2017 17:01:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7406: submodule.<name>.update command must not be run
 from .gitmodules
Message-ID: <20170926000121.GM27425@aiede.mtv.corp.google.com>
References: <20170925200448.GY27425@aiede.mtv.corp.google.com>
 <20170925225054.10819-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925225054.10819-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> submodule.<name>.update can be assigned an arbitrary command via setting
> it to "!command". When this command is found in the regular config, Git
> ought to just run that command instead of other update mechanisms.
>
> However if that command is just found in the .gitmodules file, it is
> potentially untrusted, which is why we do not run it.  Add a test
> confirming the behavior.
>
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7406-submodule-update.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 034914a14f..d718cb00e7 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -406,6 +406,20 @@ test_expect_success 'submodule update - command in .git/config' '
>  	)
>  '
>  
> +test_expect_success 'submodule update - command in .gitmodules is ignored' '
> +	test_when_finished "git -C super reset --hard HEAD^" &&
> +
> +	write_script must_not_run.sh <<-EOF &&
> +	>$TEST_DIRECTORY/bad
> +	EOF
> +
> +	git -C super config -f .gitmodules submodule.submodule.update "!$TEST_DIRECTORY/must_not_run.sh" &&

Long line, but I don't think I care.  I wish there were a tool like
"make style" to format shell scripts.

> +	git -C super commit -a -m "add command to .gitmodules file" &&
> +	git -C super/submodule reset --hard $submodulesha1^ &&
> +	git -C super submodule update submodule &&
> +	test_path_is_missing bad
> +'

Per offline discussion, you tested that this fails when you use
.git/config instead of .gitmodules, so there aren't any subtle typos
here. :)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for writing it.
