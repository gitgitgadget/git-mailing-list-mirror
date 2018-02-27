Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE0F1F576
	for <e@80x24.org>; Tue, 27 Feb 2018 08:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeB0IK6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 03:10:58 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39238 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeB0IK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 03:10:58 -0500
Received: by mail-ot0-f194.google.com with SMTP id h8so3007238oti.6
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vLTll24LHLYu3hFFEpLzu/+U6EVqBonGM1VaPyyzrgQ=;
        b=PoiJiDZ1x69usOMw+oj/4Y3Y8I+gVQcajZ9pdYRcp2YdyPSejAcWMUKi4WyK6fNfrU
         yO8ponZRZjCnVcaNylhn9dhnBScE76LRwCrIrkVYFgyU4okwt5BPi7cr5URiRD4OZ/p9
         6w67q5XQFPRZP3TsfcQG5ItCwHQmM/J50FCfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vLTll24LHLYu3hFFEpLzu/+U6EVqBonGM1VaPyyzrgQ=;
        b=uD2d/uZwn+g2M4tClo/FLRohAqMQD+Kq8O0h902BTZKNUVvLjQplE4HWEvj3CETNAg
         6xkBK4jYYA7tGoPqRm8VtGSytlTF9PBJ79rmNsRybnGTJ2YzI0f/KTPxgi4HjzBjRAOO
         1+BKzIX6yQyQwS5i9weBjvYTol87MUsgn+c3wEvh993FsY620HlZOXToJWRBsW+bYcM8
         V/lglP8b60XnUE2ILkJLD2oa8AZXLXRtEgQ1F7vOwjEPOhhlYth1OfCB80PsUjzur9Y8
         nd1K2xgEwPS+IGjUx4CLUuu3ObsnWs7AAiaZwgnXJxioS0qX8duPwlqdOVnqpTwg+qWc
         wwWg==
X-Gm-Message-State: APf1xPA2afCt7TSSp15ZILfdSARnKa3ukKeH6K4m/TgYTy162Wgm5nsc
        4OaRoFv9P1we/yLdovy8xfpZsbSIKRVrUfnpAtEXzg==
X-Google-Smtp-Source: AG47ELuA2hwH5OVoCo5T4xIHEbjBQH9lQgjM+DYpNbE7n6NR1D809ynoFr4LZODoeVFfNBk6YrxzQHTswktrgKV2wy8=
X-Received: by 10.157.87.121 with SMTP id x54mr9234983oti.289.1519719057299;
 Tue, 27 Feb 2018 00:10:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.52.146 with HTTP; Tue, 27 Feb 2018 00:10:56 -0800 (PST)
In-Reply-To: <01020161d57a3c14-1177a79b-cc21-4d78-8bbd-b6650f7a6169-000000@eu-west-1.amazonses.com>
References: <01020161d57a3c14-1177a79b-cc21-4d78-8bbd-b6650f7a6169-000000@eu-west-1.amazonses.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 27 Feb 2018 08:10:56 +0000
Message-ID: <CAE5ih7-Uyk3fG3LXh2qnfEF1hV+n1wWexUcZ8SJ3=wKWgn4o6Q@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Fix depot path stripping
To:     Nuno Subtil <subtil@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 February 2018 at 04:16, Nuno Subtil <subtil@gmail.com> wrote:
> When useClientSpec=true, stripping of P4 depot paths doesn't happen
> correctly on sync. Modifies stripRepoPath to handle this case better.

Can you give an example of how this shows up? I could quickly write a
test case for this if I knew what was going on.

Thanks
Luke


>
> Signed-off-by: Nuno Subtil <subtil@gmail.com>
> ---
>  git-p4.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 7bb9cadc69738..3df95d0fd1d83 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2480,7 +2480,7 @@ def stripRepoPath(self, path, prefixes):
>                      if path.startswith(b + "/"):
>                          path = path[len(b)+1:]
>
> -        elif self.keepRepoPath:
> +        if self.keepRepoPath:
>              # Preserve everything in relative path name except leading
>              # //depot/; just look at first prefix as they all should
>              # be in the same depot.
> @@ -2490,6 +2490,12 @@ def stripRepoPath(self, path, prefixes):
>
>          else:
>              for p in prefixes:
> +               if self.useClientSpec and not self.keepRepoPath:
> +                    # when useClientSpec is false, the prefix will contain the depot name but the path will not
> +                    # extract the depot name and add it to the path so the match below will do the right thing
> +                    depot = re.sub("^(//[^/]+/).*", r'\1', p)
> +                    path = depot + path
> +
>                  if p4PathStartsWith(path, p):
>                      path = path[len(p):]
>                      break
> @@ -2526,8 +2532,8 @@ def splitFilesIntoBranches(self, commit):
>              # go in a p4 client
>              if self.useClientSpec:
>                  relPath = self.clientSpecDirs.map_in_client(path)
> -            else:
> -                relPath = self.stripRepoPath(path, self.depotPaths)
> +
> +            relPath = self.stripRepoPath(path, self.depotPaths)
>
>              for branch in self.knownBranches.keys():
>                  # add a trailing slash so that a commit into qt/4.2foo
>
> --
> https://github.com/git/git/pull/463
