Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D7F203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755741AbdGXRmI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 13:42:08 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35549 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753647AbdGXRlc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 13:41:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id h29so14424801pfd.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TwtqQbyEj3LEGJdIbOkg4m2j34Imjp6z9em1Yr388gI=;
        b=LSO0LzlKnPK03qgsrRmODJu91WORPHZQY7hCOPWFqfosBjZ6t88SK/oL1pLaK5gqHS
         cVttO9NL+JgLMkabdKcnTF6bkqZTbCGftNSE/DObbi3NTKjYhPxjf/ULVMwhVQ9EmUGW
         vIojOg9oLz8hEj/aRoxlz1fDoseWJU7xoQBhDQKfqchdIc86C/AAaXDmQXcU9A52iv3V
         t51ysUOmdrYZ4d6vkAavj7kEAjZeSfrInrrbKHd6uKYAeydm/ShP3YJxTb/7+kydCfvv
         1MSS1yau6P/LqZnAwulJCLh4bnQTqzgHpSBR0s7tQezyCX3PZEnr9XaiPDDv4iqAjdQC
         uUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwtqQbyEj3LEGJdIbOkg4m2j34Imjp6z9em1Yr388gI=;
        b=mtDj4m5Ps33mfZgDtTuq8HNC8v4P5jE98QqeWw1BQdYlPRPtuSmEbPYuhBIuXept31
         OlEDms2qiL0rzwZLy9oWT8mAcxdovulnITVYzqKFqjvfHB34+ajbjFXcaMS6JHk7CqmJ
         xvnhWkJpRI35kdgRMHnbaHgcv9EUD7E+I3iBlCBFXB5ebZ4R8NPbYW7x0cjbbC8FC0X+
         cpPTQwUXSaWH3hgVn2h2Fp9JjQBsCTye/CqDcm9TAuh/sWnGNMYmt+6WI2/y/8LfS5Aa
         jS16OoxXkyskL+/FpyfW9c7Fj4Uo3VJfCnoIRKQvmqZFvg8Z6WrC0JgUCXw6WhQWELjV
         sRoQ==
X-Gm-Message-State: AIVw112JMpK12YszMXGixRQyV5n9q0Y0To2oIZhhq8k0q8iZhpo7adE4
        Msk3cCXKHDjm72cM
X-Received: by 10.99.2.142 with SMTP id 136mr11868141pgc.401.1500918091122;
        Mon, 24 Jul 2017 10:41:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4bc:947:66f8:1cfe])
        by smtp.gmail.com with ESMTPSA id d19sm23965138pfe.24.2017.07.24.10.41.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 10:41:30 -0700 (PDT)
Date:   Mon, 24 Jul 2017 10:41:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Orgad Shaneh <orgads@gmail.com>, git <git@vger.kernel.org>
Subject: Re: recursive grep doesn't respect --color=always inside submodules
Message-ID: <20170724174128.GA68104@google.com>
References: <CAGHpTB+dSGza5Lwg76WXg+pPZ=dz3QdCTnDozWG_y+5_bPor6A@mail.gmail.com>
 <CA+P7+xrzLdGN1nkkcTH7iGBo1gg4GgPGYSgvF7-jw6LKj+WiBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xrzLdGN1nkkcTH7iGBo1gg4GgPGYSgvF7-jw6LKj+WiBQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/23, Jacob Keller wrote:
> On Sat, Jul 22, 2017 at 11:02 PM, Orgad Shaneh <orgads@gmail.com> wrote:
> > Hi,
> >
> > When git grep --color=always is used, and the output is redirected to
> > a file or a pipe, results inside submodules are not colored. Results
> > in the supermodule are colored correctly.
> >
> > - Orgad
> 
> This occurs because color isn't passed to the recursive grep submodule
> process we launch. It might be fixed if/when we switch to using the
> repository object to run grep in-process. We could also patch grep to
> pass the color option into the submodule.

This is one of the many downsides to the multi-process approach as it is
very easy to miss passing configuration like '--color' down to the
submodules.  As Jacob pointed out this problem is solved when the
recursion is handled in-process.  The series to implement this is
currently under-review.  The latest version of the patch series you can
find here
(https://public-inbox.org/git/20170718190527.78049-1-bmwill@google.com/)
and it looks like Junio has it as a branch on github at
(https://github.com/gitster/git/tree/bw/grep-recurse-submodules).

-- 
Brandon Williams
