Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB4E1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 20:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeCZUy2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 16:54:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45370 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZUy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 16:54:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id l27so8000907pfk.12
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sn+gWD1oJWPA2+xqyq+/2XJ7XBnh1AFIIWpBtuccbF0=;
        b=MktWQ61JbwW3NWNcPll8Y1QdH/6dU94KC34uMzmKnUdB7Hf1Ti6+9Ot8wx981iTpTj
         9bn3x8kBU9HmeVZgI11y8bwWobka/tvd/i+Hy09u9Qj0bVNzO5sNOGH80fTaaNeILg29
         q5hU/afLCUhvwde9owvlV6CxR5xnNHs2P0bYFdMxtuV5B//+pylZi1iKjFGnDq0E1Pha
         3stQWS7VyRJDjgJ0sBxCf1HmMvmDnWreudldGqzInG482gEOy1eRqf9DbRdJUXmgTZ3C
         Nj8N25+Lp65nViM6xXUQo/IcBzx+9r7MLICeLy+hWM9kWmpgLHTsXlRpdDvpgJsv6c+a
         Qnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sn+gWD1oJWPA2+xqyq+/2XJ7XBnh1AFIIWpBtuccbF0=;
        b=oTC5qIHliPThTCHSV70vgjxApPZ2TynvL8BA5dWkj5qnFPPunGScLRmUYXwezpXNE0
         O8sGSE6ZM0M7zI8HBhomTv8RzEG8VvsRfuvRRT5RtKHBNs3Gep3YONJZzkigdYWa35nC
         hmoEBOvZ2XxUV/Ga1+vKB93IMAZLKx952lorkJ4BTksaxBJbxmKtDIzRGdhepAGatoxD
         sZaP31JToRaD6miCoKq7KiZ/O/3eZEJD6oK8GWESeh4NipyVznwcFp6kUj334Rn3xoF2
         OYf1cTblZ12YzY8JCHOrKrskTXwvfSJcJKvr1l7Ac5Da8eafubgEh08Ua1F8FupZkqGE
         8+Bw==
X-Gm-Message-State: AElRT7FXLN+Cl0OnjFgRjVLmfdI43gqjT+SeBqiLpAftt/eLB8VISJXS
        smde3D+bs411+QZoT/9FIFLRKjE6
X-Google-Smtp-Source: AG47ELuRE/w7vo0+YXON9u4UGcIZwOjhjRU0dzz8hG34dS82n0qukGL2wBbDTbJNJot6nmSXOq81+g==
X-Received: by 10.98.220.86 with SMTP id t83mr23098066pfg.60.1522097666675;
        Mon, 26 Mar 2018 13:54:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k2sm4842350pfb.123.2018.03.26.13.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 13:54:25 -0700 (PDT)
Date:   Mon, 26 Mar 2018 13:54:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jonathantanmy@google.com, bmwill@google.com,
        stolee@gmail.com, sbeller@google.com, peff@peff.net,
        johannes.schindelin@gmx.de, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Per-object encryption (Re: Git Merge contributor summit notes)
Message-ID: <20180326205349.GA21735@aiede.svl.corp.google.com>
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
 <874ll3yd75.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ll3yd75.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Ævar Arnfjörð Bjarmason wrote:

> It occurred to me recently that once we have such a layer it could be
> (ab)used with some relatively minor changes to do any arbitrary
> local-to-remote object content translation, unless I've missed something
> (but I just re-read hash-function-transition.txt now...).
>
> E.g. having a SHA-1 (or NewHash) local repo, but interfacing with a
> remote server so that you upload a GPG encrypted version of all your
> blobs, and have your trees reference those blobs.

Interesting!

To be clear, this would only work with deterministic encryption.
Normal GPG encryption would not have the round-tripping properties
required by the design.

If I understand correctly, it also requires both sides of the
connection to have access to the encryption key.  Otherwise they
cannot perform ordinary operations like revision walks.  So I'm not
seeing a huge advantage over ordinary transport-layer encryption.

That said, it's an interesting idea --- thanks for that.  I'm changing
the subject line since otherwise there's no way I'll find this again. :)

Jonathan
