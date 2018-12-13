Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC34520A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 00:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeLNAFz (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 19:05:55 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:37467 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeLNAFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 19:05:54 -0500
Received: by mail-ed1-f41.google.com with SMTP id h15so3545864edb.4
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 16:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKh1mSRYmZT838TswEMbw8YsvNu1pbCbNm4GGfRxN7s=;
        b=ekfPpo0uAffDQ4vOE/EOR2tgbSJXaSgLo+45GnVtPuhV6562LW/dhgiEoP7zuWPAdT
         rJxY4F3g91I1TFiVn5HuNrTCtcFPzVd4VsHV4Xp3HUjIjWCA83tFthhHcAfg4aB1vIE/
         /H0MiK2Yyi6t3CU/KTNhLS+wcwyz9P7mDcl0Y0kwZwlag3sY3diVov2ojoCDUz1hRvoS
         KMfJh9BPZQINv01kkmHurdLn3I65A21TlgevAqgkPisvFpLNMY3DvZLE8g8fHaZ5pmw6
         qOyibGx5QiXr+65zj41ACkZICHT+MHbRvPRDdgBlAAdqYqPKuCDAlhdu1dSRbeKqjIoP
         EZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKh1mSRYmZT838TswEMbw8YsvNu1pbCbNm4GGfRxN7s=;
        b=Kdx1z7ilXpPxy1LvJOWb7YzV4rd0gL1Pjys8AHXdH6dcxvRF87C6fQLvZbFXuDhy4n
         EkmCbmfT6hrO0DOf9LY9hTFacMMJBrZOFydwwhOx8wj9xyp8nNX53T6k/ioVOzTKaXWz
         ZFZmfTVDV4hmj0yviRhJNgPu7HszYxAJZsmIZOvlEzeOAAslIQtq+Nww2Wtkfw0Q0tk9
         1LQZSrOXGKRjKg0yBDp1Xf2O8qNSZ6bCgEvpvrHPQ6rnF6N7qGHeJD+tK9d0s59ustAp
         xt/lqSh4xC/vdgv5YYgyYNbPQuX1RqjwJ+is9NZEcySGvarBfAbN717wyyPq0uob+Nlj
         9Y0Q==
X-Gm-Message-State: AA+aEWYHhS97zUC5YwO8+jU2+aOcRMpBjFAOI7CG42kQr0BgbbmPC5Za
        BYfcK9+a52tejLYO+N1VhJtt3XjfLyJ+V3DcsDRXsQ==
X-Google-Smtp-Source: AFSGD/WuL0MoZ+m1iy42LG67avUIoMPMWGjBno82WiOpDOumCytJ4ui7aKLnHNT2L5ZVcvM7MTM6B4/1vexkbZaI/Kk=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr998788edy.231.1544745543031;
 Thu, 13 Dec 2018 15:59:03 -0800 (PST)
MIME-Version: 1.0
References: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
 <20181211040839.17472-1-debian@onerussian.com> <20181211040839.17472-2-debian@onerussian.com>
 <CAGZ79kY17gmEh5Sawa+1fG5cXjOReOgCjDyEmGbbpJ5EE1APdw@mail.gmail.com>
 <20181213164217.GA4633@hopa.kiewit.dartmouth.edu> <CAGZ79kZb28bCvM7cOYHC4cpJWpA-3_gcbxS_g-rG0yy=9jXquw@mail.gmail.com>
 <20181213224356.GI4633@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181213224356.GI4633@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Dec 2018 15:58:51 -0800
Message-ID: <CAGZ79kaLpMa+AYwtNh+HUkYk3ORDephxZ74hcTbS=z1CQ+bf6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule
 status --recursive to stay intact
To:     debian@onerussian.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 2:44 PM Yaroslav O Halchenko
<debian@onerussian.com> wrote:
>
>
> On Thu, 13 Dec 2018, Stefan Beller wrote:
>
> > > and kaboom -- we have a new test.  If we decide to test more -- just tune up
> > > test_expect_unchanged_submodule_status and done -- all the tests remain
> > > sufficiently prescribed.
>
> > > What do you think?
>
> > That is pretty cool. Maybe my gut reaction on the previous patch
> > also had to do with the numbers, i.e. having 2 extra function for
> > only having 2 tests more legible. A framework is definitely better
> > once we have more tests.
>
> cool, thanks for the feedback - I will then try to make it happen
>
> quick one (so when I get to it I know):  should I replicate all those
> tests you have for other update strategies? (treating of config
> specifications etc)

If there is a sensible way to do so?
I have the impression that there are enough differences, that it
may not be possible to replicate all tests meaningfully from the
other modes.

> There is no easy way to parametrize them somehow?

There is t/lib-submodule-update.sh, which brings this to
an extreme, as it makes a "test suite in a test suite"; and I would
not follow that example for this change.

> ;)    In Python world I might have mocked the actual underlying call to
> update, to see what option it would be getting and assure that it is the
> one I specified via config, and then sweepped through all of them
> to make sure nothing interim changes it.  Just wondering if may be
> something like that exists in git's tests support.

gits tests are very heavy on end to end testing, i.e. run a whole command
and observe its output. This makes our command setup code, (i.e. finding
the repository, parsing options, reading possible config, etc) a really well
exercised code path. ;-)

There is a recent push towards testing only units, most of
t/helper is used for that, e.g. c.f. 4c7bb45269 (test-reach:
test get_reachable_subset, 2018-11-02).

So if you have a good idea how to focus the submodule
tests more on the (new) unit that you add, that would be cool.

> BTW - sorry if RTFM and unrelated, is there  a way to
>
>     update --merge
>
> but allowing only  fast-forwards?  My use case is collection of this
> submodules: http://datasets.datalad.org/?dir=/openneuro  which all
> should come from github and I should not have any changes of my own.

So you want the merge option  --ff-only
to be passed to the submodule merge command. I guess you could make
a patch, that update takes another option (--ff-only, only useful when
--merge is given), which is then propagated.

I am not sure if we could have a more generalized option passing,
which would allow to pass any option (for its respective command)
to the command that is run in the update mode.

> Sure thing if all is clean etc, merge should result in fast-forward.  I
> just do not want to miss a case where there was some (temporary?) "dirt"
> which I forgot to reset and it would then get merged etc.

maybe use --rebase, such that your potential change would bubble
up and possibly produce a merge conflict?
