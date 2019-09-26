Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92B51F464
	for <e@80x24.org>; Thu, 26 Sep 2019 00:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389761AbfIZAfe (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 20:35:34 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47244 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389677AbfIZAf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:28 -0400
Received: by mail-pf1-f202.google.com with SMTP id t65so463341pfd.14
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 17:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=urWvYIy9whFNoNqKI3qmu1lDbEEGteGhcRP0s8UHsS8=;
        b=sNGcli1LpQwnlu/V3dB6PmFdkoRxofAolivb/Qrqyxk05Yfup62c17HbwRjnBt+Rrd
         pH99mbdWNf+Xqbbnlp+fgRWbJxlp/yb4trGPFqUIXgMD33IO93tEdyWaPXyF5SAS9Fbl
         vW879YhsaYUawoHA4hTK7qlpjVYEu71enzw33gS65qeN234jpN3CWaw+WueHBCMCUVKN
         obyYbMUoAVb82D7MFNlAdjZUn3V59n8pglUriktk4gDmMjRyqFEb2/W2JgXJiiqRSgK2
         KSdbJmo4mf2BWrBv4tnNujT9l8M3YoY/Sz48ku/FUwVe8lIYRDuBHUWtdH3eyGb6+9vF
         Y6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=urWvYIy9whFNoNqKI3qmu1lDbEEGteGhcRP0s8UHsS8=;
        b=V3FRYeJFN1lI1iIKddIkjovRV8nf+PFYzb5UF1n2sy8197pxv1YbNzQRnvUwW0/ksN
         Kj8S9aAOzg0rYcLwDRDxFICtAvFhMP/YMDQYVlTblYJe2LQpSJ7NXR/WPV1A9MDvX6cy
         j4iC7jPN+0JJySIV1WmgH493IoR6rriF5S810Aj2Rn8EnW7hQ30Qb6F9QeA9x74afG5x
         hYWlLYC6WTTyU4G6QJVSqODviqOlgZpriXfGktq27kEc0fjWwP3Ci1jUj3W4FKrx1YB5
         lxwiJcwKOeT9XQ4gK3vfX5UXpJIx1HyuWcZYaeJ98GtOs8hXbrbLI/Om/iZNwqueUnmQ
         ZwZQ==
X-Gm-Message-State: APjAAAVFV8Q57vPc4ov8xrC7fyUQBvRBc13f2eQM9SjTDPF1pJkH2eJ7
        r/1GZu27TbxVlLtkXRWGfVSQMzxEsq78pIsdqKJA
X-Google-Smtp-Source: APXvYqxIQnGlzH+U+nzrUnYVD/wsQjytabwS+P32deZqiDLsezv6z3H6AG6HvsHQ80489y78eg3rC9ijRhi4a+FX+4+G
X-Received: by 2002:a63:4755:: with SMTP id w21mr662317pgk.122.1569458126457;
 Wed, 25 Sep 2019 17:35:26 -0700 (PDT)
Date:   Wed, 25 Sep 2019 17:35:23 -0700
In-Reply-To: <20190926003300.195781-1-jonathantanmy@google.com>
Message-Id: <20190926003523.197188-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190926003300.195781-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: Common thread pool API in Git?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> For those who want to know, this question was motivated by a big delta
> tree occurring in [1].

Forgot to mention: this is not an issue of the server not repacking with
a chain length limit. The tree in question is indeed not tall, but it is
very wide.
