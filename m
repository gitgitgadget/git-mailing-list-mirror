Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B9C1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 00:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBVArD (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 19:47:03 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33061 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBVArD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 19:47:03 -0500
Received: by mail-pg1-f176.google.com with SMTP id h11so276432pgl.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 16:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+iCS+Aj/KOh7sNS5PHihPTSTo1IovjPkq0ECqpjvZZQ=;
        b=ZsmYGmWkIlaFz8g5tmk/FebrmP1QRoMNOE3zQ8+NmeeFhKKwV4UnlUWIwN/XIZW7a/
         j2aFYZ45/c9AD3HfbwOFCIITV5zqMqs5BHeNoM3baTKFe+KHK/LSHPtxh8NvFDOC9YhR
         cWaW7Ezwgq+5lHFW0Ryzcd7VD/Chz2R1Hmi5je4ku5GItYGyQCwIj1mssyjY017O7rWq
         9U32w0ECEfoGLuPIO1H7zSvIEY5BzbDT3aZTI56bzX9RwIyb21swC5tOgDy30UOC9Mze
         s/916KUUqYAdpyB1Ux9CPKtTvKASi3QEdICFnE8CzxqU1JVlR+xFR249oYvdS9scgwO+
         3vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+iCS+Aj/KOh7sNS5PHihPTSTo1IovjPkq0ECqpjvZZQ=;
        b=KvfyhKk3oIFAQ9T46bsGkPsjWro5hlx+kOFCEe10GzGI01zmKA2BPNP7cfKCOQiO8+
         KznpStXbvE1QCVbNWn0NC2j1eO8jV8X2OvOxUQe/EwY2cylkSw3wHA96DtZ+fOLUBUcD
         /4TzqhH1fm68qvOs+Aye7zyiSaVDScF2vy+fBFYgc741b/QyNMC886ys+H1/9ogSRNn4
         E3bQG5S+HhTSTYmx6L9Ug9bVI+zCNFu8Mez4Dq1YqHINg3eZgkTTJBzn4m53rtq3gbQW
         5aBI+KETlyOuCBKtrDfz/6qBGrvGINzcPIOp2mtZnKQyKJR5zfehsOFBN427ZxMW+C7B
         oO6Q==
X-Gm-Message-State: AHQUAuZsFhVESLj2Yyc/WbmgXIGB7y8DID/Qld446NB+BdLMJQpwANGM
        dtBeqdzo+KVahDEIgaNPwFY=
X-Google-Smtp-Source: AHgI3IYpwTtBxdRBFotiSSe9mfFWnOB2C6Ck+g9065UtVXvyxI8VWn5AoGHzlnTGOd3U6lFRuK5KLA==
X-Received: by 2002:a63:100c:: with SMTP id f12mr1305973pgl.324.1550796422005;
        Thu, 21 Feb 2019 16:47:02 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id l10sm279887pfc.90.2019.02.21.16.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 16:47:01 -0800 (PST)
Date:   Thu, 21 Feb 2019 16:46:59 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [Suggestion] Add Skip for t9020
Message-ID: <20190222004659.GA167507@google.com>
References: <004b01d4ca23$faebcad0$f0c36070$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004b01d4ca23$faebcad0$f0c36070$@nexbridge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Randall S. Becker wrote:

> While this is a bit of a hack, it might be useful for skipping t9020 in
> environments where the svn.remote package is not installed. I can make this
> into a patch if this style is reasonable - guessing probably not and that
> the REMOTE_SVN test should go elsewhere if it is called that.
>
> diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
> index 6fca08e5e3..31edf99371 100755
> --- a/t/t9020-remote-svn.sh
> +++ b/t/t9020-remote-svn.sh
> @@ -12,6 +12,12 @@ then
>         test_done
>  fi
>
> +python -c "import svn.remote" 2>/dev/null >/dev/null
> +if [ $? -eq 0 ]; then
> +       test_set_prereq REMOTE_SVN
> +fi
> +if ! test_have_prereq REMOTE_SVN
> +then
> +       skip_all='skipping remote-svn tests, python svn.remote not
> available'
> +       test_done
> +fi

Interesting.  Where do we use the svn.remote package?  I did a quick
grep and didn't find any instances.

Do you have output from running "./t9020-remote-svn.sh -v -i"?

Thanks,
Jonathan
