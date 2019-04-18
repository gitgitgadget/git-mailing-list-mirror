Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCB620248
	for <e@80x24.org>; Thu, 18 Apr 2019 17:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfDRRVP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 13:21:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33899 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRRVP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 13:21:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so1481890plt.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d9rYqLLGjx6JX2CO3aUDN2yFFVFoS1l+i6dtFF6apMU=;
        b=GhTDnwnEACRfduovOQLvkiun9619xCyrkInlztXpJZq6xSh7ADcbmb96838CeFDJKd
         DyjBbeByEw5wdJxIBE+AqkTmGTZDUgHLb7Ozk02Kd0l6qbYGyIgblazAWKM//EIBahrr
         uifiBDHgGSNWCTzTVxGpksaFFXUlLkfXXMPeVQsBh11D/KMuXr1WGNC5x29uvSFdPy0/
         V7QWag0sNDpanX5nD2HPBQPyvUzbbqqs/xyXAd9Ne2FQwRcT5x1N9dFVm7fz3xAABIVv
         NckPOzehPK3yqMAKQJ1IMD1Ldq+EXelT3GWVYehNs+rlt7AwDW2qzdmwdOssZZ8mCwvx
         GoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d9rYqLLGjx6JX2CO3aUDN2yFFVFoS1l+i6dtFF6apMU=;
        b=J/IA4lYOgW1ygdQx1mLDCLCOxFXkPAKjYcdyDo77g8apTedSeXD46fCka2hgnDj8Tr
         tso3yhLoHQenFYsjffXpQH+PhC7tAp3H3DX2j/Y4QC22ZgOeUnBexL1CTvp+oEu549e1
         Yapwexsm90sXF8498DAn8Rht3nXoPbiqFsmMmsAN6xIJRZ2MPQzUfcBS6+BWDBTbYzUV
         nGB/VZFsVSzTG2ZhsL/h7MduPXYwB89jet1weCyjC4N2A1bXeHP9VlGg8csxrKsnzW1/
         7MJZ2/FsGGxXSO/zt4CQdW5JYkyXrN0aIJaogrLKBdx9MT5DZ3LWQlZDcVdwfWN1yQwa
         Oj6A==
X-Gm-Message-State: APjAAAVFo4GlabmEjz8NoCHeJh4/u/9JB64y1Bp7tjatdOBqH+et2iF5
        In7WKPS3J+xnmcaIxfnlCKYa/ZzC
X-Google-Smtp-Source: APXvYqwO2puTH1fgEAHuea8rFsHW2O4x0XlANIAjE6XDiiQilnRaJDotj9mPkQwRCGAxwdQ4E2iQ3g==
X-Received: by 2002:a17:902:7841:: with SMTP id e1mr95110985pln.303.1555608074378;
        Thu, 18 Apr 2019 10:21:14 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id m11sm3835041pgd.12.2019.04.18.10.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:21:13 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:21:11 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v10 09/10] sequencer.c: save and restore cleanup mode
Message-ID: <20190418172111.GA14273@dev-l>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
 <20190417102330.24434-10-phillip.wood123@gmail.com>
 <20190417170247.GA9636@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417170247.GA9636@dev-l>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Apr 17, 2019 at 10:02:47AM -0700, Denton Liu wrote:
> On Wed, Apr 17, 2019 at 11:23:29AM +0100, Phillip Wood wrote:
> > From: Denton Liu <liu.denton@gmail.com>
> 
> We should drop this line before applying the patch since Phillip did all
> of the hard work for this patch and he's the primary author.

Sorry, I made the mistake of suggesting that this line be dropped. This
resulted in the patchset being queued with Phillip's gmail instead of
his dunelm email. We should probably change the authorship to
Phillip Wood <phillip.wood@dunelm.org.uk>.

Thanks,

Denton

> 
> > 
> > If the user specifies an explicit cleanup mode then save and restore it
> > so that it is preserved by 'git cherry-pick --continue'.
> > 
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> >  sequencer.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sequencer.c b/sequencer.c
> > index b049951c34..3f4b0896e3 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -535,6 +535,24 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
> >  		die(_("Invalid cleanup mode %s"), cleanup_arg);
> >  }
> >  
> > +/*
> > + * NB using int rather than enum cleanup_mode to stop clang's
> > + * -Wtautological-constant-out-of-range-compare complaining that the comparison
> > + * is always true.
> > + */
> > +static const char *describe_cleanup_mode(int cleanup_mode)
> > +{
> > +	static const char *modes[] = { "whitespace",
> > +				       "verbatim",
> > +				       "scissors",
> > +				       "strip" };
> > +
> > +	if (cleanup_mode < ARRAY_SIZE(modes))
> > +		return modes[cleanup_mode];
> > +
> > +	BUG("invalid cleanup_mode provided (%d)", cleanup_mode);
> > +}
> > +
> >  void append_conflicts_hint(struct index_state *istate,
> >  			   struct strbuf *msgbuf)
> >  {
> > @@ -2366,7 +2384,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
> >  		opts->allow_rerere_auto =
> >  			git_config_bool_or_int(key, value, &error_flag) ?
> >  				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
> > -	else
> > +	else if (!strcmp(key, "options.default-msg-cleanup")) {
> > +		opts->explicit_cleanup = 1;
> > +		opts->default_msg_cleanup = get_cleanup_mode(value, 1);
> > +	} else
> >  		return error(_("invalid key: %s"), key);
> >  
> >  	if (!error_flag)
> > @@ -2770,6 +2791,11 @@ static int save_opts(struct replay_opts *opts)
> >  		res |= git_config_set_in_file_gently(opts_file, "options.allow-rerere-auto",
> >  						     opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
> >  						     "true" : "false");
> > +
> > +	if (opts->explicit_cleanup)
> > +		res |= git_config_set_in_file_gently(opts_file,
> > +				"options.default-msg-cleanup",
> > +				describe_cleanup_mode(opts->default_msg_cleanup));
> >  	return res;
> >  }
> >  
> > -- 
> > 2.21.0
> > 
