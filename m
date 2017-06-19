Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045D41FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 16:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdFSQbr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 12:31:47 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33066 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdFSQbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 12:31:46 -0400
Received: by mail-pg0-f44.google.com with SMTP id f185so50366685pgc.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S1mVVLqwsyjyWuMAnoZ67i+WBViCgldmu8Fxw8a221s=;
        b=FFOrzqc0M3YWNe5xbeKNovMks3WMU8v5sXiQDI/UfuTng0iu0NuYc1NfAz1kzoL0PZ
         dGukKs2dFeSYZsQppLSrejp+P2gBxw2FFDw4EAEJ5HkCe6hMKTAukFm+d7pRrTTCfbNl
         PfWXQwzi1ZFq1OdNdiCfpVJjSjBUXNg74RQBcGJerThdVnbHmf+X+SaRIeWHe5hYS3wW
         PmMJj1sRgaH1VgK3CClybiFh4uAyzmXFrJUVhIsjF5DSbJeNLk49+AWhBkZxPALKEnbw
         EaRVF3boDxJrzdi7I5UWFWFNKhFJkz15Vg1OBb93PZa0CJxSgGYJvRNkfe/IJ6EoTZA1
         yBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S1mVVLqwsyjyWuMAnoZ67i+WBViCgldmu8Fxw8a221s=;
        b=rYe7RM6xPBcJD7786a7pB2BgF2B9NPt8/avhfuQmC2RRsL1inX9W525WeIZ7yeVuSm
         Ge12Uj2tZmi3cZuekhhlSX5Cti37cU5pjPfMuU5+XSIsIkpWfTInO58+ZuG9k/kNzN+3
         GeaULvuucCHYVsaS7rx6qASWxjbHq1g0qbbOERsifAp+xQAgzuz87qN2WW1EDabA1wqQ
         0kJX01bBf2QB1K5wUu4jw1Oql22qTxrbzWLrANj2eGAfPN1b5TCehYX+B18u9V/6B95v
         i3jsM53I/3GgI3FbvAVj9lelNXD1Yi6OMbDv44Slg0SOr54/jnYzRHflwbGMJT1wH2fP
         4f+A==
X-Gm-Message-State: AKS2vOwr6hCrHueUaLnAblOtuSTpL79AP291e0bA0qHqBStkM/LGi5nd
        EYN6HBZIw0hSOWtmwFf0cp9x2gPre9ML
X-Received: by 10.84.232.205 with SMTP id x13mr5799292plm.245.1497889905104;
 Mon, 19 Jun 2017 09:31:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 09:31:44 -0700 (PDT)
In-Reply-To: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 09:31:44 -0700
Message-ID: <CAGZ79kY9JhWYuPMjHac=gD+dPcma1hVTtbPKdgbTqYx0oMECRg@mail.gmail.com>
Subject: Re: Restoring detached HEADs after Git operations
To:     Patrick Lehmann <Patrick.Lehmann@plc2.de>
Cc:     Git Mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 1:46 AM, Patrick Lehmann
<Patrick.Lehmann@plc2.de> wrote:
> Hello,
>
> I wrote a Bash script to recover branch names after Git operations have create detached HEADs in a Git repository containing lots of Git submodules. The script works recursively.

Cool. :)

You may also like
https://public-inbox.org/git/20170501180058.8063-5-sbeller@google.com/
https://public-inbox.org/git/20170501180058.8063-6-sbeller@google.com/

These patches are still on my plate, they are not landed yet as I had issues
coming up with a good convincing commit message.

They are essentially putting submodules back on a branch (if configured).
Let's see how this differs from your solution.


> I would like to see:
> a) that script or algorithm being integrated into Git by default

For that you'd want to send a patch, see Documentation/SubmittingPatches.
We'd want to discuss if this command is an independent command
("git submodule reattachHEADs", name subject to bikeshedding ;) )
or if it is a configurable option that is obeyed by anything that touches
submodules (which I would prefer, as this mode seems to be the
"correct default". When having it as a mode we can switch the default
eventually such that submodules are always on a branch).

> b) that as a default behavior for all Git operations creating detached HEADs

changing defaults is hard. Let's go with a) first and then people will
report how
awesome the new mode/command is and then it is easier to see how this
may be a good default. :)

>
> That's the command:
> --------------------------------
(reformatted for readability:)

