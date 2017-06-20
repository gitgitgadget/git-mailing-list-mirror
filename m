Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D171220282
	for <e@80x24.org>; Tue, 20 Jun 2017 19:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdFTTXu (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:23:50 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33068 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdFTTXu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:23:50 -0400
Received: by mail-pf0-f172.google.com with SMTP id 83so73808126pfr.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AFEOixLGtzOagCfap7CyvTTCIIW/4UtEYHLn4u4hx70=;
        b=OiP1ODNsHDF3zl6haiFpo8Sa9JDR3D/Y4/gQpUeydamvCc9EmVUxinF5Sv1JDI08U2
         YBDwdpLcI91vWfjYhSAcup3EgxoXlWNc6Ya2ogEkB3qJEuLLs+pNCCOUGa8b13KJvtqr
         sOSjElQfrSCRYfi0AS2FzVhdgUGojuq0ht8gcouX2sNDrKzFxbvKrcGgHKZRGQC+lV5w
         Ql9UD8tm9milA6SHKDn6TSUQF3eP8X8P+U2Fj5RSfV6fxUtn+emoDwJli68gfCrHk6CO
         0qjOwBCQYd7ZD5NMMU82NKd4NEgH0l7qTWBVDCJqOwgMWhKFbkmCOVFdjOF9vznGLlEI
         jNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AFEOixLGtzOagCfap7CyvTTCIIW/4UtEYHLn4u4hx70=;
        b=Okpil3ew2e5e2VGfNUdhSYsZUyDtO9HjD1r3agxBD6s6kPhqq4PG6juGkc2YjncUaI
         8bjREseoHO1G5gfL2lO5q03m2IeF0QNxHhuV3vtiwF5B7J3e1vvVaPrRuRPDfSGmJNPU
         MtQvFnxTunzJVxMk0q46JJ1hzkPxiw0G2TmaLEGaBPVmjkBJOgvw6IgVNoruGB03Vnu+
         ksIhDyfiX79VgvGpyKbQBburPHOxm2C48y33tgpi8qzpVchQYiQIIy1Ok1pgwdg9ZeBM
         dsDaPe/F9fxZURowm73sZPjZGhohAd7uEbiETCDEgsM81iew1O7X8X430SGB00PWu8Mq
         /izw==
X-Gm-Message-State: AKS2vOzrNbRe7NOwOI192+H+vTkvPoI2McRnr5fIv3/i6hv/aU9BCXqE
        o6Dl5snswe+hFPbPoreVi7RxGQt0fbTkg54=
X-Received: by 10.101.85.69 with SMTP id t5mr33273131pgr.201.1497986629258;
 Tue, 20 Jun 2017 12:23:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 20 Jun 2017 12:23:48 -0700 (PDT)
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com> <20170620191951.84791-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 12:23:48 -0700
Message-ID: <CAGZ79kYmqRQF8gzWBxLFVuu2=ACySfvdxvJJcuRkbX9CmoNYYQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] repository object
To:     Brandon Williams <bmwill@google.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 12:19 PM, Brandon Williams <bmwill@google.com> wrote:
> I decided to split up the original series into three parts in order to make
> review a little bit easier.  As such this series is dependent on on
> 'bw/config-h' and 'bw/ls-files-sans-the-index' which should be moving into
> 'next' soon.  Due to this I was able to greatly shrink this series in terms of
> number of patches so hopefully it is a little easier to review.
>
> As before you can find this series at:
> https://github.com/bmwill/git/tree/repository-object

If you plan on building 'foreach' on top of Brandons series,
maybe start off the latest version here.

>
> Chagnes in v3:
...
>
>  * Added an additional initialization function to allow initializing a 'struct
>    repository' as a submodule of another 'struct repository'.

This one seems relevant for 'foreach'
