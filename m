Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B252013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755328AbdBOXdJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:33:09 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33634 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754930AbdBOXdH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:33:07 -0500
Received: by mail-pf0-f182.google.com with SMTP id c73so437277pfb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=AKWAWKWLZ22NnzENw2W0nNHUY8mFrFDPt/d/enAB6Wk=;
        b=Lq0mwkY1Inj3+Ecd9c4jO1DrLAYuudDX9c/wlwVhq05I2kENAz9/Y5NODGWI88iqMf
         bL6qcR8x81gQSNp6rxi4n48X/FWHkHXo7Qqz7HqKhmGPdI01IXQuqJnn8HuPzRwNaBnt
         MNCi+xm0yJThl/AMlzIRwy6AqB1mNACcYRsP/QeKa0RAsUDN/ye1W8YnQLd17+zl+05C
         0+iEhVMkTZRWYpc4WV8omR0jP3T1ooBJy810yWERn2ptCLiRni4OMGKZ5cV0+Htt50B+
         fx3TDrM95v5p4ScJ8UAUNWEWNi07YeKBg3sZndUhlpi0jkVCBjSnmgSp/en/UCpwbfgo
         kxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AKWAWKWLZ22NnzENw2W0nNHUY8mFrFDPt/d/enAB6Wk=;
        b=F56kRMKrX0U/2crRhS7PA5+kxZX7xP1qai2y4PKojR/dhl3Q+gsobfUFAuFoFeKQRX
         WJZWN8S7MCxYzf9uoxhc3Zodq7fGm9ugEuzYgCfHSo8ba8XvEpPhnC686ojQjbpKMplh
         PqakhTsnwSP46pYHe08+pi2IgBl7hbha3F30d+xPP+/YReWo6OslvUWccG/QYX/6Tnw1
         Tk/PR0uB7+zcItFNGB9yLxx8cx1jZwsro0DC+8z688Q9c+QoNr42A/pDAUzEn2LO1bVN
         VYoqiuJrqfDnEai5Ks5bSz98QDqKm5UHTJylfKhuPXXxNPjfttGtfFcPRJ5vViwW6pNq
         eI7g==
X-Gm-Message-State: AMke39lnNByiqLdXzamdwWcibVaH/q/RzvBlOlJ9zRyGVTozhn4jnoOEtH7RW/BiQ1rcxk7/
X-Received: by 10.99.94.195 with SMTP id s186mr42185461pgb.198.1487201586731;
        Wed, 15 Feb 2017 15:33:06 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:458b:2f1f:f100:cb93])
        by smtp.gmail.com with ESMTPSA id e90sm9472199pfl.32.2017.02.15.15.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2017 15:33:06 -0800 (PST)
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
To:     Junio C Hamano <gitster@pobox.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
 <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
 <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
 <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
 <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        sbeller@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <c609866a-f1b9-6fe5-f97a-d2180c290983@google.com>
Date:   Wed, 15 Feb 2017 15:33:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/15/2017 03:11 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> Perhaps something like this?

This looks good. I was hoping to unify the processing logic between this 
CLI parsing and the usual stream parsing, but this approach is probably 
simpler.

>  config.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index c6b874a7bf..98bf8fee32 100644
> --- a/config.c
> +++ b/config.c
> @@ -201,6 +201,20 @@ void git_config_push_parameter(const char *text)
>  	strbuf_release(&env);
>  }
>
> +static void canonicalize_config_variable_name(struct strbuf *var)
> +{
> +	char *first_dot = strchr(var->buf, '.');
> +	char *last_dot = strrchr(var->buf, '.');
> +	char *cp;
> +
> +	if (first_dot)
> +		for (cp = var->buf; *cp && cp < first_dot; cp++)

"*cp &&" is unnecessary, as far as I can tell.

> +			*cp = tolower(*cp);
> +	if (last_dot)
> +		for (cp = last_dot; *cp; cp++)
> +			*cp = tolower(*cp);
> +}
> +
>  int git_config_parse_parameter(const char *text,
>  			       config_fn_t fn, void *data)
>  {
> @@ -223,7 +237,7 @@ int git_config_parse_parameter(const char *text,
>  		strbuf_list_free(pair);
>  		return error("bogus config parameter: %s", text);
>  	}
> -	strbuf_tolower(pair[0]);
> +	canonicalize_config_variable_name(pair[0]);
>  	if (fn(pair[0]->buf, value, data) < 0) {
>  		strbuf_list_free(pair);
>  		return -1;