git submodule foreach --recursive
  'HEAD=$(git branch --list | head -n 1);
    if [[ "$HEAD" == *HEAD* ]]; then
      REF=$(git rev-parse HEAD);
      FOUND=0;
      for Branch in $(git branch --list | grep "^  " | sed -e "s/  //" );
      do
        if [[ "$(git rev-parse "$Branch")" == $REF ]]; then
          echo -e "  \e[36mCheckout $Branch...\e[0m";
          git checkout $Branch;
          FOUND=1;
          break;
        fi
      done;
      if [[ $FOUND -eq 0 ]]; then
        echo -e "  \e[31mNo matching branch found.\e[0m";
      fi
    else
      echo -e "  \e[36mNothing to do.\e[0m";
    fi'

> --------------------------------
>
> How does it work:
> 1. It uses git submodule foreach to dive into each Git submodule and execute a series of Bash commands.

If you want to see it upstream eventually, we'd make it shell commands.
There are some subtle differences between shell and bash,
one of them is the way conditions are written. I think plain shell
does not support [[ ]], so that would become

  if test $FOUND -eq 0
  then
    echo ...

Maybe look at git-submodule.sh for coding style suggestions.

> 2. It's reading the list of branches and checks if the submodule is in detached mode. The first line contains the string HEAD.

This works for you but some crazy person may have a branch containing
HEAD in their branch name. ;)
("git checkout -b notADetachedHEAD")

I think that check can be improved via

    if test $(git symbolic-ref HEAD 2>/dev/null >/dev/null) -eq 128
    then
      # detached HEAD
    else
      # on a branch
    fi

so if the output of symbolic-ref starts with ref then it is on a
branch. In detached HEAD

> 3. Retrieve the hash of the detached HEAD
> 4. Iterate all local branches and get their hashes

  What happens (/should happen) when multiple branches have the same sha1?
  With this implementation the first wins? Is this 'lazy guessing' desired?
  The patches referenced above assumed you'd have submodule.NAME.branch
  set and we'd reattach to that branch only (if matching hashes)

> 5. Compare the branch hashes with the detached HEAD's hash. If it matches do a checkout.

Speaking of checkout: checkout --recurse-submodules is a
thing in the latest version of Git, but it also detaches HEADs.

I'd like to have reattaching HEADs in there and then combined with
"git config submodule.recurse true", which is in master but no release
a plain "git checkout <branch>" in the superproject would put the submodules
on branches.

Using checkout within git submodule-foreach works of course just as fine.
Note: Currently Prathamesh Chavan converts git-submodule-foreach to C
https://public-inbox.org/git/CAME+mvUrzVxpRdPDvA1ZyatNm2R27QGJVjSB3=KX85CEedMaRQ@mail.gmail.com/
so it will be faster. In the process of doing so, we surfaced a couple
of bugs, but
they would not impact this script AFAICT.


> 6. Report if no branch name was found or if a HEAD was not in detached mode.

... and it is colored unconditionally in red. Maybe have a look at
    git config --get-color[bool]
which can help in figuring out if we want to print color codes.

> The Bash code with line breaks and indentation:
> --------------------------------
> HEAD=$(git branch --list | head -n 1)
> if [[ "$HEAD" == *HEAD* ]]; then
>   REF=$(git rev-parse HEAD)
>   FOUND=0
>   for Branch in $(git branch --list | grep "^  " | sed -e "s/  //" ); do
>     if [[ "$(git rev-parse "$Branch")" == $REF ]]; then
>       echo -e "  \e[36mCheckout $Branch...\e[0m"
>       git checkout $Branch
>       FOUND=1
>       break
>     fi
>   done
>   if [[ $FOUND -eq 0 ]]; then
>     echo -e "  \e[31mNo matching branch found.\e[0m"
>   fi
> else
>   echo -e "  \e[36mNothing to do.\e[0m"
> fi
> --------------------------------
>
> Are their any chances to get it integrated into Git?

I like the idea and I'd be happy to review patches. :)
Also you may want to look at the C version that I provided
above and tell me why yours is better. ;)
(Maybe the chosen defaults are saner, or such?)

>
> I tried to register that code as a Git alias, but git config complains about quote problem not showing where. It neither specifies if it's a single or double quote problem. Any advice on how to register that piece of code as an alias?

(a) not using the alias system for everything:
* You can define this as a (ba)sh function in e.g. .bashrc and then
just call the shell function from the alias.
* or you can put the code into an executable script "git-NAME" and
then the alias would be just "git submodule foreach --recursive git
NAME"
(b) define the function inside the alias, cf.
https://www.atlassian.com/blog/git/advanced-git-aliases

> If wished, I think I could expand the script to also recover hash values to Git tags if no branch was found.

Personally I do not think we should attach a HEAD to a tag in that case.
tags are just like branches with special meaning, i.e. they are also
in the refs/* hierarchy.  Note how git-checkout <tag> detaches from
the tag such that you do not modify the tag by default.

>
> Kind regards
>     Patrick Lehmann
