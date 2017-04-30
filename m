Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251FA1FC3E
	for <e@80x24.org>; Sun, 30 Apr 2017 23:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993557AbdD3XOm (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 19:14:42 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35328 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2993550AbdD3XOi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 19:14:38 -0400
Received: by mail-pf0-f170.google.com with SMTP id v14so68824717pfd.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1UTbiJakRZV6txJAhyzijdYN7Advc+t+AV1l0d453sw=;
        b=MUcUnoHF++PpB3PU4c3cmSlTloJ4V0BH+f6LcZVF0mzXqlfnXUJsoeh3xFHkIqSoNG
         rZKjnR29/BdhsV0HG4puFG5yvhRRQ7aXWwCNOtUFFEuQ/HSa800/vJ5eqSE1gti9iPAX
         /QGNvh3WJM2Uy1rT5KbbfYeSwBiI29elvE1sXXIft66Afi6hr/uLFvlChhobGPF6RrWU
         66JlAJFqHlDGhyYiTRJHuNumjB6w+btVhzwOR1ZnFaO41lf0TKTlyvKQWrxYOZIV6XZd
         48zl4isiLd21SkFxAGLkQeskO2dqjZoraBPbpWIcQtZ2YFK6IczB4JVRBfs7AYaRWtF9
         egFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1UTbiJakRZV6txJAhyzijdYN7Advc+t+AV1l0d453sw=;
        b=o0BOqSIyXpEi8Ov3gTFlfoKigwWB/jmsKXr+IKGY5vbKuzDeJmYdy0muWoV6OKegBN
         9FEb7X6u0uOmKUoKM7ubwHdPP+DYvF91fnKZekiBkNN5aNMnmqJWhCV9zDaG/XUB2xKI
         voHIS0uCw/ZizbTStlaUw5XoUJP6nP5uD2dE+gPAujmk65DDZ1wYomB5HfsoWv55HSSt
         uGOHMLnReUNwb+MNBs+48oowk6faN46DvXD520Liv/WVl/oxK0hiKTmhCpAXX5Yfi9cy
         C0xKVkWb+asry7SqbnIimm8XNonG8MnR8XBXmi4skA1fW7eD08NVyFJ1Hu8PTbNAvs40
         7JEw==
X-Gm-Message-State: AN3rC/7B49PIX2wW/eB5OskASupNZ8v9e74bxuwBXhZVd3TJ9gOcwZb9
        qrxUCsGcEDSqxIzs
X-Received: by 10.99.44.140 with SMTP id s134mr23912607pgs.178.1493594077491;
        Sun, 30 Apr 2017 16:14:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e10:a85d:c301:1013:7c76])
        by smtp.gmail.com with ESMTPSA id p62sm3854114pfp.48.2017.04.30.16.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Apr 2017 16:14:35 -0700 (PDT)
Date:   Sun, 30 Apr 2017 16:14:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] submodule: improve submodule_has_commits
Message-ID: <20170430231434.GA70010@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170428235402.162251-6-bmwill@google.com>
 <CAGZ79kZzpyw0ijiM12TwMHAx1Ung-xKPEm2rVY9803hvk=+UMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZzpyw0ijiM12TwMHAx1Ung-xKPEm2rVY9803hvk=+UMQ@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/28, Stefan Beller wrote:
> On Fri, Apr 28, 2017 at 4:54 PM, Brandon Williams <bmwill@google.com> wrote:
> > Teach 'submodule_has_commits()' to ensure that if a commit exists in a
> > submodule, that it is also reachable from a ref.
> >
> > This is a prepritory step prior to merging the logic which checkes for
> 
> s/prepritory/preparatory/
> s/checkes/checks/
> 
> This is the first commit in the series that changes user observable behavior,
> I guess there will be tests in a later patch? Can you elaborate in this commit
> message more about why it is useful (or at least harmless for performing
> this check in the case of fetch/push)?

This hunk of logic is essentially a copy and paste from elsewhere in the
file.  Essentially both code paths were essentially doing the same thing
(checking if a submodule has a commit) but one of the code paths included
this logic to ensure that it was reachable from a ref in the submodule.
In order to merge the two code paths, I included that logic here.

Maybe it would make sense to squash this into the next patch as the
place where this was copied from is removed?

-- 
Brandon Williams
