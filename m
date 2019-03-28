Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA9120248
	for <e@80x24.org>; Thu, 28 Mar 2019 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfC1VaO (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 17:30:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54424 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfC1VaO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 17:30:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so341305wmj.4
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JcnqofL83wwBFqFiAg3KCAmUyvkiNxqKHGIqG48TFr8=;
        b=NZQicCkv9kD5SngZ8HEC0RrckIiGWv8j6SsJ6865jK7w4XqJPdcCsyKkmKzR0/zs1L
         Ar0SXITpdWo9Zvtcw40p5Rd0yHwDVjAhBEaVGru8f5z3z1YIu+whsyFqu6xKvX47TSbE
         KB5pPFNOsslHv9yVEVlhVDQJqWttYBJx6jtF9Nb2LrgapkatJU3/xGn0tXNA2fvFS/J4
         hya2/gX+qccF4jEhysTMuEYsSd53QPeXq11HtCgGinih7QzSl6LUYpngnxuGd4I5xCGD
         uKMOSmFs3TPyFYNmHbGQJPXJVvTco7Sxi6ADyaFtcXjjuheT90W8Ryt8btKqORrCim5h
         bVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JcnqofL83wwBFqFiAg3KCAmUyvkiNxqKHGIqG48TFr8=;
        b=K0+ZeE6LtwDXVCajyD5E8+1tQXW90/RkQGrP1aJL/lxzPnYKZ/E8gyBC9loQcLK5zu
         +fRBav5LHS0GISMy3Tfsq+wQMtovxZdFwf2kQ6AKErwLJoYLfBUs/0B3HWKHI1Wm9H/x
         nBhkZs8jhYUJ6s/Wej4xLw1q35yIOMxFCiBmQRq7WPNpc3XdCEeKhBNlzKrWRj/LWUsN
         hV09L0e9T8iTuKMqDfr3ACodFi0DTI96zFRlxMZKNLZ7ke3kUU9cMBHWR/OGzmLkoeQf
         1MSKzx3NeXk0yAR3fj2w429b/SGBZaqMU0vS8/7TzN/+34CHpmlX8Ena+QWBlqeBliD/
         Dr1g==
X-Gm-Message-State: APjAAAVMS2es4XIke+TB3NuVrMe0S0RmA0KEAr5gw01IHI5GxOlpt/HW
        VaO7kQmzhtXefrbjOwWfhdU=
X-Google-Smtp-Source: APXvYqzp5pPh802Z9Notg2RreiyOUfe9seRZSD+E2npujWKklPbl4YLdnIZP1LiSV/pguJ1pGDoQGw==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr1378991wma.35.1553808612141;
        Thu, 28 Mar 2019 14:30:12 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id w18sm322921wru.24.2019.03.28.14.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 14:30:11 -0700 (PDT)
Date:   Thu, 28 Mar 2019 21:30:10 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [GSoC][RFC/PATCH] userdiff: added support for diffing shell
 scripts
Message-ID: <20190328213010.GI32487@hank.intra.tgummerer.com>
References: <20190322160615.27124-1-jkapil.cs@gmail.com>
 <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
 <CAMknYEMBYxp1QJ3Ds9dmuS4ccHKtExx33d_Kv63UOwaUMm5oUQ@mail.gmail.com>
 <CAP8UFD0cWSTZPqqVwTFyYL06S+6aT_EiLPW6jUE0AH9puxevmg@mail.gmail.com>
 <CAMknYENJ+U4urtSEtwDSLpdwGe=x=uq_HdSs-cT9Z+PT5ZQiLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknYENJ+U4urtSEtwDSLpdwGe=x=uq_HdSs-cT9Z+PT5ZQiLg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24, Kapil Jain wrote:
> On Sun, Mar 24, 2019 at 2:49 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > The test_language_driver() function used to test the regexps is
> > ...
> > GIT_TEST_CMP which is usually either "diff -u" or "diff -c".
> 
> Thanks.
> 
> please provide some insights on the regex mentioned below:

I had previously mentioned that this project was attempted already in
my email at [*1*].  Did you take a look at the thread I linked to
there, and the regex used?  I still feel like that previous experience
is something you could learn from.

But that said, I think your assumption in the other email that the
output should be

[-$TEST_DIRECTORY-]
{+$TEST_DIR+}

might not be correct.  The tests are using 'git diff
--word-diff=color', rather than 'git diff --word-diff=plain'.  Only
the latter would add the [- -] and {+ +} around the changed words,
while the former adds the color, which the tests are testing for.

*1*: https://public-inbox.org/git/20190315230515.GJ16414@hank.intra.tgummerer.com/

> +
> +PATTERNS("shell",
> +  /* Function Names */
> +  "([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*\\([[:space:]]*\\)[[:space:]]*\\{",
> +  /* Words */
> +  "([$#@A-Za-z_\"\'][$#@A-Za-z0-9_\"\']*)"),
> +
> 
> reference mail:
> https://public-inbox.org/git/20190324084523.8744-1-jkapil.cs@gmail.com/.
> please let me know if the regex is not self explanatory.
