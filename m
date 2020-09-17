Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902D2C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592CF2075B
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgIQIL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:11:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgIQILO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 04:11:14 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:11:14 EDT
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5Q2f-1kJeNi3H3V-001T3z; Thu, 17 Sep 2020 10:04:19 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 1D2891E01E7;
        Thu, 17 Sep 2020 08:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EWRXXDj1ihhS; Thu, 17 Sep 2020 10:04:18 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id DDC111E01E6;
        Thu, 17 Sep 2020 10:04:18 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id A2A7E8051A; Thu, 17 Sep 2020 10:04:18 +0200 (CEST)
Date:   Thu, 17 Sep 2020 10:04:18 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200917080418.GA8079@pflmari>
References: <20200915135428.GA28038@pflmari>
 <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
X-Provags-ID: V03:K1:K9f5boUNylg1XAHsAEM0S3YMTuQGOLMcYF5nBiAe3k8Ydmrh+nb
 20iytQzWhtXxA+ksIFwGYzzZ263szUfjobFz7T8guhUkY6P4PQeQNqLT8AURrbWVc4VKKi/
 VJbGI+8KRv/5h8a20D+IGdkuY7ccRq7l1wLcqGHAFU59vkZJ4TjcUdBbJvohi/oubEtcBYb
 9fu4UxOun5TI5BCv/R4Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j1DE0sFiRXk=:xhnOfRhKDXSPAnhiPJRu6h
 9Ggy9dyt9ZL3ojwi10MQ3fR6qyo6TKYugZ/fQHXC+swSTj4mDEuI6L7q/Tyu+x6zc6jYrjFy1
 9sHC7oNILEoZ6pqcndq7YevTh2u+0bvgZaXVT3eqdhXRBilid8PEeqredyy6yXGfd3jzp+RWX
 wEDu25w8Zk/WYeTDcncJ2O1zyGRBHCt6BVtcvytvRtWOZ+Yh1q41fISBOatx3e/oRUfY69/Pp
 mS28qD+ZyZyr4+1UoEVqK22Ko+b6pXY2BqvLRTqRUJmLpneRyjtdjyRs9gn/FmjXbtDlbGYon
 vCm89pAo6M4Gid0HfHqUmqULpjYHn+s/0UCOTERs271a6S8vjKFz+31qoN5CkDda+63CXxqya
 QJF6gBS/k19jIENHHQ2vMe7Ch2tCONb049Dq2rRTKnkMl46Fp6MW5/oqAe0vX247VOsZsPMdO
 uOX3cpSaP/nHue7Im7nv1DhXdUxT5zuuiMhZLhTVQb5Cxr8IAsVGUylDmssiyB0VeJ/65hPSE
 U5NTAjJFJ/ugReZ+1BFp7uF4ONNrX6OoYgCYP3fnBgGMKmXQvjEViJpgQUs0t/f0vhNwB+qAx
 y8vSmEoMqQEjpUzxDJ+jPmx6phwuQ78nLVjG5DqI0/nHFzvjWoCF2nYIvebcePHAkSyq09pRE
 vU1QseUdFS/61mqllcHiBbwg9RsaE05pda4Q6bJUsjxXKU/uiUoUIBYYAlhVh/TF8oqbXCfLm
 R0P4RqaaTOt02PwaNsQc4U40uaXmLXCAhL9i/WW1oLnJtPl5IBO62/J8vwJjmhZWQ9mfKJLdv
 z4RQSbjCyH4F9R/lqHaNe7UjTiLMLHqVhGRDb10oNI3TEsW5osp3NaIxJj6G4JJPpaKDz0Ue5
 z9MPwdY3l5DpBe+jF+4w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Wed, Sep 16, 2020 22:14:08 +0200:
> How about introducing a new command line option
> 
> 	--transfer-protocol-family=("any"|<protocol>)
> 
> where <protocol> is either "ipv4" or "ipv6" [*1*], and make existing
> "--ipv4" a synonym for "--transfer-protocol-family=ipv4" and "--ipv6"
> for "--transfer-protocol-family=ipv6"
> 
> With such an extended command line override, we can override
> configured 
> 
> 	[transfer]
> 		ipversion = 6
> 

So the config option starts looking like "transfer.protocols" and multi-value?
With the command-line option named "--transfer-protocol=", allowing multiple
specification, and with "any" value taking precedence if specified anywhere?


