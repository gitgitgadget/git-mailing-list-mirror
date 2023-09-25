Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B974CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjIYLw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjIYLw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:52:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40E103
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695642756; x=1696247556; i=johannes.schindelin@gmx.de;
 bh=ijbcqc+emAdm+C3LEnqtaqeLkAggCWrLHbGLfDH8KCg=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=tmMw49utVe+sG7gdp3es+z5PrnRuNWGAd2PZZ230zRGXQu42O9G3oqV0iiWVDqNkKoo27HEYnTR
 C7clHbGjUC63iUiZIEzP/zdG+u0PaGUdKVp2lEe+ZLHtg6R/JDW+UjnqPoQaQr5qOyNfywxPoULtI
 10GMFxEZpJdd40EET+0sUcV16royvDWjdepCnW7gtZzck8WjZGbv3FTYqcDU0ovudDe7WTh4cnckG
 6XnEw3AoKI+KHzclTyl2bD2lNcF6G0z0QS8maUOk2mUnSMIP1a+0BUFlNn30ZaN2CiuXDDUNhvwgh
 LJU0E5Hsr6EKjoq7OOQ/Uk3ri5rnJYTN7y7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1qnVIU13Os-002mQA; Mon, 25
 Sep 2023 13:52:36 +0200
Date:   Mon, 25 Sep 2023 13:52:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/6] ci: add a GitHub workflow to submit Coverity scans
In-Reply-To: <20230923064948.GB1469941@coredump.intra.peff.net>
Message-ID: <d4dc96a9-fd5a-8238-e411-edd605d415f3@gmx.de>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com> <8cb92968c5ebd38f328ed325ddf7f2e531dc9190.1695379323.git.gitgitgadget@gmail.com> <20230923064948.GB1469941@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:td46SR/CS/0hltMWTO5YCGmydfB4lxkgc4E45t2tc0wjgrXPhgC
 HbvyFByq24qV81f4is/dSurOSbpkxChuFr6tXVAyYbeNEEU7gyNAPQDFZvF6YQkLIA2eke8
 6hXwdtpJkBvxXWs2Oc38pPkSbnTaNg/KLA546XeHS+2Nz3pOoC7GTVo9Om+ZSJYf7v36h5H
 QKIdxE7s9BLZryU2wjqew==
UI-OutboundReport: notjunk:1;M01:P0:TjaWkwNStSg=;bHYiR8ndfjmqJe2bIeI6rDDI0oh
 ZDc5wzs71pf7UI2sY3yxF5BR7TRojvbSxZuN6fj4AcDDUPiNsNLR1fSkqadSB9QMEByUNXd4m
 JED7WvFICTwdj+mdmmZ+znwxcmBwNF9ihBgZZoi1uNP4nWgXeh+S3CTAaGZpw/jA2yQ2JOtmY
 n9DY5TWQmnrUJe45DuSDt6bWOcyEuOIiHsVZuJ4tnV6h+7302yyZeu/GOFsY4fQ0UyZe6FdGV
 HrT26zLk1yRhtXrRGvj7qjQ/64xtvVSgN0mDryFhZWdslk5geuD4iIIvrcKQZphJgD6ziyk9A
 FVia3UF8WVXTiC/HDoE4aZvzkeUl9M0gm7X26FYyZlCqYnBFmLTwSGlYkr2zJ+suoOSob0nSZ
 KFOrvFB4Dy8Q/UJ/j7WAov0m+fjpg1EqTAIzT2ZIYgxVS7cVuMZ6YvrEyosAlHlh80RfsqiLW
 3Pi9bcziWTL/PbdE6wanwaxICq9j890v/rxWW4DqNsUsQj7f+x+zbQeqrr1ovov6m8y8P+RdZ
 znjpkUnp0go+rlAXAF3Rg6PdJ1BfoHhW8lpTkAMIwLO8yDdPFTvo7TFzYIUwKkojm1VZ8L/bW
 Q1DkzCmVTHv/3/J2ee0k6ChYQoEYXAVYjfNISZsg8xc59uwfhIARE9j8ab0MrfSacSdn+r5R/
 +cnJ/14+lCA0zCvlMbXUhyjyBZltYX/z2ytEUZ9R3/Qgke3pc9sMpf6mMbmTEO42JLlRtt46H
 hPDXD/f0CE3emS5mLRI+ELnvXTbWFc5f6OK/v1SXb9qo+fbKRBO6C7B9s/SNMKbZUvZavmeb6
 UlCMZZhhxF8kxwEhPm7vjeOJMZ0ILFP4T3L4ernZZ7vtMJLYc9uk+ub31Z1O7TXXudxfcadTm
 a9GCM819ckCoS9ExDjWkXh3mRkgcPysTXt7rkArJHEoXLMRwFjN/GOA1X3aJBrJx24WxwFREE
 HzubPe89N9+2f3qEbyKlUglrPA4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 23 Sep 2023, Jeff King wrote:

