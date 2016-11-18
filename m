Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6961FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 19:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbcKRT6f (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 14:58:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35050 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbcKRT6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 14:58:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so9588752wme.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 11:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ethdnOj+XHuPQQROAcRfeK4aTm8xR/NNa9XeS+kbZOw=;
        b=FqGo4fplzkTUJWiOgQdE2Knmm/9esqq+ptQqvfjXkcGtMutKc1/CVGZ+Xx1VlCe/TW
         F8vOz6kDYbyHzfsa8riqlF3r71rgTeY+JpT1DhbkmOnTgDFNOBXsj2n9ujY2yPeKm7e6
         COtOCvQLJcHIRLprpEyJ6qHIFkcE23Kf8Iewg7CzV6R9kj2lS29omjDFO1Rb6/Olr/9p
         N/HMvy+dzAiuUyXdSWaztO+a/t4M70yZAEv1ves0JeR27cQj0MsJit3qW1xWSIgQC8dX
         0LstyrqLNBHgXkePWDvNSeqJ3WsRrJrWM9m8vgB5DtoDlry1Liy4NEaPMP/Hz8httxGK
         Ye3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ethdnOj+XHuPQQROAcRfeK4aTm8xR/NNa9XeS+kbZOw=;
        b=gK4ZHihpI1U7H0AJC+H2awsPY/d2xuJ2Xlkgh90gsxv4CesxLv2VOcV2KHaG1ip7mt
         zA+dA4JqlHjm9rqxQNTGFLki7WXNai3sCQsfFb6HsIWLJvM6eHqRw09+MabnUdviuFlp
         qVi2ykQmV1Riftym9mdW2AW/JzSnH6cqDXPMA1vr3bY97hD+ujFyDGqLN3V4UBg3tS6e
         /EnebcM20dGmE1OBS4QGy50UL1xSh8vYJfsSmr8XvwYqNHJ5TMeUXSbxbDdwN2d7HHl2
         bXPXevDAbNqy98OR54WWV0xJWS1nQlTLnlbm6iEbEpbhWPydIovkAOqe5GGIOEE2Ji2A
         Q1yg==
X-Gm-Message-State: AKaTC010YBHF3Dp/1uktd0Esi5DKQaP1/lB2j+otJlS96ggpEPXiO6B1SmciNqnY8yCYnw==
X-Received: by 10.28.25.135 with SMTP id 129mr156851wmz.122.1479499112458;
        Fri, 18 Nov 2016 11:58:32 -0800 (PST)
Received: from [192.168.1.26] (acuy2.neoplus.adsl.tpnet.pl. [83.11.104.2])
        by smtp.googlemail.com with ESMTPSA id cl6sm3244377wjc.10.2016.11.18.11.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Nov 2016 11:58:31 -0800 (PST)
Subject: Re: [PATCH v7 03/17] ref-filter: implement %(if:equals=<string>) and
 %(if:notequals=<string>)
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20161108201211.25213-1-Karthik.188@gmail.com>
 <20161108201211.25213-4-Karthik.188@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <37c2cbf2-7160-49d7-f8f1-3b65d9ecf9ec@gmail.com>
Date:   Fri, 18 Nov 2016 20:58:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161108201211.25213-4-Karthik.188@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 08.11.2016 o 21:11, Karthik Nayak pisze:
> From: Karthik Nayak <karthik.188@gmail.com>
> 
> Implement %(if:equals=<string>) wherein the if condition is only
> satisfied if the value obtained between the %(if:...) and %(then) atom
> is the same as the given '<string>'.
> 
> Similarly, implement (if:notequals=<string>) wherein the if condition
> is only satisfied if the value obtained between the %(if:...) and
> %(then) atom is differnt from the given '<string>'.
                  ^^^^^^^^

s/differnt/different/   <-- typo

> 
> This is done by introducing 'if_atom_parser()' which parses the given
> %(if) atom and then stores the data in used_atom which is later passed
> on to the used_atom of the %(then) atom, so that it can do the required
> comparisons.

Nb. the syntax reminds me a bit of RPM SPEC language.

> 
> Add tests and Documentation for the same.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  3 +++
>  ref-filter.c                       | 43 +++++++++++++++++++++++++++++++++-----
>  t/t6302-for-each-ref-filter.sh     | 18 ++++++++++++++++
>  3 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index fed8126..b7b8560 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -155,6 +155,9 @@ if::
>  	evaluating the string before %(then), this is useful when we
>  	use the %(HEAD) atom which prints either "*" or " " and we
>  	want to apply the 'if' condition only on the 'HEAD' ref.

So %(if) is actually %(if:notempty) ?  Just kidding.

> +	Append ":equals=<string>" or ":notequals=<string>" to compare
> +	the value between the %(if:...) and %(then) atoms with the
> +	given string.
>  
>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
> diff --git a/ref-filter.c b/ref-filter.c
> index 8392303..44481c3 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -22,6 +22,8 @@ struct align {
>  };
>  
>  struct if_then_else {
> +	const char *if_equals,
> +		*not_equals;

I guess using anonymous structs from C11 here...

>  	unsigned int then_atom_seen : 1,
>  		else_atom_seen : 1,
>  		condition_satisfied : 1;
> @@ -49,6 +51,10 @@ static struct used_atom {
>  			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>  			unsigned int nlines;
>  		} contents;
> +		struct {
> +			const char *if_equals,
> +				*not_equals;
> +		} if_then_else;

...to avoid code duplication there is rather out of question?

>  		enum { O_FULL, O_SHORT } objectname;
>  	} u;
>  } *used_atom;
> @@ -169,6 +175,19 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
>  	string_list_clear(&params, 0);
>  }
>  
> +static void if_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +	if (!arg)
> +		return;
> +	else if (skip_prefix(arg, "equals=", &atom->u.if_then_else.if_equals))
> +		 ;
> +	else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.not_equals))
> +		;

Those ';' should be perfectly aligned, isn't it?
 
[...]
> +test_expect_success 'check %(if:equals=<string>)' '
> +	git for-each-ref --format="%(if:equals=master)%(refname:short)%(then)Found master%(else)Not master%(end)" refs/heads/ >actual &&
> +	cat >expect <<-\EOF &&
> +	Found master
> +	Not master
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check %(if:notequals=<string>)' '
> +	git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
> +	cat >expect <<-\EOF &&
> +	Found master
> +	Not master
> +	EOF
> +	test_cmp expect actual
> +'

Nice!

-- 
Jakub Narębski

