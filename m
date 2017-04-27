Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FE7207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 21:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423167AbdD0VqK (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 17:46:10 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33238 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423159AbdD0VqH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 17:46:07 -0400
Received: by mail-pf0-f170.google.com with SMTP id i4so1963787pfc.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nZ+LaAl7WBa+b8441Ztznue53LY22Rz6I8vVPKFLziI=;
        b=Fa3CJWHzn2dzyGpawohvDamjXvZs5OW0lal3GRNn1q/shZLbxw3adfa19j7rVFi4QJ
         6x+t8G97q/9a/OS6Q1fimP1JDE5iKbceCAyq65BRLAPYZXFEdvvcsWCac8J7n9eUt3pM
         /eSrmEZCzJNgivrC/jGf9LG95Y4m6bz2kbQs6ltDEYyP5DKmjQxrI+yRLp15Jm/0MY7y
         6lCPKxB76J6hFQZRyQBJcFjYoox8lFAV4p4HQJRMcLqwyJymE2AgewdX/FVj8bRFebF7
         9hu/yTFnl1FXkS1Bs0et/VGWxrHxBjmC0cXetLhWFf8RrilJyNiA7o/QLNMAY2D1ipOv
         v24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nZ+LaAl7WBa+b8441Ztznue53LY22Rz6I8vVPKFLziI=;
        b=nhk+vJ8zdLe1zER4Xfes+o0lItOeYagJTRQMRladgG6ffj41bfnng38ZDJcgO85pV2
         t8HhO/AaMwt79RN7RNwS6FcZkxydH1ruxptIfQWwc35vxvhc7q9/KcIGKOmDPk1CWRM/
         GtJJ55IoNA3hgycHgLb6FpAeg73M7hsc/9JYCJ369wvww4iggBRrAccUFqBd+5wBrLQY
         /11fFH9IAMoxHz41DNPxWN/55sJGXgekY4ynYnJAI7ZuxQb7Q5l62V77G3DsT8nuTETt
         Bf2Tdy0QpbxL0Q0PpUIs5D0QlzzqU2vXLTR60W6hvrnLl+H1jZ4WppYUUTzfVdl42Mib
         mDBQ==
X-Gm-Message-State: AN3rC/6/fRbd61qCcANK0uWExWo4J4Q7ifwBuC/J4/WZjbSUMXiDQRZ/
        Vpte9W2+8N0gUu43xQQxZlo5tRTRe2JY
X-Received: by 10.99.56.66 with SMTP id h2mr8411248pgn.40.1493329566988; Thu,
 27 Apr 2017 14:46:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 27 Apr 2017 14:46:06 -0700 (PDT)
In-Reply-To: <20170423213453.253425-54-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net> <20170423213453.253425-54-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Apr 2017 14:46:06 -0700
Message-ID: <CAGZ79kant7b0-+DB3Q6a4Brta8LmdrZdgdkwQLvWc5YNxv5eCg@mail.gmail.com>
Subject: Re: [PATCH 53/53] object: convert parse_object* to take struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 2:34 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Make parse_object, parse_object_or_die, and parse_object_buffer take a
> pointer to struct object_id.  Remove the temporary variables inserted
> earlier, since they are no longer necessary.  Transform all of the
> callers using the following semantic patch:

I have finally reviewed the rest of the series and did not spot any other
things to raise.

Thanks,
Stefan
