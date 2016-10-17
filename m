Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2BB1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbcJQR7E (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:59:04 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36436 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbcJQR7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:59:02 -0400
Received: by mail-qt0-f172.google.com with SMTP id m5so128999255qtb.3
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0guXsNl9ZhFBxOhCm1tyKVU1tkTqdUdud5mBuTA5T6c=;
        b=FFqRosn9pN4HxKUgwGyZ1wyu45WG2lwzgy2ZiO9EMtNtu2+JrfKcy/CXobnS5a++No
         tfgu9+SfIGb32fzKjGVvFTjl/FdPB1O/XjtQPJmRfdIMSWSH84UaWiSc5u71i/x/EHFk
         0ucwKvSA9RnkN3tRiWklNITE959C4Tj1KCX1ZU+Ms0rq1ZBNDGshPoPsLeV0EZ0n383m
         Ijau+i4TGxY8/NMO10UJHReqG0yKwYAiqCePX6EFEe4a33WVaeBabr4+sCiIgoel4wKh
         6oGrnZ7/SVU/cSBFNoJ0pD0S8D/lut4RnKfMSYGxcssadWoXzuLR9kRbWeV5P+Cy2d/d
         c6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0guXsNl9ZhFBxOhCm1tyKVU1tkTqdUdud5mBuTA5T6c=;
        b=EM9veRI3WGJKTHaBLHJt7NZg9AkDkbuiF5RuXmWVqCj2KO/KeyNbw+CeGGZgH4sB+l
         Fhwxkx0mU9jPbZeVdBl2oiS8cuurQqfZUVD3z1idzJqeEuXEm3orsqClhDpcBFMNRwU8
         msPpZ1sHJ3oVHcIUGnEvjq8SlW/L/l38jfrY7RGjHoxbFAzU4st1M5d8s9r2fm2yTdKI
         8PmBEymNlyAP3yW/UfHUPpRCo3cueYp5EbTw9AT3AfnSWt/38R/Z78ClInJvrhsgihRE
         +sgf68ZNhDxDPQGIUIBNjTxkHuThCxBPm2ASgnZg4XZq92onaRGD12M6Luu+p7lZmfof
         0Ktw==
X-Gm-Message-State: AA6/9RmvsTLYNuRtdg9ECUxEP7WA25j4ozkMtHQtu1MUrO2ssvdCy3YyE5iEeBvYNMW8yihcqMy1gXlH/GWRGsKI
X-Received: by 10.200.34.6 with SMTP id o6mr27431286qto.88.1476727140383; Mon,
 17 Oct 2016 10:59:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 10:58:59 -0700 (PDT)
In-Reply-To: <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
References: <20161010175611.1058-1-sbeller@google.com> <alpine.DEB.2.20.1610121501390.3492@virtualbox>
 <CAGZ79kYDpth7YDbN0VRD0dcpp7aeQ-y4HSEhsmd_c46ggZoXsg@mail.gmail.com>
 <alpine.DEB.2.20.1610131255001.197091@virtualbox> <xmqqfunvxxgu.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 10:58:59 -0700
Message-ID: <CAGZ79kYW2qK1GKxoKy_mkVkjjqEUzkh5aPSzDEfRd6U=PYDdzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule: ignore trailing slash on superproject URL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 12:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> > expecting success:
>>> >                 actual=$(git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' '../.') &&
>>> >                 test "$actual" = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'
>>> >
>>> > +++ git submodule--helper resolve-relative-url-test '(null)' '/usr/src/git/wip/t/trash directory.t0060-path-utils/.' ../.
>>> > ++ actual=C:/git-sdk-64/usr/src/git/wip/t/.
>>> > ++ test C:/git-sdk-64/usr/src/git/wip/t/. = 'C:/git-sdk-64/usr/src/git/wip/t/trash directory.t0060-path-utils/.'
>
> This may well be total misunderstanding on my side, but is the
> expectation of this test even correct?  If it wants to take "../."
> relative to "$LEAD/t/trash utils/.", should't it go one level up
> with ".." to $LEAD/t and then stay there with ".", expecting
> "$LEAD/t" which is what the above is giving us?
>
> IOW, the above makes me wonder why having one of these as the base
>
>         A - path/to/dir
>         B - path/to/dir/
>         C - path/to/dir/.
>
> to resolve the relative "../." give different results.

Because the shell script originally did "just"

relative="../."
if path/to/dir/ ends with slash, chop it off.
while $relative starts with "../";
do
    chop off starting '../' of relative
    chop of last '/' and following from "path/to/dir/."
done

(Linux:)
As B was made to A first, only C differs as a result, because
you had one more '/' in there.

(Windows:)
However Windows also detects '/.' (C) and makes it an A,
(in C only, because shell code was not treated Windows-sy)
which is where the incompatibility between Windows and other
platforms arises.

So we have a couple of choices (for Git)now:
* go back to using shell only for submodule things as that doesn't
  have the regression and it alos plays nicely with Git for Windows.
* use C for the submodule code in Git and revert the regression fix
  "because consistency across platforms trumps
  consistency over time"
* use C for the submodule code in Git and keep the regression fix
  "because consistency over time in Git proper is more important
  than playing nicely with Git for Windows"
* would it be possible to revert this to shell on Windows only?

> Whether bash
> on Windows removes the dot at the end of C to turn it into B, as
> long as A and B give us the same result we wouldn't be hitting the
> problem, no?

Well in Git proper A,B are the same and C is different.
(B was fixed as a regression)
In Windows C is like B, which was different without the regression
fix, but now it is the same as A, too.

>
>>> >  test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
>>> >  test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
>>> > -test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
>>> > +test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."
>
>>> > The reasons this is ugly: we specifically test for *Unixy* paths when we
>>> > use $PWD, as opposed to *Windowsy* paths when using $(pwd).
>
> Just to ensure I am following this correctly, two tests that come
> before the one you are touching above have $PWD on the input side
> and $(pwd) on the expectation side.  That is what you mean by the
> next paragraph, right?  They want to make sure that you honor the
> Unixy user input on Windows and still produce Windowsy result, that
> is.
>
>>> > We do this to
>>> > ensure a certain level of confidence that running things such as
>>> >
>>> >         git clone --recurse-submodules /z/project/.
>>> >
>>> > work. And now that does not work anymore.
>
> And I agree from that point of view that having to spell both sides
> as $(pwd) would mean you are not testing that "Unixy input to
> Windowsy output" expectation, but at the same time, I think you
> would want "Windowsy input to Windowsy output" combination also does
> produce correct result, which is not tested in the three tests shown
> above.  IOW, probably you would want to test both (at least on any
> platform where $PWD and $(pwd) textually disagree) for all these
> [*1*], and the pair
>
>     "../." taken relative to "$(pwd)/." must be "$(pwd)/."
>     "../." taken relative to "$PWD/." must be "$(pwd)/."
>
> test, because of the limitation of your bash, cannot have the latter
> half of the pair, so you'd need to comment it out with in-code
> explanation, perhaps?  IOW something along the lines of...
>
>  -- >8 -- snip -- >8 --
>
> test_submodule_relative_url "(null)" "$(pwd)/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
> test_submodule_relative_url "(null)" "$(pwd)/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
> test_submodule_relative_url "(null)" "$(pwd)/." "../." "$(pwd)/."
>
> if test_have_prereq MINGW
> then
>
> test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
> test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
> # This does not work correctly because Win-Bash strips . at the end
> # "of $PWD/."
> # test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
>
> fi
>
>  -- >8 -- snip -- >8 --
>
> In any case, I find it more disturbing that we somehow ended up with
> a system where these three things are expected to behave differently:
>
>         A - path/to/dir
>         B - path/to/dir/
>         C - path/to/dir/.
>
> Is that something we can fix?

Well A, B are the same.
C is "obviously" different, when it comes to counting slashes for relative
path/url purposes, in the way that there are characters after the last slash
and just by coincidence '.' refers to the directory itself, C behaving like
'path/to/dir/sub' seems right to me.

So how do you imagine this fix going forward?
* Breaking existing users with /. at the end? by treating it the same as A,B
* Do some check based on time/version of Git and cover the old data?
* Forbid /. at the end from now on?

>
>
> [Footnote]
>
> *1* It is tempting to update the above test sequence using
>     a helper like:
>
>     tsru () {
>         test_submodule_relative_url "(null)" "$(pwd)/$1" "$2" "$(pwd)/$3"
>         if test_have_prereq MINGW
>         then
>             test_submodule_relative_url "(null)" "$PWD/$1" "$2" "$(pwd)/$3"
>         fi
>     }
>
>     then write the above three tests like so:
>
>         tsru subsuper_update_r ../subsubsuper_update_r subsubsuper_update_r
>         tsru super_update_r2 ../subsuper_update_r subsuper_update_r
>         tsru . ../. .
>
>     but you would want to disable the MINGW half for only the third
>     test, we cannot quite do that.
