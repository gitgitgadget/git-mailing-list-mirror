Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1871F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 17:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439981AbfJXRQV (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 13:16:21 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:43519 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439972AbfJXRQV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 13:16:21 -0400
Received: by mail-pg1-f176.google.com with SMTP id l24so9687654pgh.10
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTQUMgKsxTWSsyHtC/m5qBCMipIhuGanas58vVYu4dk=;
        b=HGtB1NX8vFL14tgdMS8P3uLbin5zcn5Axhcj2XL2SsbkF/BBv9U5oEoNN/kIG0NJLL
         c35ajBhwrpHWqwxOGP5j8eHxvD74tW9OTcjt7zFY8A2hEAPowqLAyyDb0FXzqKrYZyxY
         9C/owpUFhjTIf0bsYb2ZHTRWA7d7hNjZybIamQmQcGMx9Mh4O9R0MXTKo9Xo4Ec7FFFs
         h2PJSiDkGx8UAMdIL3hzYxh54SSFTFzJ1zrI1ykJQlOkb/RApqSInPXcMoGIlzpxgUU/
         ahwQeSKc+BNORhCwwWZgOKCUP8VxENANADvh9aIBSHKZDoCVqU+vTL9M0GNW6Lz3b65D
         yvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTQUMgKsxTWSsyHtC/m5qBCMipIhuGanas58vVYu4dk=;
        b=jtH1P7jsC5K99TOTcFz9HR/AIfocmu3sWjvQ1D8zhhqUQF7js8jSImuYZnL7cxz6+F
         M4vLun5PhRE59eWvmvS00AvMniNNzbdOy/4ydyTnRO6oumu/FJTFqotM89sF2xfbPpOd
         qnz9qjOOje2dOhN3v+ZwYOegx9opjriXpgCaeYfv+xGCFIYp+N8tlETyin8ssCCdntCa
         4hza07ejWk7Jrsrx9gXd+Wux2fWG5IfjsCemc2ZuR3knCkzA5ToTsW7cWGweq2PlknZv
         NoZHYxF0xDDYe+KrUc8NUnEXdbYK2HB6amupwoitScG++0jVw0EbRQ2CybjQnnoeGaHk
         nBKw==
X-Gm-Message-State: APjAAAUX30bBrLF4unZAweJ8g6Spvi3Zz05PTmie6Z4q5GJoYHZkHsX0
        z0WsCgDn0rs4V4eXbaodyD8=
X-Google-Smtp-Source: APXvYqwc2sVYLWS5CkJdjsMOjpcZxxAxP6AV1yCud15Pov/5pt4HTL4O/YaDR5IilO0KdLgtIVy59A==
X-Received: by 2002:a63:1c24:: with SMTP id c36mr17535238pgc.292.1571937380284;
        Thu, 24 Oct 2019 10:16:20 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id t12sm2633451pjq.18.2019.10.24.10.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:16:18 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:16:16 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: RFC: Moving git-gui development to GitHub
Message-ID: <20191024171616.GA40755@generichostname>
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <xmqqimoehp7u.fsf@gitster-ct.c.googlers.com>
 <CAGr--=JQXfbJaxvYo1ue__eRHyEgKDd3mjTgxXxT=7seTU_oYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=JQXfbJaxvYo1ue__eRHyEgKDd3mjTgxXxT=7seTU_oYA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 09:37:08AM +0200, Birger Skogeng Pedersen wrote:
> - It's a lot easier to get a total overview of all issues. Especially
> useful when you'd want to see open issues. Pratyush mentions he has a
> text-file on his computer where he lists all the currently open
> issues. We can't see this text-file. And even if we could, we'd still
> have to navigate the mail archives to find the discussions and read
> the emails one page at a time.

I also had one of these text files laying around with my TODOs. Dscho
mentioned to me a while back that it might be a good idea to move
everything to GitGitGadget's issues. It's worked out pretty well for me
so far and I think a couple people have even picked up some work off of
there. It might be worth considering moving issues to either git-gui's
or GitGitGadget's repo.

If anything, it's no worse than the current situation since if GitHub
goes down for whatever reason, then Pratyush's list of issues is private
again. But as long as GitHub is up, then it'd be nice to have a public
list of issues for people to work on.
