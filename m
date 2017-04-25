Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8FC207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 20:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1949626AbdDYUId (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 16:08:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:60672 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949211AbdDYUIb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 16:08:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MA9FV-1crn9L1NJx-00BMbE; Tue, 25
 Apr 2017 22:08:22 +0200
Date:   Tue, 25 Apr 2017 22:08:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
In-Reply-To: <20170425044320.17840-1-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.20.1704252148400.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com> <20170425044320.17840-1-liambeguin@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wW7u8oaWoD8YZpK/Epg6hyOZikR52Zevav6+a3fAZ4tlGEyBYLr
 xUVEO6nKZH08eWqt1okI6YLPVSaut5TuU8bZABuj5Y7Op5kz5v2K2/9uCyD0oj7YXygzjjw
 P+zdkEt6CYqHn7BKB8k5xD382Nyp0ZMqBi2hhL8ShfFwYYJdo7vHpAHJ6QvSW7haVaLaAFz
 1fm47JXRRhnsbyJ8ym++Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gwEAeGZIee4=:g5JIlatSAVw0NlyWhsMrdY
 58q5Yx7HIh1r/xNGq1ScqLIubyAkFFzWpzx2Y5GL75NEFpSEVucWc7TJ5xbAGePNfkHOa0akx
 K8CZ8bBmVSaE/rw90njGvH4DXjW9XZLcIrt7WAr2y3Pp4WBx2C38u029cGwN/7neQ5bMplZId
 YVT1TSICKTnI+DGw9XZc768nigCZ06sRFuCk+Z7heOuYBRqOuoeS9gVk/TG6e6qMuo1xklJEx
 XmAPPTEeNsm8sCd+AsHWkOU9W7obyt4cQu3yMdyqmG9ugxaKzidgyOr8tVmPeLPAf83GWwvcU
 1Uu5epALkWoP2nY27YT/xH7wy4YopeyQL3nsu+1mLuJKminGB3+ZUwCxL1wx8UVvJrYkLzSGX
 uTNwvQWhOuxJ+tFfR3DhB54Szw5ieT74uNncn5eA0xQG7px8WBcjhI3AP4Wg5uh33hMxLB6EQ
 8Ydpiae1CSVU9pvarPR+Zm76m6w4NvNeIBgxqBn97yGt9WUpoHIDzUlrByGdteCKGP6CJzkiU
 BLxdEVut4+S+UhK5DKWopf9h/cJD73CAos6xeDFK9OH5f1tWH1Miwt+CStnHqDOaGU5sZS5po
 hqEbsYM4OymipT/5hdy8WXoFy0y00pDhu7QtmEaWvfPYFX6vdlaXjOKG++XTlgJ6x/SwBMiGK
 NdRtIrKq4t3zIW6eOXiDOl8YJ6IjjesrGBC2j767kY/FBfQ5Sai5P7D1kQtl45OP0geAzJ222
 2FZp4Kr0zeaIOAnRR6++sAPDI9G5euoJjGPU+eEV368l0YvSMkF6Zv2ChhkUllAjuoGETQxuf
 8zdazpe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Tue, 25 Apr 2017, Liam Beguin wrote:

> Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
> to abbreviate the command-names in the instruction list.
> 
> This means that `git rebase -i` would print:
>     p deadbee The oneline of this commit
>     ...
> 
> instead of:
>     pick deadbee The oneline of this commit
>     ...
> 
> Using a single character command-name allows the lines to remain
> aligned, making the whole set more readable.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>

Apart from either abbreviating commands after --edit-todo, or documenting
explicitly that the new config option only concerns the initial todo list,
there is another problem that just occurred to me: --exec.

When you call `git rebase -x "make DEVELOPER=1 -j15"`, the idea is to
append an "exec make DEVELOPER=1 -j15" line after every pick line. The
code in question looks like this:

add_exec_commands () {
        {
                first=t
                while read -r insn rest
                do
                        case $insn in
                        pick)
                                test -n "$first" ||
                                printf "%s" "$cmd"
                                ;;
                        esac
                        printf "%s %s\n" "$insn" "$rest"
                        first=
                done
                printf "%s" "$cmd"
        } <"$1" >"$1.new" &&
        mv "$1.new" "$1"
}

Obviously, the git-rebase--interactive script expects at this point that
the command is spelled out, so your patch needs to change the `pick)` case
to `p|pick)`, I think.

In addition, since the rationale for the new option is to align the lines
better, the `exec` would need to be replaced by `x`, and as multiple `-x`
options are allowed, you would need something like this at the beginning
of `add_exec_commands`, too:

	# abbreviate `exec` if rebase.abbrevCmd is true
	test p != "$rebasecmd" ||
	cmd="$(echo "$cmd" | sed 's/^exec/x/')"

Also:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d5155..8b1877f2df91 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2614,6 +2614,25 @@ rebase.instructionFormat::
>  	the instruction list during an interactive rebase.  The format will automatically
>  	have the long commit hash prepended to the format.
>  
> +rebase.abbrevCmd::

It does not fail to amuse that the term "abbrevCmd" is abbreviated
heavily itself. However, I would strongly suggest to avoid that. It would
be much more pleasant to call the config option rebase.abbreviateCommands

> +rebase.abbrevCmd::
> +	If set to true, `git rebase -i` will abbreviate the command-names in the
> +	instruction list. This means that instead of looking like this,

This is by no means your fault, but it is really horrible by how many
different names Git's documentation refers to the todo script, nothing
short of confusing. It is the todo script (which I called it initially,
maybe not a good name, but it has the merit of the longest tradition at
least), the todo list, the instruction sheet, the rebase script, the
instruction list... etc

However, the thing is called "todo list" elsewhere in the same file,
therefore lets try to avoid even more confusion and use that term instead
of "instruction list" here.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2c9c0165b5ab..9f3e82b79615 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1210,6 +1210,10 @@ else
>  	revisions=$onto...$orig_head
>  	shortrevisions=$shorthead
>  fi
> +
> +rebasecmd=pick
> +test "$(git config --bool --get rebase.abbrevCmd)" = true && rebasecmd=p

A better name would be "pickcmd", as there are more rebase commands than
just `pick` and what we want here is really only associated with one of
those commands.

Ciao,
Johannes
