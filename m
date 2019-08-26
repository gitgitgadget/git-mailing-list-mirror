Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC111F461
	for <e@80x24.org>; Mon, 26 Aug 2019 23:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfHZXRS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:17:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33940 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHZXRS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:17:18 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so41748201ioa.1
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8do6TqQy68xwXHIskKmiHMe1rSuj6PS/u89BmUhq16E=;
        b=PPomyCtocljaQdjdL+YAP3M8ONiVdR5TUXiRKTbFKQFg2O2ef+F6I6DRq44SFLjhH5
         kRjfyxQuX/BqG3yQUfF4PcRlA+DZMibFnw3a4lyT/QEvse73rnvaYCl+/Gq6IhA8vWO+
         aJ2m+63W+rfsX+nWqjKFD+PJTv6nfzJWS0f3b6AcSOAZUHj3g5aYWXU9tgS2KotdiMSa
         Rjo/L/MeYP5FXhc2H65C54R0cAVSY2BRQmpJsl2YaevQp0P5gs3S3WWD3jV1QucKAJAY
         MZZAHqF4IVdN0GILsOLgxPLIMbbGJq/tmp3IV1yMqQsfU06IX7Kfgu/R+u6KcCHZsEqf
         6wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8do6TqQy68xwXHIskKmiHMe1rSuj6PS/u89BmUhq16E=;
        b=M0ymjAjjBMC3KRxC4SO2bFm4fzs9yf6Zxnzb8Vk6U2CuqA+r2dfrmmIB1l8QGL9gqc
         ma/zjvF23LdRtjs4WmnHWAp8TgKtAlmzjj9nFQENEtHBX+WaHUNL7iRLhoEV25eOZCSj
         7co5baxYFqgUwbT8iXYGGWcqDlk6z82aIBuE31iQDL1XAaHFwZ8KW3Ui7c0FES4mx0v+
         XTh6Y2JEhOivLJ9t0oBJvAh8FDigZsIOp5FYSyChHVQn/EXOH4+eGdegsYHiyp/cknXl
         zbC1TbnKFzkt7BPDTaIui9lEclgU6ZK2Jm7oSwLv/td6Jsw0X9yFR85LcrZdzAwpL9hD
         KyZg==
X-Gm-Message-State: APjAAAWjN3g3skxiw9ZAw3b6V9T3ym4vXZupLEch34JZVMM09pDoKkkj
        gK3yTuz7gCfCDlvLBdQZX78=
X-Google-Smtp-Source: APXvYqzT1HrbEHXXwMZASqb41AsL3wVmWo4YULIX3Oh0/bdwCMokJcU+lKkVUYLPrpd6xU2cviQSfw==
X-Received: by 2002:a02:a409:: with SMTP id c9mr3948401jal.74.1566861437484;
        Mon, 26 Aug 2019 16:17:17 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id 8sm10482304ion.26.2019.08.26.16.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 16:17:16 -0700 (PDT)
Date:   Mon, 26 Aug 2019 19:17:14 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v9 5/9] rebase: refactor can_fast_forward into goto tower
Message-ID: <20190826231714.GA13827@archbookpro.localdomain>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
 <9bd34b4a404136c974b71975c7a3d809a874cc3d.1566724236.git.liu.denton@gmail.com>
 <20190825130235.bsbknf7sky44kwt7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825130235.bsbknf7sky44kwt7@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 06:47:02PM +0530, Pratyush Yadav wrote:
> On 25/08/19 05:12AM, Denton Liu wrote:
> > Before, can_fast_forward was written with an if-else statement. However,
> > in the future, we may be adding more termination cases which would lead
> > to deeply nested if statements.
> > 
> > Refactor to use a goto tower so that future cases can be easily
> > inserted.
> > 
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  builtin/rebase.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 670096c065..22c4f1ff93 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1264,21 +1264,27 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
> >  			    struct object_id *merge_base)
> >  {
> >  	struct commit *head = lookup_commit(the_repository, head_oid);
> > -	struct commit_list *merge_bases;
> > -	int res;
> > +	struct commit_list *merge_bases = NULL;
> > +	int res = 0;
> >  
> >  	if (!head)
> > -		return 0;
> > +		goto done;
> >  
> >  	merge_bases = get_merge_bases(onto, head);
> > -	if (merge_bases && !merge_bases->next) {
> > -		oidcpy(merge_base, &merge_bases->item->object.oid);
> > -		res = oideq(merge_base, &onto->object.oid);
> > -	} else {
> > +	if (!merge_bases || merge_bases->next) {
> >  		oidcpy(merge_base, &null_oid);
> > -		res = 0;
> > +		goto done;
> >  	}
> > -	free_commit_list(merge_bases);
> > +
> > +	oidcpy(merge_base, &merge_bases->item->object.oid);
> > +	if (!oideq(merge_base, &onto->object.oid))
> > +		goto done;
> > +
> > +	res = 1;
> > +
> > +done:
> > +	if (merge_bases)
> > +		free_commit_list(merge_bases);
> 
> free_commit_list() returns immediately when a NULL pointer is passed in, 
> so I'm not sure if this check is really necessary. I think it is a 
> reasonable assumption to make that free* functions work well with NULL 
> inputs.

I didn't realise that free_commit_list() would freely accept a NULL
pointer without segfaulting. I'll remove the surrounding if.

> 
> >  	return res && is_linear_history(onto, head);
> >  }
> >  
> 
> Out of curiosity, since you are going with a goto tower, why not do 
> something like:
> 
> done_merge_bases:
> free_commit_list(merge_bases);
> done:
> return res && is_linear_history(onto, head);
> 
> You jump to done_merge_bases after you have initialized merge_bases, and 
> directly to done before initializing it.

I opted to do it this way since I figured it was less complexity to have
a common jump target at the end. Also, in case in the future we decided
to add more logic before merge_bases was initialised, we wouldn't have
to worry about figuring out which target to jump to.

> 
> I'm not advocating for either way, just curious if there is a specific 
> reason to do it your way. Anyway, if you drop the if (merge_bases), then 
> it doesn't really matter I suppose.

I'm pretty impartial as well. I'll drop the if and leave the rest as is
unless someone else feels strongly about this.

> 
> -- 
> Regards,
> Pratyush Yadav
