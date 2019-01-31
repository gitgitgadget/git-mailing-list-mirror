Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90921F453
	for <e@80x24.org>; Thu, 31 Jan 2019 13:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfAaNhg (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 08:37:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39668 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfAaNhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 08:37:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so3316997wra.6
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 05:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AsmFGq34iKYKYzEQV+qWq06uPMhZYOZS2ZnUqIQyKt4=;
        b=Y0dHWWMZ/mURBgKLBLXE1rhG8kPJlxmzjGwO+eNNF6bqh29lb4LUfHREXrQMYP0Mm/
         uuBUX2HqHuIMDZJJwGtwfpRMpbJfOpHJcVBcx/OFXuZxl0eAFFKyTzpdRD0J3PCIcb0W
         moKC79jG5da9owZy0PdosCZSAA3QbxCtTqD5WlvT7nRdhkxm+4yXx+zWxXz2Tm+GoBv/
         o/+DnFO4HK7W5QUSwVldMLuLOtKrbuqmnhkVeZ9yrypmQbCRTUBxOpF3sA/3UBEveVPx
         GTyBEc2b3TbW2FOfaFWSRJiw122a9EaFvYlWAF/A/yxCiUQ2tdcd0+cTEy/u69BhB+Eg
         oOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AsmFGq34iKYKYzEQV+qWq06uPMhZYOZS2ZnUqIQyKt4=;
        b=J1xzmX5TDSs8obgJrItl42GcKeAlIYy4u+u9lF9OVDe33j8ckeNgNRwsV/Hf35qyXO
         qH6HphstD4XdZf5whNyu5zWZ3Szhw6V4trg5uaEuj1qO+/ySkeYInY6JSCyzeGXEr/Lt
         GVZvjjsEhocyv3xfipggeEbI8i0W+mjskWmPdDJXhG7taVgr9LHOjEhT/iowzfUIWfTY
         oYVAUVkbMSaiUlUF9t5hivS+3NxspxOXp55Dd7Rj9rg1Lh0ns2pQWYesivvFg7di3bil
         IqPGDnluQNoYVNyhvny5Xo+Dnf+kZANISwayL6OSt5YferqIyM8xCw4EaEkqa14075AU
         GyCQ==
X-Gm-Message-State: AJcUukeYreChO0zLuvdR1jQ1AJt5zjh65znwaCEgb1AUaK5Y9ES/eU+7
        zbcFBa9tH9DN9+PQYZUL8kE=
X-Google-Smtp-Source: ALg8bN6L0JGw4h16YavcHz1QzSbEWlZRUHiAeVNzjds+nAmaePMD/mcCZvPOfipffzFGGhdJVrQGvQ==
X-Received: by 2002:a5d:530a:: with SMTP id e10mr35586862wrv.151.1548941854945;
        Thu, 31 Jan 2019 05:37:34 -0800 (PST)
Received: from szeder.dev (x4db675b2.dyn.telefonica.de. [77.182.117.178])
        by smtp.gmail.com with ESMTPSA id 126sm5196488wmd.1.2019.01.31.05.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:37:34 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:37:31 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/19] Add new command "switch"
Message-ID: <20190131133731.GK13764@szeder.dev>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 04:48:12PM +0700, Nguyễn Thái Ngọc Duy wrote:
> The
> only one left is adding options similar to "git reset" (but with
> better names this time than --soft and --hard, hopefully).

Oh no, what for?!  As the commit message or patch 19/19 'doc: promote
"git switch"' states:

  The new command "git switch" is added to avoid the confusion of
  one-command-do-all "git checkout" for new users.

Adding '--soft|--hard' from 'git reset' would go in the opposite
direction.

