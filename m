Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A0B20248
	for <e@80x24.org>; Tue,  9 Apr 2019 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfDIV7A (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 17:59:00 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:35526 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDIV7A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 17:59:00 -0400
Received: by mail-pf1-f182.google.com with SMTP id t21so84839pfh.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eOg6vRVmAFoV4OLnVR6AMpa0+QU88+S8cJxLDXdIGLs=;
        b=gdL8EekPLuKdL5ibY0ihvTWiq5ecmbKeOJ0WNrOcJl8x1QlOQv8RBWUi4vdrjgBIgb
         vTloo61lXDzrb5G7sLjG97fWa+/4+SUOXDdQBQS519lxdme9jHE3mrPz9fJpTEdP0ZRc
         qSC2uVF7TUoVw39VE+FWZjzvV9bz+1gk1m50I6DwyqAl2y84dNyA+aeY5jY3ykruTW/D
         rd0p/A120n77q0e8htaCWl5NCeMrDTXXS6F/tH+WH71kgTIw+FoSJ3tdAdl38uNMcBua
         qTU4Z2Ky1nD1EaY+krbRBgv1kawYobu80/OuHXcXLNZFw2uBS1DTmFtfsQAHBUYIccDr
         /GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eOg6vRVmAFoV4OLnVR6AMpa0+QU88+S8cJxLDXdIGLs=;
        b=lYVOQBeYMohmhOoBSaaFLsuobnciVei/Jy8+NsOvArxd06af4m0Yvd1JnHwQSIxt5o
         SBNDqeQTlHViaFOo+Vf1V02klKEa0LURMAbWKAo5R4pkcFui40YBLWuxDdxHcdosU0Mo
         jdbtDeDP3VVkiBFnGkqFtY50x+rmnhB7gMQC8SbmZ4nVgs2oj98X6ckS3A3wc+2VX6bf
         Nca+YBFTxpEjAX43mmDVKXbQZ1humHqG3Yf86VqPGEiNhM8P13IIbipe1Zog0YmaML7C
         9AKRNyB8zUUXWMrwdLIY8n4O4EbkLOXNTmpo/oDhfR/UNmBfxdOIUpo8Ep8T198EyIhn
         0Vkw==
X-Gm-Message-State: APjAAAWZo6LJmvNelbTmslCgeUfxEC6O08ekwhXrhRKbr8iPBT0daT9L
        2upt7EcK+Vh20ucJORdNfFXQTLkg
X-Google-Smtp-Source: APXvYqxpFsIFbA2vRLN+HzeDOcgpgKfjeKwrXJTwVgIoms0WVR0d7+4COic39kz5wMJkc+qCSFFDeQ==
X-Received: by 2002:a62:5797:: with SMTP id i23mr38278583pfj.12.1554847138919;
        Tue, 09 Apr 2019 14:58:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id f63sm55700667pfc.180.2019.04.09.14.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 14:58:58 -0700 (PDT)
Date:   Tue, 9 Apr 2019 14:58:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] send-email: fix transferencoding config option
Message-ID: <20190409215856.GD92879@google.com>
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409192733.10173-1-xypron.glpk@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(thanks for cc-ing bmc!)
Hi,

Heinrich Schuchardt wrote:

> Subject: send-email: fix transferencoding config option

nit: "fix" doesn't tell me what was broken and what you improved about
it.  Here, I think you mean "respect transferencoding config option".

> Since e67a228cd8a ("send-email: automatically determine transfer-encoding")
> the value of sendmail.transferencoding is ignored because when parsing
> the configuration $target_xfer_encoding is not initial anymore.

nit: I was confused when first reading this, since I read "the
configuration $target_xfer_encoding" as a single phrase.  A comma
after "configuration" might help.

> Instead of initializing variable $target_xfer_encoding on definition we
> have to set it to the default value of 'auto' if is initial after parsing
> the configuration files.

run-on sentence.  I'm having trouble parsing this part.

Can you start from the beginning and describe again what this does?
In other words, tell me

- What is the user-facing effect of the change?  What workflow is it
  part of?

- Any risks or complications?

- Any technical details that might be interesting to the later reader?

- What does this allow me to do that I couldn't do before?

The code can speak for itself, so this should primarily focus on the
intention behind the change.

[...]
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -146,7 +146,7 @@ Note that no attempts whatsoever are made to validate the encoding.
>  	even more opaque.  auto will use 8bit when possible, and quoted-printable
>  	otherwise.
>  +
> -Default is the value of the `sendemail.transferEncoding` configuration
> +Default is the value of the `sendemail.transferencoding` configuration

Unrelated change?

[...]
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -239,7 +239,7 @@ sub do_edit {
>  my (@suppress_cc);
>  my ($auto_8bit_encoding);
>  my ($compose_encoding);
> -my $target_xfer_encoding = 'auto';
> +my ($target_xfer_encoding);
> 
>  my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
> 
> @@ -446,6 +446,8 @@ sub read_config {
>  			$smtp_encryption = 'ssl';
>  		}
>  	}
> +
> +	$target_xfer_encoding = 'auto' unless (defined $target_xfer_encoding);

Makes sense.

Is there a way to cover this in tests (t/t9001-send-email.sh) so we
can avoid regressing again?

The rest looks good.

Thanks for noticing, and hope that helps,
Jonathan
