Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CC6F20323
	for <e@80x24.org>; Wed, 22 Mar 2017 15:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935464AbdCVPuF (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 11:50:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:64545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760250AbdCVPtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 11:49:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ldq55-1cPwU63h8V-00ixjG; Wed, 22
 Mar 2017 16:49:29 +0100
Date:   Wed, 22 Mar 2017 16:49:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
In-Reply-To: <20170322065612.18797-1-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1703221641070.3767@virtualbox>
References: <20170322065612.18797-1-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TBU3qr7NfcJgkFRommlMB8ErP4HqPIYyoMPIO99Oil7og8CH8j8
 mFcjVO8jwJwmpZazWEJTlOdGRjS0steWnswpMP+MwD6AijDYoNouvgVVOReblU9Q3z6yqCV
 3Zbz/deYD45UGjiA/kJEEFnPRfOgFszHXyTL5I2gPNmaXfMvMWqYq4iCU2bOzEDOuUyCzQC
 m5oouuzFsMxczead8G2Jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tkG16AxIhvk=:pTS2Dxx3JadKmEhrkZK+S5
 kAHqIJVqvZAGul4SOtKu8s1x0sHWVjTChUSaxmfdL2B1skQwcuaydluBwOc9SiIGZoQEonq5s
 g62ZUbMxEHUA4FQWgFkMhKS8urFHmWzmcWqFue046kFGI+dN12zD/+m+LzaNZdidG7w45EYLs
 vEoSVar4D07QRzb8/LtbR1dpZImkmtWQRgrfA4rBdopoQ/s7OmQRB8IpdrgkGap4RjpOLEPxg
 cBMXvq7vgQmTQkDMKLfZ0cWMjaornVCgbRmPrBAO8AJCsA82Ic9q/LDibHsgr0BNNQmpOUU8b
 yD5/wNxCZ0sFsBLfHYh1cHZvKZCXO/Q5ZWnAbmBLXEmDsO5e6VlnotluCKc/O5ar/vw3Zmkkk
 5HS2Vk66GWGPqpY5dq1UOZmKIjrt+yt71Q7skUh2IEKUkUuaHGuv5vlOROKPcc12v49Z/xdFh
 JHsqL9ZPxgsREyQKJbFpcchxDzowBz5IEJn1TCPhqmdGpA1AW/sKPvoApFAsfmFj+GZTGGwJH
 h+opL4Nnmfr58ZfN9y3+WWStYjKMPNr+v2hPPb9nzFnY1vEVRj7OS6FNRqvPoypd3asNWEGQ3
 pJLFX2gn6L9O3+lN72UqgbE8DcBbF25WtbukVAgeK7XR7T+z91lg9iJeiHX39cBfHmWHfYbAm
 xD4ZgTvV/WaxDx3gauQn7J6fxWdVl8yiRVvTPImjh8+ji0/bXIl+jlPZc2plzvK8TSuUDnDhI
 DJdivL1jzxdbKRL/wW5yAgChBZ05Oa0ok8m86TPs1LQDKL+0tUNP48uebBy1xoZBvc5X4oBCH
 uor7oxxIFNx5zy/eLxXFezT8MN9NA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Wed, 22 Mar 2017, Lars Schneider wrote:

> Things, that might need to be done:
> * The Windows box can only process a single build at a time. A second
>   Windows build would need to wait until the first finishes. This
>   waiting time and the build time after the wait could exceed the 3h
>   threshold. If this is a problem, then it is likely to happen every day
>   as usually multiple branches are pushed at the same time (pu/next/
>   master/maint). I cannot test this as my TravisCI account has the 50min
>   timeout. One solution could be to limit the number of concurrent
>   TravisCI jobs [2].

There is another possibility, too, of course: I may be able to find more
resources and add other VMs which could be used to build and run the
tests.

Of course, if those tests would not spawn billions of POSIX processes,
things would be faster, too, and we could afford to wait for a single
build agent.

> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
> new file mode 100755
> index 0000000000..324a9ea4e6
> --- /dev/null
> +++ b/ci/run-windows-build.sh
> @@ -0,0 +1,55 @@
> +#!/usr/bin/env bash
> +#
> +# Script to trigger the a Git for Windows build and test run.
> +# Pass a token, the branch (only branches on https://github.com/git/git)
> +# are supported), and a commit hash.
> +#
> +
> +[ $# -eq 3 ] || (echo "Unexpected number of parameters" && exit 1)
> +
> +TOKEN=$1
> +BRANCH=$2
> +COMMIT=$3
> +
> +gfwci () {
> +	curl \
> +		-H "Authentication: Bearer $TOKEN" \
> +		--silent --retry 5 \
> +		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" |
> +	sed "$(printf '1s/^\xef\xbb\xbf//')"  # Remove the Byte Order Mark
> +}
> +
> +# Trigger build job
> +BUILD_ID=$(gfwci "action=trigger&branch=$BRANCH&commit=$COMMIT&skipTests=false")
> +
> +# Check if the $BUILD_ID contains a number
> +case $BUILD_ID in
> +	''|*[!0-9]*) echo $BUILD_ID && exit 1

Error messages are delivered that way, and they do not start with digits,
true. But maybe there is an exit status to indicate to Travis that we
cannot decide whether the build failed or succeeded in that case? The most
common cause for an error here is that the VM I use for testing is down
(which happens every once in a while to save on resources, and I have to
manually restart it)...

> +echo "Visual Studio Team Services Build #${BUILD_ID}"

Nice plug, thanks! ;-)

> +# Wait until build job finished
> +STATUS=
> +RESULT=
> +while true
> +do
> +	LAST_STATUS=$STATUS
> +	STATUS=$(gfwci "action=status&buildId=$BUILD_ID")
> +	[ "$STATUS" == "$LAST_STATUS" ] || printf "\nStatus: $STATUS "
> +	printf "."
> +
> +	case $STATUS in
> +		inProgress|postponed|notStarted) sleep 10                      ;; # continue
> +		         "completed: succeeded") RESULT="success";        break;; # success
> +		                              *) echo "Unknown: $STATUS"; break;; # failure

Well, there are more values for the status, and we know them, but we do
not handle them. Maybe "Unhandled status:"?

> +	esac
> +done
> +
> +# Print log
> +echo ""
> +echo ""
> +gfwci "action=log&buildId=$BUILD_ID" | cut -c 30-
> +
> +# Set exit code for TravisCI
> +[ "$RESULT" == "success" ]

Very nice. Thank you so much for keeping me working on this!

Ciao,
Dscho
