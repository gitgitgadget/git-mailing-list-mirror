Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF2B20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbdCVWjI (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:39:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34940 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdCVWjG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:39:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so32768600pge.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQYAp6jUHlZXtp2cvX5LOwgCWGeGCfw/URwQAe5Bf6c=;
        b=SDPUUMDZ9/Cwu3z7NpVtT/yClolTWEdqsYn1IqrPVZI6j8EpD3qId1/DNeiJkPBouO
         fB52OHGrXIOYT36rm/2/lk8zO+dra7rlPnM6GmKz5J6yW7yIYY7+VwO2nujeVEl2JvGo
         owPQcZ45o+S12J+ZlZ8wdD96PnT7hFyReSbq01a7pwaS8+8gQDusIrdt2L5M6H66J9dn
         zBPIP0n//MPPi5KbP1G+HW3f+GsJeSEPT9AHtqBceNIc51bKFQFm+eRngXoxzqlkKpXn
         TIwjvZaacg05WS8bYk5WoywGQQ1qZkvb6UUiRqwGOb6gmafm2XAWlFzHzlebqvLkjnbY
         EPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQYAp6jUHlZXtp2cvX5LOwgCWGeGCfw/URwQAe5Bf6c=;
        b=tsLrhoz90HrwcD6mfTFsLQpJLqlOMgFayR7dSMSNErM/f6eW69XLmPfo1xB7EYZL+K
         7+pLheZB59jMIETlkpZRm3SUZ9iyDBUc1Vszv/bLBLeCnlVz04fcPV5aPckqL9Y1D8/w
         +Qzqovh1OxYilcE5Nyd3W+rmLW/S29v3jDkmhtAZWZoX1djy9TbOkme0nwb6leqRl6pz
         WJBjmfJ6TnpnBdQq0hhfmR3Qcx+UFgoA50Y+GUmiqEENtbaZUaQOVidWDm+pQG0mV8Ym
         wIAEuOZMtHbIHH2BLVAYxGAl03tEw1EuG79OTLoNHMDXt5o9K9sbKJSQGZB5RYiLBFme
         0AWA==
X-Gm-Message-State: AFeK/H0Hz7xuW8dRLJOhFyXwlroz7Z3lQZrerKAGThi7diGykyiksWUX0qH278IXyzWquA==
X-Received: by 10.84.171.228 with SMTP id l91mr1069575plb.84.1490222344604;
        Wed, 22 Mar 2017 15:39:04 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id p6sm5894768pgn.40.2017.03.22.15.39.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:39:04 -0700 (PDT)
Date:   Wed, 22 Mar 2017 15:39:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, ulrich.haberl@autodesk.com
Subject: Re: Warn user about known Git Rebase bug?!
Message-ID: <20170322223902.GG26108@aiede.mtv.corp.google.com>
References: <C45FE2B3-E4B5-4988-85B4-3CCB41C9ACC3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C45FE2B3-E4B5-4988-85B4-3CCB41C9ACC3@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider wrote:

> we rebased a branch using "--preserve-merges --interactive" and were 
> surprised that the operation reported success although it silently 
> omitted commits (Git 2.12 on Windows). A little search revealed that 
> these are likely known bugs [1]. Would it make sense to print an 
> appropriate warning message if a user runs rebase with 
> "--preserve-merges --interactive"?

Sounds like a good idea.  Care to suggest a patch?

Thanks,
Jonathan

> [1] https://git-scm.com/docs/git-rebase#_bugs
