Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 333D31F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 19:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeFATCQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 15:02:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:36385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753047AbeFATCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 15:02:15 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYfX0-1flSnP3Bcg-00VS1J; Fri, 01
 Jun 2018 21:02:05 +0200
Date:   Fri, 1 Jun 2018 21:01:48 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] sequencer: ensure labels that are object IDs are
 rewritten
In-Reply-To: <20180601174639.875215-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1806012101370.77@tvgsbejvaqbjf.bet>
References: <20180529163236.646275-1-sandals@crustytoothpaste.net> <20180601174639.875215-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:520aCCTdB1LXbJzemikbE/ZS1mK04YOJsbtEYRbKirz3pAIMwc3
 oxB6aUcrVNJWNZuXkxBMjaupZYCgZaTmKndcoebgiOYhNm7WL817cJSHe1M3l5AjOiLHGFv
 5ewJhbZKnlfbgmcS6q4aOfQ0NX5MaEn0W4mG7Qs79iaP8f2Y4c/qpM/5bgFC6Oc+4fYFbzM
 WhVZg61cnml+INnDufTNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9kRl7+I4mXk=:q8Pi/prpHaTkeuZLLObPLG
 QU/HPmCmf4ItlH807+EHuP1JMZ6Ir0a9M3FAO+VJChNuChYg/76bYNYNmlU7wKZAtK6TJvg65
 JR5L7I9xbuPZ80OEvKyr1uxwMNTczCL02oXytSQdxeYVTVSG3g74491cOqBsP9stub92btqY8
 hLryMN25AyBHwtlbMUyfcD7XtNpZQO+qhJGNstO1R6nb0X4ytiPZHBzeqgisHNzCPU53ZJr1P
 HW5COQ7nve3z2G9QWAd6OvKlK0sPngbR6fOsztDx5K+WWJ37vyLUBzjd0Ewl5J10ykzf028W1
 oTT3u4WjQ7x/OYf9bT/yIRqwS04WNtRp+E3fcjsmXhQtgSahVloN62svuPCJUjAMUHFx5KEpU
 UzoE7qN6br4KT9+hngLH1LYQbQarDkagfCaSZQy0b/6/3GYpm6RzURIXfUOpvqWQDg8COT1h/
 R/SscJsnLEN8L+Twfm8GZ/X1S88787xSg0XiumHRXywWLxYqxeabyjqO7zLdGMRKHdm93sAlg
 cM+zndtSuZD4K4mr7gDbvL2F0+Lnxn3smTFVMhQwr+rLiZWWNznxiRsdksqOC6b0S35p4XMtp
 9ku83MgTRMLdou1QzZATxtKEsy0Ib+ISmJU8fELElaYqZQ8xsHt68j6JDXRd+pNJnE2CRyTRO
 QaczAHdHag+JcOE/1LyD2aJ8zbzUacrEaehcCxkvRTH7FWIZpBmFSO0mZgCvEOg/xaiMDi5p5
 OSgT07UVPkdOto7AtJEiLrZpx06GuBOdAEcF+nz/iOnLZHxQMdxRjq5nuUQRenu7npmlJ7etM
 JLHKOWo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Fri, 1 Jun 2018, brian m. carlson wrote:

> When writing the todo script for --rebase-merges, we try to find a label
> for certain commits.  If the label ends up being a valid object ID, such
> as when we merge a detached commit, we want to rewrite it so it is no
> longer a valid object ID.
> 
> However, the code path that does this checks for its length to be
> equivalent to GIT_SHA1_RAWSZ, which isn't correct, since what we are
> reading is a hex object ID.  Instead, check for the length being
> equivalent to that of a hex object ID.  Use the_hash_algo so this code
> works regardless of the hash size.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

ACK!
Dscho
