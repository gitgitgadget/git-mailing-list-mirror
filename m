Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4876C1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 02:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeHWFnJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 01:43:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42726 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeHWFnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 01:43:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so1876201pff.9
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 19:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rmVY152qqQGx5kIdyE0GJGynwF+oiJaekuJ8gUry5gA=;
        b=BU95J2XkzojiWUC1/3lEUJbp08pHeIdb0Lo7/EaZRSKN3yB04TK1cUjH2IlAObKHso
         1R9/Ei7U3s6sVQ26FV3MB292N4ANFbVUNfXhjbe2oQ+qpnq94kGqtEQOocuN8eDFyj7u
         bX24emEaMrCiSAa4fQRiBlPvVz8vw9xxipKFTtuYHSEcV4cR9CP64j6bLIFgVl+ilG9o
         ZX+2FMFFxN1qzvkD5FeGBGbo6E78i83NUMpRI58rBWlv2basKOeYlSfQNIRU6mXrLeUz
         aQS1OmTreKzy0149+1koCf9wKouhGWXX+TdSTincDIr5SiH5BfF+F+TTojL7/3iM18mh
         sQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmVY152qqQGx5kIdyE0GJGynwF+oiJaekuJ8gUry5gA=;
        b=H/HPjYUrmvgkQ79ozeSN1QJUSiqqpLoD7XaypIBtaCYtRYNtZD+zQr4cfbgzczZEr/
         FNYYRyhnxlOqN33Ax8yv9xNQJwrGMsqRAoym6gZ4XfmAqxIHPonnZ98z24nVsCIYR2Xh
         Ikr9vC+uIYb/6Y0yOiK4SlEV76vosEBpPOCKLVeOG85AvbSE8rK5GcDbS/akJkquWs0C
         vXEU8AN6D+fZAcNfk1jVP6gCl8lw3Hr09B/pql/3d49Cm5MVohFkB6987YkK6xrzjFDk
         3XySc9hCOkeRJA/jy4MKq0Lk+psmz/58MnzMwNYA/jvKGjJ3AjdD7FDaic7lM3snFihA
         fozQ==
X-Gm-Message-State: APzg51A1bYHdpvt6dxCrjkew27X4wYhaVPP2ZAJoBIgl0LY9eo9yhnVD
        MKczWL6uyH3T7PHRJItwY+pZIqkK
X-Google-Smtp-Source: ANB0VdYK2YzxlY55wMeOZlHNHcxF2jDz2dvVNTfGyDvChDnBTdmnxFv7Q2nngsB0KiQPVdjLvXEJaw==
X-Received: by 2002:a63:a619:: with SMTP id t25-v6mr1879783pge.288.1534990549282;
        Wed, 22 Aug 2018 19:15:49 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x24-v6sm4192770pfh.67.2018.08.22.19.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 19:15:48 -0700 (PDT)
Date:   Wed, 22 Aug 2018 19:15:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already
 staged
Message-ID: <20180823021547.GE92374@aiede.svl.corp.google.com>
References: <20180820154120.19297-1-pclouds@gmail.com>
 <20180820193007.GB31020@aiede.svl.corp.google.com>
 <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
 <20180823021156.GD92374@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823021156.GD92374@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few quick corrections:

Jonathan Nieder wrote:

> I'm starting to lean toward having this on unconditionally, with a
> message that points the user who really doesn't want to clobber their

... who really *does* want to clobber their index ...

> index toward "git add -u", as a good idea.  I think that for humans,
> that would be okay and that configuration doesn't really help much
> for this.
>
> The remaining question becomes scripts.  A script might do
>
>	... modify old-file and create new-file ...
> 	git add new-file
> 	git commit -m "some great message"
>
> which would trip this error.  For that matter, humans might do that,
> too.  Could the check detect this case (where the only changes in the
> index are additions of new files) and treat it as non-destructive?

(where the only changes in the index are additions of new files *that
match the worktree*)

Sorry for the noise,
Jonathan