> On Fri, Sep 22, 2023 at 10:41:58AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > Note: The initial version of this patch used
> > `vapier/coverity-scan-action` to benefit from that Action's caching of
> > the Coverity tool, which is rather large. Sadly, that Action only
> > supports Linux, and we want to have the option of building on Windows,
> > too. Besides, in the meantime Coverity requires `cov-configure` to be
> > runantime, and that Action was not adjusted accordingly, i.e. it seems
> > not to be maintained actively. Therefore it would seem prudent to
> > implement the steps manually instead of using that Action.
>
> I'm still unsure of the cov-configure thing, as I have never needed it
> (and the "vapier" Action worked fine for me). But the lack of Windows
> support is obviously a deal-breaker.

It is quite possible that I only verified that `cov-configure --gcc` needs
to be called when running on Windows, and not on Linux, as there were many
more deal breakers to convince me that we should _not_ use
`vapier/coverity-scan-action`. Unless we fork it into the `git` org and
start maintaining it ourselves, which is an option to consider.

> > +      - name: download the Coverity Build Tool (${{ env.COVERITY_LANG=
UAGE }} / ${{ env.COVERITY_PLATFORM}})
> > +        run: |
> > +          curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/=
$COVERITY_PLATFORM \
> > +            --no-progress-meter \
> > +            --output $RUNNER_TEMP/cov-analysis.tgz \
> > +            --data "token=3D${{ secrets.COVERITY_SCAN_TOKEN }}&projec=
t=3D$COVERITY_PROJECT"
>
> You might want "--fail" or "--fail-with-body" here. I think any
> server-side errors (like a missing or invalid token or project name)
> will result in a 401.

Sadly, https://curl.se/docs/manpage.html#-f says this:

	This method is not fail-safe and there are occasions where
	non-successful response codes slip through, especially when
	authentication is involved (response codes 401 and 407).

401 is the precise case we're hitting when the token or the project name
are incorrect.

Having said that, I just tested with this particular host, and `curl -f`
does fail with [exit code 22](https://curl.se/docs/manpage.html#22) as one
would desire. So I will make that change.

As to `--fail-with-body`: it is too new to use (it was [introduced in cURL
v7.76.0](https://curl.se/docs/manpage.html#--fail-with-body) and Ubuntu
v20.04 [comes with
v7.68.0](https://packages.ubuntu.com/search?suite=3Dfocal&searchon=3Dnames=
&keywords=3Dcurl),
i.e. is missing that option).

In any case, in my tests, `--fail-with-body` did not show anything more
than `--fail` in this instance. Maybe for you it is different?

> This is mostly a style suggestion, but I think you can use:
>
>   --form token=3D"${{ secrets.COVERITY_SCAN_TOKEN }}" \
>   --form project=3D"$COVERITY_PROJECT"

That is how I did things in Git for Windows, but at some stage I copied
over code from `vapier/coverity-scan-action`. It is yet another slight
code smell about that Action that it sometimes uses `--data` and sometimes
`--form`:
https://github.com/vapier/coverity-scan-action/blob/cae3c096a2eb21c431961a=
49375ac17aea2670ce/action.yml#L89
https://github.com/vapier/coverity-scan-action/blob/cae3c096a2eb21c431961a=
49375ac17aea2670ce/action.yml#L118

> I notice you put the "project" variable in the query string. Can it be
> a --form, too, for symmetry?

The instructions at https://scan.coverity.com/projects/git/builds/new (in
the "Automation" section) are very clear that `project` should be passed
as a GET variable.

Even if using a POST variable would work, I'd rather stay with the
officially-documented way.

Ciao,
Johannes
