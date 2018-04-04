Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0C61F404
	for <e@80x24.org>; Wed,  4 Apr 2018 16:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeDDQQU (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 12:16:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:33531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbeDDQQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 12:16:20 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M4WuC-1eIEZG36SK-00ye3g; Wed, 04 Apr 2018 18:16:14 +0200
Date:   Wed, 4 Apr 2018 18:16:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Clemens Buchacher <drizzd@gmx.net>,
        Manlio Perillo <manlio.perillo@gmail.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, manlio.perillo@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] completion: improve ls-files filter performance
In-Reply-To: <20180404074658.GA5833@Sonnenschein.localdomain>
Message-ID: <nycvar.QRO.7.76.6.1804041805150.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <1521274624-1370-1-git-send-email-drizzd@gmx.net> <1521274624-1370-2-git-send-email-drizzd@gmx.net> <20180318012618.32691-1-szeder.dev@gmail.com> <20180404074658.GA5833@Sonnenschein.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TlkT3vH05ibdjWNQDmtIBW5u5OpEeFZw6bIADWSXz4hGTp/n09w
 t8hWRc0m2Xr0mG2T/4HpDa1z1k2L/L9VqZziwmud2YezdSCogcxmVsSN55A+iw6BlPbken4
 AHSQ2w7p0o45VsGFKFweIBYvMuLr9MN32xR+jP0M3OQwSCWcwqKO4HN7c7g8O4RLcjlt/Lh
 WWyBzp5pUDlK/ZDj0Z6yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AGww24UivAE=:5RqiNmIthvX7/j457gJ8lX
 wnkwvL+7YUdx7Ij+BnFqiLbIIoscksI5tjyVozT0y6SckYBwxIy415FiFM1rERYdra4NHgo1E
 2AcoWRYGLOlsF3sy1huyc42Q15GIjoh5cEJ3qOt/SHkzAekwpigydNU1p3jVOF0OTmCMSOs9l
 r3ijWvgYHCEA8k3VJAdrk3BrvCB/y9gFWXKZdFDAbMLsIw2NyFQmn/6vlyvfBZRTi6tnYqUJM
 FcySp9cWQAFqt3fYegFelsfB3swdDGbKDNsfGMh+0T7oyJEilwg2FkNcXBVDCVHGxN8Rk5S6s
 5K7khdyHVdrMe9M47pQ34K49PY2sVCiv5H3XbLxfz5kiWM+36+lcpLzVCScERC7NF7tTwA75X
 Csfz8t2clbUqexlqKA2olRn+rSqiDuqO5uPers1AaSRZ0CX/j8T9s2nE1OC0L+H4kYR/fpi0e
 XITyZS/yvbo+eYSxo/YfuVF3wvNh1bUTLGxhOk4E2VaJ+tqFwMAHppwokzAXrl3ZM4ZckyzJm
 VxFJVguxENEE9N0YWq8svm4LpwF0TTcomhORtNS7bJL3QphKUvffcNDuh5agWlcf/KPWc8QS4
 NmK/jG8o1wQWFlxFJipttVYhXUA51q5jNHHokrseaH/UThyeukQwl/Ep6tWNNHuS/L8N2B8ND
 Ep3gb0Bo/aitgii5kqyLiy/KxG5ztCnhH7o41kM9mBRfzAluapDOQVDk8udnkD1w19LBgoWRA
 uMN6PVzdFHtF5eqAvBHEYQmEBs6A+wHTMmY1PK3Af31am6Z2YYLSA7Qgdv6o0swd4OsWAIQu5
 ipxqVi2H0HUjyEJbp9agXQMTeafEuaEIBVxIKfX6hHYRaXGfcqqYJ99ZM5GXWFk+iO2qDJi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi drizzd,

On Wed, 4 Apr 2018, Clemens Buchacher wrote:

> From the output of ls-files, we remove all but the leftmost path
> component and then we eliminate duplicates. We do this in a while loop,
> which is a performance bottleneck when the number of iterations is large
> (e.g. for 60000 files in linux.git).
> 
> $ COMP_WORDS=(git status -- ar) COMP_CWORD=3; time _git
> 
> real    0m11.876s
> user    0m4.685s
> sys     0m6.808s
> 
> Replacing the loop with the cut command improves performance
> significantly:
> 
> $ COMP_WORDS=(git status -- ar) COMP_CWORD=3; time _git
> 
> real    0m1.372s
> user    0m0.263s
> sys     0m0.167s
> 
> The measurements were done with Msys2 bash, which is used by Git for
> Windows.

Those are nice numbers right there, so I am eager to get this into Git for
Windows as quickly as it stabilizes (i.e. when it hits `next` or so).

I was wondering about one thing, though:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6da95b8..69a2d41 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -384,12 +384,7 @@ __git_index_files ()
>  	local root="${2-.}" file
>  
>  	__git_ls_files_helper "$root" "$1" |
> -	while read -r file; do
> -		case "$file" in
> -		?*/*) echo "${file%%/*}" ;;

This is a bit different from the `cut -f1 -d/` logic, as it does *not
necessarily* strip a leading slash: for `/abc` the existing code would
return the string unmodified, for `/abc/def` it would return an empty
string!

Now, I think that this peculiar behavior is most likely bogus as `git
ls-files` outputs only relative paths (that I know of). In any case,
reducing paths to an empty string seems fishy.

I looked through the history of that code and tracked it all the way back
to
https://public-inbox.org/git/1357930123-26310-1-git-send-email-manlio.perillo@gmail.com/
(that is the reason why you are Cc:ed, Manlio). Manlio, do you remember
why you put the `?` in front of `?*/*` here? I know, it's been more than
five years...

Out of curiosity, would the numbers change a lot if you replaced the `cut
-f1 -d/` call by a `sed -e 's/^\//' -e 's/\/.*//'` one?

I am not proposing to change the patch, though, because we really do not
need to expect `ls-files` to print lines with leading slashes.

> -		*) echo "$file" ;;
> -		esac
> -	done | sort | uniq
> +	cut -f1 -d/ | sort | uniq
>  }
>  
>  # Lists branches from the local repository.

Ciao,
Dscho
