Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DFA1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 13:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbcIUN24 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 09:28:56 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35306 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbcIUN2z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 09:28:55 -0400
Received: by mail-wm0-f48.google.com with SMTP id l132so268709063wmf.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JIlq1quCvtOi7GHyfq1xKjRCW+zlqtNLAo/rp7GvIBs=;
        b=d5Vy9fMsi1JzmvV3YDnQtXtSr7Y9P3SwURMGrXuE41GXcuRYQ7K0d4j8Zpf3gwpUa9
         YmfKXe3vMp94MJFFjsatPYhym9FD1pTsjGpD3uAuvdXQhJbcbZ7NY0Vx383t0iVkI5xi
         Ta2W5HwGojv72W354PVOXCgVSV/NJWEiS9t1Dhho7uRj+SI4xNu7lAd0UQKxLYU0sGwD
         0QgLQdpv3KO6/cW+YYowmZBEVKj9uTDctrP5CIDnFBkq1CCHVa1UOcnnrKy3kaPn6evE
         l9tWoobzWX3kPGf2gYwZfbkoKp53YpSHVpUKWrra7i6eyO+hT8tiX503r8MvWaLDaT3G
         tp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JIlq1quCvtOi7GHyfq1xKjRCW+zlqtNLAo/rp7GvIBs=;
        b=TmUjfmmtuJfREMkK1v+eOMEyL3DLQfRFpIRAmxxXXQi8hhjYc/RJCZc+SlFOWDeW35
         qUBa0jf71onLfFSc1N6l9gCU0wU4giireDjQuMxpkJOS1eQ8uIGtdcelQwLXOwsTesRO
         a5O8O6qhnP0bW+WspZkiCmr7NP2OpoFAcd8SrNXaZMI0cJxGftlHC1TM1l5FPPVM+/jf
         JrLwNVPJrsB87omihpHttrHunzCQxb5dQfH9vI+3sONTJrvioRlLL5l8baW1BBljhpw4
         BTemy4BQcfXAS4vwHGihumpr+F2dKX8MbHm7SPnZMPsPtcz462oD/sKbpb+C8/ryuAzp
         HXmA==
X-Gm-Message-State: AE9vXwOxaYmNcTD2jfs4jFcXD/GteFAGTDMqK+K04tMPbNgzfm6kk+e10JrXosfYnEhJAw==
X-Received: by 10.194.110.229 with SMTP id id5mr32348939wjb.23.1474464533893;
        Wed, 21 Sep 2016 06:28:53 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id a84sm32692524wme.6.2016.09.21.06.28.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Sep 2016 06:28:53 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: ask homebrew for the its path instead of hardcoding it
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <83e3049c-34ea-4440-7b4d-061cb98ba2dd@atlas-elektronik.com>
Date:   Wed, 21 Sep 2016 15:28:51 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Transfer-Encoding: 7bit
Message-Id: <14C21417-491B-4C8E-90FE-47154EEDD9FE@gmail.com>
References: <20160921084518.13091-1-larsxschneider@gmail.com> <83e3049c-34ea-4440-7b4d-061cb98ba2dd@atlas-elektronik.com>
To:     stefan.naewe@atlas-elektronik.com
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Sep 2016, at 11:31, stefan.naewe@atlas-elektronik.com wrote:
> 
> In the Subject: s/the //
> 
> Am 21.09.2016 um 10:45 schrieb larsxschneider@gmail.com:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> The TravisCI macOS build is broken because homebrew (a macOS depedency
> 
> s/depedency/dependency/

Thanks for spotting both errors!

@Junio: Should I make a v2?

Thanks,
Lars
