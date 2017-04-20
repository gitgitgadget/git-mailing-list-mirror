Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D660207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947701AbdDTVDu (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:03:50 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36601 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947028AbdDTVDt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:03:49 -0400
Received: by mail-lf0-f54.google.com with SMTP id c80so35473893lfh.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=swzAyj/a5EqHZxW9wnPJOKV5YFOo4y1QHEiyrw1QQNQ=;
        b=Cd94deYKwUSgGfjN82DyTn6kN8cbZZYCyAakMBwUCwJYVa4DiLkG6MER8SxJmsBYQb
         G8tRNCA1kQpQ484N6Nt1AOMJVUpsEST1KF8HLlNfJmuc0v1UrAxjjYW744UuAgUQ4BSH
         8EAvm43lcK879J8EzKmTvP5P3FLAerHYtg5Bz5QxHpeFWyi58gW8Ogb7NYd6o+9igr1F
         MDMKu6n8nehMWSqQ8lSBYdgZ+Fj9cup7BLC73gxkw5UU4453VYMCmzHmEkuOuyPiKPRS
         PS4byxXKVq+fatD6ZuUXdKsAtSWZSv4VZ1W0nA12QK+WXB4yZ1F9S8e49be9t0mTl0IU
         6F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=swzAyj/a5EqHZxW9wnPJOKV5YFOo4y1QHEiyrw1QQNQ=;
        b=Z9cbDjQEegtCJFtlyp2gzrNb1VYDc/+/eAHgywDigRASOnwhfcH3MrOijE3e1BJOhi
         OKLmJ40VAWXZjKuOQFxg5o9PpJ52ha+xtCkKqPKCoPl5F1QuKA8UJJ0SAVt+VxY4Y5k0
         6w+ou/ngeZu7nsOveKXCuV3bOtUtLw+orS9lv2o3uu6D5f7kIoBATe2bRnunujnNLs5d
         UIAtCNGLXls6cHxsPFIrA0A8ujOCpyLHHI6PmFUENBc8Sp00oDn1MNUD767jpTRc27AQ
         Wh9mArLxOA3FxnoEwE9HyP01Sit/9kL3ZVvC0nS+togXPCh8MTaSNbId9dKudenzOPmz
         3nTg==
X-Gm-Message-State: AN3rC/50GBy/YGIVtbX3uZldjpxaXB10n9DUKuU0zDcsqOHV0X5Vj5bK
        A5npsJIYsDQ/CZtuheiowQ0a2mdcww==
X-Received: by 10.25.56.21 with SMTP id f21mr3316640lfa.154.1492722227329;
 Thu, 20 Apr 2017 14:03:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Thu, 20 Apr 2017 14:03:46 -0700 (PDT)
In-Reply-To: <20170420205214.GB4989@hank>
References: <20170420205214.GB4989@hank>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 20 Apr 2017 23:03:46 +0200
Message-ID: <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Apr 20, 2017 at 10:52 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Hi,
>
> I just tried to run the test suite with GIT_TEST_SPLIT_INDEX=YesPlease
> and noticed that a few tests are broken both in pu and master.
>
> Below the test failures on master:
>
> Test Summary Report
> -------------------
> t7009-filter-branch-null-sha1.sh                 (Wstat: 256 Tests: 5 Failed: 2)
>   Failed tests:  4-5
>   Non-zero exit status: 1
> t3900-i18n-commit.sh                             (Wstat: 256 Tests: 34 Failed: 1)
>   Failed test:  34
>   Non-zero exit status: 1
> t5407-post-rewrite-hook.sh                       (Wstat: 256 Tests: 14 Failed: 4)
>   Failed tests:  11-14
>   Non-zero exit status: 1
> t3415-rebase-autosquash.sh                       (Wstat: 256 Tests: 19 Failed: 15)
>   Failed tests:  4-17, 19
>   Non-zero exit status: 1
> t3404-rebase-interactive.sh                      (Wstat: 256 Tests: 95 Failed: 54)
>   Failed tests:  18, 20, 22-24, 26-43, 45, 47-74, 84-85
>   Non-zero exit status: 1
>
> Bisecting between master and v2.10.0 leads me to the merge commit
> 94c9b5af70 ("Merge branch 'cc/split-index-config'", 2017-03-17).
>
> Unfortunately I don't forsee myself having time to track the bug down
> soon.  Sorry for not noticing this earlier in the cycle.
>
> The bisect log is below if someone finds it helpful:
>
> git bisect start
> # bad: [6a2c2f8d34fa1e8f3bb85d159d354810ed63692e] Git 2.13-rc0
> git bisect bad 6a2c2f8d34fa1e8f3bb85d159d354810ed63692e
> # good: [6ebdac1bab966b720d776aa43ca188fe378b1f4b] Git 2.10
> git bisect good 6ebdac1bab966b720d776aa43ca188fe378b1f4b
> # good: [733671b0fd2fb03edb05273f36ec70bd624e544f] Merge branch 'maint'
> git bisect good 733671b0fd2fb03edb05273f36ec70bd624e544f
> # good: [04b4f7d579056cedaae2de0a019e5993b4d9c2d0] Merge branch 'sb/submodule-update-initial-runs-custom-script' into maint
> git bisect good 04b4f7d579056cedaae2de0a019e5993b4d9c2d0
> # bad: [af6865a7f1e1d915d3b63e998226028ca4abb6ee] submodule.c: convert is_submodule_modified to use strbuf_getwholeline
> git bisect bad af6865a7f1e1d915d3b63e998226028ca4abb6ee
> # good: [3f7ebc6ece46f1c23480d094688b8b5f24eb345c] Merge branch 'jk/tempfile-ferror-fclose-confusion'
> git bisect good 3f7ebc6ece46f1c23480d094688b8b5f24eb345c
> # bad: [94c9b5af703eb70adba349cfbfaaa3029849744c] Merge branch 'cc/split-index-config'
> git bisect bad 94c9b5af703eb70adba349cfbfaaa3029849744c
> # good: [36d5286f6815542761dae92fdcdce8db1556727f] Merge branch 'ax/line-log-range-merge-fix'
> git bisect good 36d5286f6815542761dae92fdcdce8db1556727f
> # good: [c3a008250272295271584c6303463ffb9b055cbc] read-cache: use freshen_shared_index() in read_index_from()
> git bisect good c3a008250272295271584c6303463ffb9b055cbc
> # good: [228b78752de9d759839665764391262c0ec156cf] Merge branch 'jt/perf-updates'
> git bisect good 228b78752de9d759839665764391262c0ec156cf
> # good: [073778017158ecf3153b050776029907bc75826f] Merge branch 'kn/ref-filter-branch-list'
> git bisect good 073778017158ecf3153b050776029907bc75826f
> # good: [b46013950aff31b6626af96ccbf2c48469e36c66] Documentation/git-update-index: explain splitIndex.*
> git bisect good b46013950aff31b6626af96ccbf2c48469e36c66
> # good: [32c43f595f93cdd4ed5305aef97a3f6aaa74ed72] Sync with 'maint'
> git bisect good 32c43f595f93cdd4ed5305aef97a3f6aaa74ed72
> # first bad commit: [94c9b5af703eb70adba349cfbfaaa3029849744c] Merge branch 'cc/split-index-config'

Could you try with the following patch:

http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/

Thanks,
Christian.
