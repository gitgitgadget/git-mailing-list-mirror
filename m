Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3346BC25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 09:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348082AbiHSJRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiHSJRR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 05:17:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CCFF2D61
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660900631;
        bh=U6b57hz7fDPP2Ofe3lxEQX24grFXDyD+J7Dm7FYQV30=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XtAv1qfwU/G9SXDDv+8c8WiMqYpNsMuKzj8d+d0rFlCLZ9hgl7eWKhLbWBcdcUoB2
         saXtEXqdj3jcmwHqmz0JpmJvcLJ46g2OynghFYum2EvxWl/4DmJIz4hJmm3v/D4LP0
         XoPNZeu+hK30qfdc6BqMsYILAgl2c6nHij0CKouI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1oCdGU0yLd-00CPHL; Fri, 19
 Aug 2022 11:17:11 +0200
Date:   Fri, 19 Aug 2022 11:17:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] merge-tree -z: always show the original file name
 first
In-Reply-To: <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com>
Message-ID: <44pr310n-rpr1-0660-0961-386rsq9q11o1@tzk.qr>
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com> <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LIEUU4C6oBidN5P4yuV5ycKn3b1WrXwgU/AppuimaNbnGMc8f7V
 scY5JG2PdNHIIIkZtdatajld5Ln5d7t/eg/PdgshWcKD813YZoBSD645O4KCUrDwqFiQDx3
 bBl6lRs01+jV5YerIKVaXexKUFNlgRWqq9Fc0HhTnO2bZLksq8x2/ya920kqzW05OAV+vm4
 axbqBZjYr92gDjCf2BJ/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2QEA5zN/nGE=:RZaQgiMCW0aSMKV72fbaTY
 UMY6QERTiHrRq4/m5C0ujIUtN+iGKuyihVuv3Dc5g17mEsrLqS3QmAQs5KLbu74UEotZ8eFxH
 2yP72Cpr/dHzHolXC1T1D2vOzCLqm4NQYCG/AV9po8ag5/gvdXqQH8Msrek1MvXNeCeRJPHoW
 hixfXPuVbCOr7B3pdSmpdNmrkNADplJRtA4jAKS01t8zrclN7DD4+q/4zWQx4EtWEj6VIgbTj
 RmsobOiAL/oi6jZNEUv3PLB6mFqhOq9jIsJndQDLCWVh5QLcIJ6WvlrJEGLWs3PMqA4cbcJjV
 Vtk18vFcz8XSHCpD4g0UjN2vRV9hLafXoHlVb13j/TGbOW6w8+MxdJuKKKqmIBL/LUo10xRiY
 AcQlHvKQTS/xUsO8qujxbILfSU3V7T5lRao1ZxwQw2CJmPk/LJCAqVZbjWM2Rb/xwpgAHXGsU
 Q4XEflj6vzIyoL5UB3/QG1mZYlk8yJbclCCXuKoatu3Rs8JncI3k6S76OJ/juSXe16smhH0+3
 5CQlDnFvFJM3extw8zkf/yT2JeJYjsNZaaBSenrfsDj2VjnqEP5oXcz9lz4sL2SRJ/umg2FNE
 74rPmGLX+KUppKl1asgkGFQOFrf821EiDesg+Y1QwH2kmSiayyxWobeXqvmtBroOpZZMyN017
 vgDciulcU8HMaWz9g+KHJ/qQvVYbRdfhAZRZ2KFC4+JgjuopHhhD8eu6Z7h0+HaVMEpAZaCd8
 7r+QTi9zvEDs9s5BNjW59BcBl04uko8E/c9fcY5ujxCVYSs+Oxrxm5LeyUQTvkmHZqQQlxF2+
 zsQ5LmpP0KYmVK9p7eRvTq3Z3qAK9+yHrHGPCIR4+JQDEGkTEhETq8YCCeRkg/2lyfqftmIrs
 AmE/BixO58jwZfjQzZ91SleQxDcsDThj9QfUDsp5c3Qi0ZxfxuoMOCs3KJX6zaj47Auo9KsqH
 cnCMqFByHag+TcX6K5YzEFy7fnq2es4SJYlGVJa1WxrjlrHZcaKMkO9jjF0IwLV0SweB3rPaJ
 7cSSjwJqT+dfyVNwZrtxFVeIFhhgSxudvwJDdI1my1BXNcB01UW3Y9815qIXoj80YxjNPJdaN
 vhmNeJenT1T3eulmbzHBlcnB6Mo3543HNrubb4bJAMaksuKG+CY4rqYOw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all (and I guess in particular Elijah),

