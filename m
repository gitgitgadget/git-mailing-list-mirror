Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC9E1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 11:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJKSu5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:50:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeJKSu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:50:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id r1-v6so7904544edd.7
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z+tGws3GfjXwIcFh4JlHe94GFYgDqK0b0hncFdcoOmE=;
        b=VBWcxspRQ6brYPNKgYnGBAuoTi1DFdntMqVeNd1BWhke7oVPZhNzd3A4sLVCCXzORK
         y47JexLQD2HcDunrwjR0RfL8GjGoDKdWxttA73rX/D4W5CPjnYX+aTpB4SHuVJC9p5vi
         QHknWN6nmkwghSJix/pnN4oPmJhfOc+bnMzVaTUJN3nLBRqdNigIqT525nHAiAnUjbFX
         s4v2OnGll1cDYptVHbihwgA85x22NxzFZ+s1D1DajAfOk65hnxP2NwwAdedCRjjWa55a
         SHRRQ/9pQKpjWzWljehqP9V0fpYWMxUBINE9MdxS044dyi/DmfgZmo0gMVqvW971fJxD
         ZRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z+tGws3GfjXwIcFh4JlHe94GFYgDqK0b0hncFdcoOmE=;
        b=MKF7KmpvPHlVvMs5woE2oRJoKVG/ImU8V9zbmh+UUlLOQOMmRO/deWFsLMs7eDc/A9
         lTsyHAo57DZxcoZum2nRICEKleVGkFcJoNy1kSXetwJZ+ZTixMTznaQGp+9enqFrT1HV
         MKo3VFB9Mxz4xT0+/13X4qIwUh+gNMSnBMnv/MuLDoK1JqG7LAlzgBxFov0Z6OhWvus7
         y4zt6Fh5PX9DvHkfB4ed6ZpXDbMyzaZEjVRj+fu9ENFU/TbO/W13z7a79wqwzwtqzRSi
         blHTzTE2/4CbARWJq/GJotVgKxoCGB18huURhPprG9P/BDktRICi48KN6KFP8gyRyeZI
         mzGw==
X-Gm-Message-State: ABuFfoh7ujElnZrZgDMRrYGIS9dgP2mhv5aYrT27bYq0npMGahLSh8xu
        c2h2oTQjL6F/lnzuDgYFdvE=
X-Google-Smtp-Source: ACcGV61aS6vR2fGu6oJIIl09OtwMvnzByAMF0xyB9RdECqxN5WXe8BguS9mza115h1nDEQncztK2SA==
X-Received: by 2002:a50:9471:: with SMTP id q46-v6mr2191553eda.70.1539257048042;
        Thu, 11 Oct 2018 04:24:08 -0700 (PDT)
Received: from szeder.dev (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id y8-v6sm9907338edd.43.2018.10.11.04.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 04:24:07 -0700 (PDT)
Date:   Thu, 11 Oct 2018 13:24:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revert & cherry-pick: run git gc --auto
Message-ID: <20181011112400.GA19800@szeder.dev>
References: <20181010193557.19052-1-avarab@gmail.com>
 <20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net>
 <87ftxceqxc.fsf@evledraar.gmail.com>
 <20181011102525.GH23446@szeder.dev>
 <87efcwepqc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efcwepqc.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 12:34:35PM +0200, Ævar Arnfjörð Bjarmason wrote:
> I see we define NO_POSIX_GOODIES on Windows/MinGW, so those don't
> demonize "gc", but then I'm confused by this which seems to imply the
> opposite: https://github.com/Microsoft/vscode/issues/29901

I don't think it implies that.

The last comment starts with "Code calls git fetch periodically".  I
presume that it does so in the background (to prevent blocking the UI
until 'git fetch' runs), therefore 'git gc --auto' starts already in
the background.  Furthermore, notice that 'git prune' on that
screenshot has two 'git.exe' parents: I think its parent is 'git gc
--auto' and its grandparent is 'git fetch'.  Now, if that 'git gc
--auto' were to go to the background as a result of our daemonize(),
then the grandparent 'git fetch' would have very likely exited
already.

