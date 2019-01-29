Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7F81F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfA2WmO (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:42:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45203 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2WmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 17:42:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so24145797qtr.12
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gA7YI0wvMMbtv6hxx8W1U3ygBvtlKCZ8o9dk86XJMuM=;
        b=FAKcYFulIa6ef3QmQfPy82qA/3cm9HTOlFHYUVqFogIhIAH2sk2AgjkdHMARHF0k98
         8nPF6ub+Ai+k80fBRbJCSbFnn/eZ9jd6Iz4mRm+7mo7kWy8JtUiw2l8OYk/RjZkfKs31
         BazEKuzeXWaAjrORMoieu8lo3e2o2PYsPa9gJSVYs+gDwU5WCF1/S042ZrVZaLEL9Gnv
         1hFEkUQCXzp3L6bQ4al8M4c4BBKf0tAdS/UhZYflG+vHTh9F9AWXk6UV4SnyhKhUx7kw
         uUMo27EqIsumjQu+lKgWhoiOxEWdnHvZkp7tpJTzp9pgwQlDwDbZeCarW7FpMoUZLSYG
         K7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gA7YI0wvMMbtv6hxx8W1U3ygBvtlKCZ8o9dk86XJMuM=;
        b=iHX9Pg6R44Y4b4y4xK9XwKJy5WbMK1y/MB6AWmlf3xAwH980AP+yG4DjlkmkIwdrAf
         KSd2xBQ482mN7/iqJ6Q1Uk+d8Lke/fsz/f+GLOGOh2WsoXsayqG0hHSEBgY1Fm37Jcnm
         QdvrLwI7iriiZgsOT0J/buiDr+0j49lLA3NyOz4uvBSCbq9f6gD/7sJBy5ODi8zldeFB
         Nj9dd1iOaKthq937fHEmZCFWMXe8ZQ+KobP7A/HbAeSw5vysn+yp9oYW6CL06BlQmulj
         jDoX7kWc3tc/6qiKYIn/rG/OVJV6c/p5ku3rY5u4pq1iwLJzb3BYYCO0fpRP5PbEX0qx
         qpXw==
X-Gm-Message-State: AJcUukfIqO0tfig1Lxet2PlR2yO6RyMi+Xmc4IiGJaC8S7+zZ0EMoLoS
        Kfzt7oK5J5bNC93kFRs7yoY=
X-Google-Smtp-Source: AHgI3Ib4gsZkuSQLZjPYMg/PznTR5TlaY9TZe3PQeCxfRJtblgUTyifbGdkGo9z8R0YPV3mUTHVI2w==
X-Received: by 2002:aed:2539:: with SMTP id v54mr6703872qtc.211.1548801732451;
        Tue, 29 Jan 2019 14:42:12 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id l4sm57757959qtf.22.2019.01.29.14.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 14:42:10 -0800 (PST)
Received: (nullmailer pid 4878 invoked by uid 1000);
        Tue, 29 Jan 2019 22:42:09 -0000
Date:   Tue, 29 Jan 2019 16:42:09 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v2 1/2] config: allow giving separate author and
 committer idents
Message-ID: <20190129224209.GA3392@whubbs1.gaikai.biz>
References: <20190125215955.30032-1-williamh@gentoo.org>
 <20190125215955.30032-2-williamh@gentoo.org>
 <877ees4a65.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ees4a65.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 11:58:10PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jan 25 2019, William Hubbs wrote:
> 
> > @@ -480,6 +515,46 @@ int git_ident_config(const char *var, const char *value, void *data)
> >  		return 0;
> >  	}
> >
> > +	if (!strcmp(var, "author.name")) {
> > +		if (!value)
> > +			return config_error_nonbool(var);
> > +		strbuf_reset(&git_author_name);
> > +		strbuf_addstr(&git_author_name, value);
> > +		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
> > +		ident_config_given |= IDENT_NAME_GIVEN;
> > +		return 0;
> > +	}
> > +
> > +	if (!strcmp(var, "author.email")) {
> > +		if (!value)
> > +			return config_error_nonbool(var);
> > +		strbuf_reset(&git_author_email);
> > +		strbuf_addstr(&git_author_email, value);
> > +		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> > +		ident_config_given |= IDENT_MAIL_GIVEN;
> > +		return 0;
> > +	}
> > +
> > +	if (!strcmp(var, "committer.name")) {
> > +		if (!value)
> > +			return config_error_nonbool(var);
> > +		strbuf_reset(&git_committer_name);
> > +		strbuf_addstr(&git_committer_name, value);
> > +		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
> > +		ident_config_given |= IDENT_NAME_GIVEN;
> > +		return 0;
> > +	}
> > +
> > +	if (!strcmp(var, "committer.email")) {
> > +		if (!value)
> > +			return config_error_nonbool(var);
> > +		strbuf_reset(&git_committer_email);
> > +		strbuf_addstr(&git_committer_email, value);
> > +		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> > +		ident_config_given |= IDENT_MAIL_GIVEN;
> > +		return 0;
> > +	}
> > +
> 
> This whole thing should be split into a static function. It's the same
> code copy/pasted 4x times just with a differnet value for "var", the
> strbuf variable & IDENT_*_GIVEN.

I have moved most of this into a separate function in the next version
of the patch. However, I do not see a way to factor it down further. Let
me know what you think when I resend.

Also, if you see anything  longer than 79 characters, please let me know
where the long lines are and I have no problem reformatting them.

Thanks much.

William

