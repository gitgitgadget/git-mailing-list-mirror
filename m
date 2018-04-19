Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748ED1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 03:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeDSDBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 23:01:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38956 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbeDSDBq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 23:01:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id z9so1895725pfe.6
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 20:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fljz4sydXtaeL6ITpVv2AULYMRDS25SzvJUiCXdJHEw=;
        b=KWpxPLcb4xoaRH6JS0o+lJ+pa5/C6ndQLuzhnk40DU2IZ83QGKplHIwjf4d0zgqYkk
         QhNWkRCt/5AsR+vdzzAE0EjRrh2imiJ36bok5hSFXvj594au7dothjebuf+5CRf2J1PT
         u29zueOEtHEOK0JfXFflHUl/htNuwF+puHTi+TQXIVK6Ry580jw2qfoQf8pWz/jRLuf6
         drQuknGfwwL03ZP/afs1Myta3GMUHxkAoQvKir+hXHwtgXY8zNev23W8X2AG4iwQHcXg
         BoZf7gwxwzruhO4tHN7uRb0GKuJz9allNSZc6yHWKmzgBn9TcAnd9/o5Ke03ibQfuwkG
         /MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fljz4sydXtaeL6ITpVv2AULYMRDS25SzvJUiCXdJHEw=;
        b=DyhfxGPcNczTtDvryXZeLb/lle85XrnvQlrR3nCdP9PscFy4jYoKETcMN2OpjWRhuX
         HzvWpmSAuqQhA9++2yq4dP9zmJJ4J2Wc0w5ddBFtgoWN97skgF3wEgeNE7DxG2lXM8u+
         G/dG0cq5cVYiF2lWgIlNdbighuRqorIsa+4FJZaAbe7bjqBMu6TlsJNkD0b2wqlcdk5T
         EsGpri4t8FpjvpPk3JQAVB0OA9e+mDoR9VS/0oUtlaJodCe98gJKKsqjWNdoM//yq9Y8
         aecJL6iVV6h30ZzxqkiCMQ82ayFNWTaARTd6JcxRiZYBLfdVfVfeflHcoG1XPMIf47rK
         Vx1Q==
X-Gm-Message-State: ALQs6tAeEa09th9r1N3Uq0VDLSlTw0p1ewTnuMJp2s7Beeuc458WCz3j
        nuTMw1qiE5np8pdFTajLBLxmzw==
X-Google-Smtp-Source: AIpwx4/i5AS9HxjE57nQtQZHWV8duXFYCc4ua/VTOmfAjv4N7I6Y+kuNw9FbuOPDlzyVVi8yqV7+rw==
X-Received: by 10.98.159.20 with SMTP id g20mr4205946pfe.75.1524106904980;
        Wed, 18 Apr 2018 20:01:44 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a8c7:1e30:a70:f65f])
        by smtp.gmail.com with ESMTPSA id f13sm5820392pfj.170.2018.04.18.20.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 20:01:43 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 18 Apr 2018 20:01:42 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, peff@peff.net
Subject: Re: [PATCH v9 2/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180419030142.GA28273@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1524087557.git.me@ttaylorr.com>
 <20180418214335.GC36803@syl.local>
 <xmqq8t9jgbe1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t9jgbe1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 11:47:50AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/builtin/config.c b/builtin/config.c
> > index 92fb8d56b1..bd7a8d0ce7 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -61,6 +61,58 @@ static int show_origin;
> >  #define TYPE_PATH		4
> >  #define TYPE_EXPIRY_DATE	5
> >
> > +#define OPT_CALLBACK_VALUE(s, l, v, h, i) \
> > +	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
> > +	PARSE_OPT_NONEG, option_parse_type, (i) }
> > +
> > +static struct option builtin_config_options[];
> > +
> > +static int option_parse_type(const struct option *opt, const char *arg,
> > +			     int unset)
> > +{
>
> Declare all local variables here.  We do not accept decl-after-statement.

My apologies, I will read Documentation/CodingGuidelines carefully. I
have generated the following patch locally:

diff --git a/builtin/config.c b/builtin/config.c
index bd7a8d0ce7..2f91ef15a4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -70,6 +70,9 @@ static struct option builtin_config_options[];
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
+	int new_type;
+	int *to_type;
+
 	if (unset) {
 		*((int *) opt->value) = 0;
 		return 0;
@@ -79,7 +82,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 	 * To support '--<type>' style flags, begin with new_type equal to
 	 * opt->defval.
 	 */
-	int new_type = opt->defval;
+	new_type = opt->defval;
 	if (!new_type) {
 		if (!strcmp(arg, "bool"))
 			new_type = TYPE_BOOL;
@@ -95,7 +98,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			die(_("unrecognized --type argument, %s"), arg);
 	}

-	int *to_type = opt->value;
+	*to_type = opt->value;
 	if (*to_type && *to_type != new_type) {
 		/*
 		 * Complain when there is a new type not equal to the old type.

---

And would be happy to apply it locally myself and send it to you via a
re-roll. You are also free to apply it yourself if it would be easier. I
do not have a preference one way or another.


Thanks,
Taylor
