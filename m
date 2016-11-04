Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E162022D
	for <e@80x24.org>; Fri,  4 Nov 2016 16:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936234AbcKDQgz (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 12:36:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:50762 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933214AbcKDQgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 12:36:54 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0McEI3-1cK6B32lyJ-00JaAU; Fri, 04 Nov 2016 17:36:50
 +0100
Date:   Fri, 4 Nov 2016 17:36:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Felix Nairz <felix.nairz@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git -C has unexpected behaviour
In-Reply-To: <CADJspfL3zVCPv+mfRM_v4ukUggQkhGH7KB50a+HLPZXZqn1pXw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611041719140.3108@virtualbox>
References: <CADJspfL3zVCPv+mfRM_v4ukUggQkhGH7KB50a+HLPZXZqn1pXw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:s31/uq0LSEVHtWLVXaFbQNPB8LY5vWi9umfwl2aFC1L+qOt/YDJ
 JmHP+/id6PbYH+LiMo8y5YkFuvzIwAVQSJRrBFar7ow7Xv5dYUQRMbRkWFCbSWKiA8e3Oil
 gNCjW61KgNMgj9EzkI8Z3SEqCrSWxOvqsWSt+2hKIgmurKwM6kQWpCFMDTx1ctnw0O30qRy
 dXQni8g9huCCBmbzMh6dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9lDuTfWFJwE=:iWWJJXEF8gQ62iaPt1AE8/
 e2ElNJBK5OFUTxAroaclyGNWVIVDwvkHBUYuyjAuJ4a4gMrbaAq6ibIz+Pdq7LQ8xNmX86BLE
 bcOXJtuudqsQSRpo0+OGCc+pzEMoRrz3vZ92MAWiftuKdFXE6KqH3f0RhVWCSDKq/CYLn0oSo
 4LYJ9eIphpP6zBoltvbnlc7RNyKn7x+mV5fG2zPOc8pkc+aJS/cOTRO8SeFNd5wz1OnA1XmwT
 MIPpOMO07uq6YV+TeHlVQNjEPRL6xp9AmwiWi/f6y/XF8V61hFRoB4ASPnkNGT/2tqyXLt46Z
 XPZMCq8JuWU6Z91+E0ZupEIzIDxI4EZROKC0KcDxT8UJsPRTMqYPqO0wlfxtui69XOCEbrigi
 02tUduVgcaFQ3T/ZxSm8vixQj+fYlNUvkK34iyhvqrutABDuB88wjAXb2fwu1QNHj+9iI/SMx
 2AVV8S87FFUHPEW7NwR2HttSgMbW5Xg6umynyGIXs41gHchE/w0wyQlCyxC0d4C4wwEox4r4o
 j/VBnPZCL4YMZUUackVHkViBn+xlBmMhpi7bjqZ4tqaeM0Z7y+zyVeeYVqIuYww8qiBy6usb1
 4C1uhcmYLXdUzST5ApqSWdNya64h73Q95ZOyPD2XsAYcxoLg85nH9mfqo3vPtAxg+PIANr1r4
 47epmjdqs/IcstTEo5E45PjBM0EQYy2mPNOcxucIN8R5CJcXjYxPFofroRLWNiuv2jv6mFLSB
 //vDt9C+XPfXDumJW6NexZ5fe2f2v9s+zyO4f03GxfrtPJ0ALAKmucxqkcriTKklu7iUbpkCf
 m0QZQ9d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felix,

On Fri, 4 Nov 2016, Felix Nairz wrote:

> Now, to the unexpected part, which I think is a bug:
> 
> If the TestData folder is there, but empty (I deleted all the files),
> then running
> 
> git -C .\TestData reset --hard
> 
> will NOT throw me an error but run
> 
> git reset --hard
> 
> on the git repository (not the submodule in the sub-directory!),
> without warning, or error.

I *think* that this is actually intended. Please note that -C is *not* a
synonym of --git-dir. It is more of a synonym of

	cd .\TestData
	git reset --hard

In other words, you probably expected -C to specify the top-level
directory of a worktree, and you expected Git to error out when it is not.
Instead, Git will treat -C as a directory *from where to start*; It *can*
be a subdirectory of the top-level directory of the worktree.

Please note that

	git --git-dir=.\TestData\.git reset --hard

will not work, though, as it mistakes the current directory for the
top-level directory of the worktree. What you want to do is probably

	git -C .\TestData --git-dir=.git reset --hard

This will tell Git to change the current working directory to the
top-level of your intended worktree, *and* state that the repository needs
to be in .git (which can be a file containing "gitdir: <real-git-dir>",
which is the default in submodules).

If the repository is *not* found, this command will exit with a failure.

Ciao,
Johannes
