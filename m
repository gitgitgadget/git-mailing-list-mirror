Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792AD1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 10:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeJLRco (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 13:32:44 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44296 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeJLRco (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 13:32:44 -0400
Received: by mail-ed1-f54.google.com with SMTP id z21-v6so10942560edb.11
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6iAKgPT97Jg9clAxks9SOSGWH+oPxLH6vzfmdlek9p8=;
        b=KBKYW/8x9sI13nXE2ZU+HBzercbJk5VQTbvkKIvOVGt6Kjh2ggG7lwHt5GjUkcnhD1
         KsF1N9pOBUItZ9sEamLKmjzvL4eGX4O+eEtgY4HKQo6K4sBg/rKK9O84rPoV+zXt7II+
         pn8eN5ZTO1xNYTYrYggHGY8HfN0bfnD2aK26pQ6X7jgs88edLbuLQnfzItSrbzzHls+z
         XIxNErkYqj122JIE625QM/y/VmFQN14vYg1gqCGZ6+OTQquiguVbVwQ+e5ICDib7HAVF
         NOvSwAEC1CLRbUFl5HYztsH1niYx3+1LZmmlD1wmrqnLrrYOiHNvwRFHq3h0Mv8Wf+K9
         BK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6iAKgPT97Jg9clAxks9SOSGWH+oPxLH6vzfmdlek9p8=;
        b=T8PiOLruIUBgBieMFkclU3ca07GhFKxRoHwGjffeWtNddvWMZoMZGxmGGTBIm1lCCz
         oBUIHnsn5ok2D3cerTCB3xEhdBXE/zo1LR1RoXXvBn1Rgdpnb+1NZT5rIqBJX3pO+MQM
         2Poq+GgLhaFZnIGlZiAzmkT8Fp10xIFRdsjYxgHrZJlqFxyZ8TWP3fxugpXbtOVN0BWb
         9zyw1r5bwvLWadWi6mTujPOU7ycemkR3+6giYjO14J7o54NPM0+BAhjrsyjW+nFo7nsw
         Y7ugf8QwBD7s7ABGB44Tfp8RZpKNT3vCGoR2n4mAha44jrnlXilGOHtxhq3UJICPR4Kl
         fpQA==
X-Gm-Message-State: ABuFfoi4qpby+ofye+WOjKRAt9UkjiAZ8SgWfOUoG0Eob43Rh0rY4AzP
        qQPT9lKI2LJAR+RwKWY8qqfu1sNX
X-Google-Smtp-Source: ACcGV61dFtPR5mcTAsNksDKYlFuaoAxKf8TOVF9u0mpG/1XGoFQwWxvuert5ZzB7B/dkG4zU9vm5Ug==
X-Received: by 2002:a50:b246:: with SMTP id o64-v6mr8265724edd.80.1539338465207;
        Fri, 12 Oct 2018 03:01:05 -0700 (PDT)
Received: from szeder.dev (x4dbe4f29.dyn.telefonica.de. [77.190.79.41])
        by smtp.gmail.com with ESMTPSA id y16-v6sm400269eds.45.2018.10.12.03.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 03:01:04 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:01:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/15] sequencer: make sequencer_make_script() write its
 script to a strbuf
Message-ID: <20181012100101.GE19800@szeder.dev>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-8-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181007195418.25752-8-alban.gruin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 07, 2018 at 09:54:10PM +0200, Alban Gruin wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 30a7fe3958..dfb8d1c974 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4083,7 +4083,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
>  }
>  
>  static int make_script_with_merges(struct pretty_print_context *pp,
> -				   struct rev_info *revs, FILE *out,
> +				   struct rev_info *revs, struct strbuf *out,
>  				   unsigned flags)
>  {
>  	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
> @@ -4230,7 +4230,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  	 * gathering commits not yet shown, reversing the list on the fly,
>  	 * then outputting that list (labeling revisions as needed).
>  	 */
> -	fprintf(out, "%s onto\n", cmd_label);
> +	strbuf_addf(out, "%s onto\n", cmd_label);
>  	for (iter = tips; iter; iter = iter->next) {
>  		struct commit_list *list = NULL, *iter2;
>  
> @@ -4240,9 +4240,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  		entry = oidmap_get(&state.commit2label, &commit->object.oid);
>  
>  		if (entry)
> -			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
> +			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
>  		else
> -			fprintf(out, "\n");
> +			strbuf_addf(out, "\n");

Please use plain strbuf_add() here.

Or strbuf_complete_line()?  Dunno, as seen in the previous hunk, 'out'
won't be empty at this point.