On Fri, 19 Aug 2022, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> index 35f94957fce..bc580a242ac 100755
> --- a/t/t4069-remerge-diff.sh
> +++ b/t/t4069-remerge-diff.sh
> @@ -131,11 +131,12 @@ test_expect_success 'setup non-content conflicts' '
>  test_expect_success 'remerge-diff with non-content conflicts' '
>  	git log -1 --oneline resolution >tmp &&
>  	cat <<-EOF >>tmp &&
> +	diff --git a/file_or_directory b/file_or_directory
> +	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
>  	diff --git a/file_or_directory~HASH (side1) b/wanted_content
>  	similarity index 100%
>  	rename from file_or_directory~HASH (side1)
>  	rename to wanted_content
> -	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
>  	diff --git a/letters b/letters
>  	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
>  	diff --git a/letters_side2 b/letters_side2

I would have liked to avoid touching this file altogether, of course, but
when I investigated, I came to the conclusion that while this patch still
does not produce the best possible outcome for remerge diffs, it does
improve upon the current situation.

The thing is, when mentioning that we had to rename `file_or_directory` to
`file_or_directory~HASH (side1)` to be able to write the file because a
directory of the same name already was in the way, I would actually have
expected this to come under the diff header

	diff --git a/file_or_directory b/file_or_directory~HASH (side1)

Previously, it was under the header

	diff --git a/file_or_directory~HASH (side1) b/wanted_content

and with this patch it is under

	diff --git a/file_or_directory b/file_or_directory

which is still not ideal: It mentions only the original file name, not the
munged one.

When I looked into the implementation details I figured out that the
information is not quite at our fingertips. In
[`create_filepairs_for_header_only_notifications()`][create_filepairs], we
have access to the primary filename (in the above example,
`file_or_directory`) as the key of the entry in the strmap
`o->additional_path_headers`, which is [populated from
`path_messages`][additional-headers], which in turn [points to the
`conflicts` strmap][path_messages]. Note: this code has changed between
v2.37.2 and the current main branch, in v2.37.2 the information is still
copied from `conflicts` to `path_messages`.

So basically, when we generate that diff header, we know the primary path
(great!) and we have access to a strmap that points to a string list of
conflict messages. So from where do we get that munged path name? The
string list of conflict messages [has `util` pointers to `struct
logical_conflict_info` data][conflicts-strmap], which does contain the
list of involved paths. This should be enough, right? But:

- `struct logical_conflict_info` is declared locally in `merge-ort.c`, we
  do not have access to that information in `diff.c` (nor would we really
  _want_ to let that `merge-ort` implementation detail spill over into
  `diff.c`), and even if we _could_ declare it in `merge-ort.h`, there is
  still this problem:

- The path list in `struct logical_conflict_info` is arbitrary-sized, i.e.
  we could even have _three_ paths in there, and that does not fit into a
  standard diff header.

- Additionally, we generate _one_ diff header for _all_ of the conflict
  messages listed for a particular primary path in
  `additional_path_headers`. But each of these conflict messages relates
  to its very own list of non-primary paths. For example, one conflict
  message could talk about a file/directory conflict, another one could
  talk about conflicting renames to two different filenames (in a
  recursive merge, both is possible in the same merge). It is simply
  impossible to combine all of those conflict messages under a single
  diff header that matches all of the involved paths.

- Even aside from that, the remerge diff code seems to have a usability
  wart (or even bug) where restricting the diff via a pathspec that
  matches a secondary path but not the primary path of a conflict (think:
  renames) would _not_ show the conflict message to the user, it would be
  shown only if the pathspec also includes the primary path.

In general, I found it hard to think of a _really_ ideal design where to
present that remerge conflict information. After all, in a remerge diff,
we do not even write out any files, therefore that conflict message
suggesting that we renamed the file to a munged name is somewhat
misleading. Sure, we should mention the conflict between the file and the
directory, but since nothing was written to disk, there is not actually
any _need_ to mention a munged filename at all. And that goes even for the
part of the remerge diff shown in the patch quoted above, where it talks
about `file_or_directory~HASH (side1)` being renamed... That file never
had that filename...

So I am not quite sure where we want the remerge design to go from here.

In any case, this remerge aspect is safely outside the scope of this here
patch series, which means that this here patch series should not be
concerned with it. In this email, I just wanted to mention _why_ I did not
include any patch to address the remerge issues any further.

Ciao,
Dscho

[create_filepairs]: https://github.com/git/git/blob/v2.37.2/diff.c#L6337-L6383
[additional-headers]: https://github.com/git/git/blob/v2.37.2/log-tree.c#L992
[path_messages]: https://github.com/git/git/blob/795ea8776be/merge-ort.c#L4846
[conflicts-strmap]: https://github.com/git/git/blob/795ea8776be/merge-ort.c#L351-L360
