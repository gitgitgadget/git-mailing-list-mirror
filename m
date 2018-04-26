Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D181F424
	for <e@80x24.org>; Thu, 26 Apr 2018 06:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeDZGBU (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 02:01:20 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36186 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeDZGBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 02:01:19 -0400
Received: by mail-pg0-f42.google.com with SMTP id i6so15092632pgv.3
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQnd4SPITCGOm4S8k+O0n8NMm7R13gny7G8oFVM+eLg=;
        b=P/JvuWhx6QBYWvFmBhmKjujTKpsdLWt31VpfKMfkQC6+xflGkoUf9kuuwlt8BbLy51
         PxJqYFWV4OTPIlbiNQBtpzIGtBghDY/MCxhBsfJoqNnKVmm1o7LfbVFG6M3aS8d8ZRPQ
         h6STNP0vGKQyFT43r8BTbeREWW6gRJwMzFMQqdtpcq+Ob6JAB3Tl6y5bD2wf/fI1Gm2/
         BGlT30QWm+cqUoNLiaG/UY2Y1n7vDRS0zGmrLIGqR7P4l7Ew+icSHRGNVE1X3Ou0d/2V
         oYr47x14RGyJQ6XmyTOzeeWA9kvKLcRC3AdEowmhBQy3RncOlVw2LoWFV6Ku9XWtSCdz
         HZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQnd4SPITCGOm4S8k+O0n8NMm7R13gny7G8oFVM+eLg=;
        b=OyjTUeywGkV/GlCE9EfAyV79ReSk9kwSLsRbRzFnH8JSM2hlDYGQ0YSg+8QoEuZi/c
         OgdiwxxTZVATLJCGyQvU7T37W1Juotv4VPsBSdpvzhXOUDCgCZ564rn6AhBwagiP+hCt
         fLwyoHCAVDe1iR5ZVd4SOjZkivOEkRC2QSDUqKSR41jTqJ6Np0r5sSICiGk/moDPXD23
         hiZAho7fJrthVoVPmcuH9TXfkTfc6mG0adwhArVsa8vTFDrMwBtb2mgvnQ+Gj7wkSHPH
         a099ZFVGCsx0eBG/HPXIuUStuqCRR6c5V1lU9CaP2yYRWDRP7eHHLZLEq81C7SmKlPCY
         Bz6w==
X-Gm-Message-State: ALQs6tCrLBZDlkItwHq6RRVeugJpL3vfLp4I94yZodcwiillssdw+x7H
        lenHTnekeKYJV7Jl5GbZzQBrFQ==
X-Google-Smtp-Source: AB8JxZpmYDvfq8PHV93eaY0ckv8HQpmVXrrZQkbhdU8B3GDUfyt5UVvInrh3mqVX9LgKzcP2DMKXag==
X-Received: by 10.101.77.3 with SMTP id i3mr3141373pgt.452.1524722477825;
        Wed, 25 Apr 2018 23:01:17 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id k63sm14489922pfk.90.2018.04.25.23.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 23:01:16 -0700 (PDT)
Date:   Wed, 25 Apr 2018 23:01:15 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] builtin/config: introduce `color` type specifier
Message-ID: <20180426060115.GA40265@syl.local>
References: <cover.1524716420.git.me@ttaylorr.com>
 <17188b9f3250e4d3547f81b4aaf70a209941b1b5.1524716420.git.me@ttaylorr.com>
 <xmqq36zi352x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36zi352x.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 02:32:54PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/builtin/config.c b/builtin/config.c
> > index d7acf912cd..ec5c11293b 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -61,6 +61,7 @@ static int show_origin;
> >  #define TYPE_BOOL_OR_INT	3
> >  #define TYPE_PATH		4
> >  #define TYPE_EXPIRY_DATE	5
> > +#define TYPE_COLOR		6
> >
> >  #define OPT_CALLBACK_VALUE(s, l, v, h, i) \
> >  	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
> > @@ -231,6 +232,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
> >  			if (git_config_expiry_date(&t, key_, value_) < 0)
> >  				return -1;
> >  			strbuf_addf(buf, "%"PRItime, t);
> > +		} else if (type == TYPE_COLOR) {
> > +			char v[COLOR_MAXLEN];
> > +			if (git_config_color(v, key_, value_) < 0)
> > +				return -1;
> > +			strbuf_addstr(buf, v);
> >  		} else if (value_) {
> >  			strbuf_addstr(buf, value_);
> >  		} else {
> > @@ -376,6 +382,20 @@ static char *normalize_value(const char *key, const char *value)
> >  		else
> >  			return xstrdup(v ? "true" : "false");
> >  	}
> > +	if (type == TYPE_COLOR) {
> > +		char v[COLOR_MAXLEN];
> > +		if (git_config_color(v, key, value))
> > +			die("cannot parse color '%s'", value);
> > +
> > +		/*
> > +		 * The contents of `v` now contain an ANSI escape
> > +		 * sequence, not suitable for including within a
> > +		 * configuration file. Treat the above as a
> > +		 * "sanity-check", and return the given value, which we
> > +		 * know is representable as valid color code.
> > +		 */
> > +		return xstrdup(value);
> > +	}
> >
> >  	die("BUG: cannot normalize type %d", type);
> >  }
>
> Hmmm, option_parse_type() introduced in [PATCH 2/5] used to learn
> to parse "color" in this step, but it no longer does.

Oof, again. I dropped this hunk on the floor when integrating. I put it
back in v2.


Thanks,
Taylor
