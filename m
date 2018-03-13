Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3A11F404
	for <e@80x24.org>; Tue, 13 Mar 2018 14:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeCMOp3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 10:45:29 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:43025 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeCMOp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 10:45:28 -0400
Received: by mail-qk0-f179.google.com with SMTP id g184so1804413qkd.10
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c1o3R7zN/RNIrA0dv8wJM3SnczazOJaWoZaT2EliFsw=;
        b=iuF8lbDFE22yejPLAN+yzy5HlRmdZKof4LIA16dKhBxZWRSAfZudP2nKab3AMOYUrk
         TGo0BfLe1MqR8vSRmeqlE+DL8ypq1JtBszAQK5n2nZKv+EjSmubBNHkKXTip8Lxs24bG
         dD6j3LsmQG91ojv8KggvOANaovI/ybitbcnDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c1o3R7zN/RNIrA0dv8wJM3SnczazOJaWoZaT2EliFsw=;
        b=T2IkNxzZhgZ7y9Kg2/X6ICGW6fPeGS+43mqUcp4xxfDp+P+nYBRG+l27j4PtNXyUFt
         rkxOPm+oCccFfv0s9vkZ8+n/iLFOrWiZfgCQHGlGyYapjtoVjzNZQVOXI6MZ2+7PwzVW
         68IWInrhy/8wZqXcqryrcN7BOAT/z2tQ2HmPl4uuybe4azJcsqlOslcSgFZlWG4HI+Yl
         sGf4VUYVobm9aEtKmkU9YxLfwr1bMr9DbPl5V4TWsb4kuEz0DBDfNF9mrgDC7VFaJ2nf
         zGNKMjXPM+X/RHezqCt+VIv6HFuNFIyFEdmn+CBsMzdN0t4zl3ISKRhqCXyIzLpfWr4T
         G2QA==
X-Gm-Message-State: AElRT7HpEXpPejjtu/ZorJKrkbFau9xuJk30tfs2M7Vju8C8ctN4UbAz
        7GKyqma3x0xMNkGr3mjsMmvNsNrcaPIRDzXYrJRklA==
X-Google-Smtp-Source: AG47ELutmHUmUa4X3vJMRfea3SyUpnud1SaCHzAJbYABPeYw9waXO4gPNrwPvDNO6sW0SyVGw/k0lVmx/PBM2xhz5qc=
X-Received: by 10.233.235.8 with SMTP id b8mr1367738qkg.250.1520952327587;
 Tue, 13 Mar 2018 07:45:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.36.141 with HTTP; Tue, 13 Mar 2018 07:45:27 -0700 (PDT)
In-Reply-To: <20180313033643.7686-1-viethtran1620@gmail.com>
References: <CC42B5EC-6594-45CB-9821-E1C0ECED354E@gmail.com> <20180313033643.7686-1-viethtran1620@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 13 Mar 2018 14:45:27 +0000
Message-ID: <CAE5ih78HdDvN+x94H3Tzygis8QGROUe4B-yBubFH4simN2u9vQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] git-ci: use pylint to analyze the git-p4 code
To:     Viet Hung Tran <viethtran1620@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 March 2018 at 03:36, Viet Hung Tran <viethtran1620@gmail.com> wrote:
> Hello Mr. Schneider,
>
> Here is my link for the passed CI build I tested on my fork:
> https://travis-ci.org/VietHTran/git/builds/352103333
>
> In order to test .travis.yml configuration alone, I used a sample python
> script call "test.py" that is already successfully tested on my computer
> instead of using the git-p4.py like in the patch I submitted since the
> git-p4.py file still reports a lot of errors when running pylint.
>
> It is possible to fix all the git-p4.py errors. However, I think it would
> be best to fix each error separately with multiple commits (each should
> fix a specific problem such as indentication, variable naming, etc.)
> since there are a lot of changes needed to be made in the codes. Since the
> microproject requires that I submit one patch, I decided to submit a patch
> that includes changes in .travis.yml only. If you like, I can also submit the
> patches addressing changes on the git-p4.py that fix the pylint errors.

You can turn down the amount of messages it spews out, at which point
it actually becomes quite useful.

I had a quick go with the list of enabled checkers found here:

   https://github.com/ClusterHQ/flocker/blob/master/.pylintrc

and it then gives about 40 warnings, all of which look like they could
do with fixing.

I think fixing them in a few patches would be OK, rather than
submitting 40 separate patches.

Quite a lot of the warnings are about the use of "file" - I've got a
change I'm working on which fixes some of those already.

Luke


>
> Thank you for feedback,
>
> Viet
>
> Signed-off-by: Viet Hung Tran <viethtran1620@gmail.com>
> ---
>  .travis.yml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 5f5ee4f3b..581d75319 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -46,6 +46,16 @@ matrix:
>          - docker
>        before_install:
>        script: ci/run-linux32-docker.sh
> +    - env: jobname=Pylint
> +      compiler:
> +      addons:
> +        apt:
> +          packages:
> +          - python
> +      before_install:
> +      install: pip install --user pylint
> +      script: pylint git-p4.py
> +      after_failure:
>      - env: jobname=StaticAnalysis
>        os: linux
>        compiler:
> --
> 2.16.2.440.gc6284da
>
