Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057D43C067
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319190; cv=pass; b=SXX+EjNvFBg/JJJpT4b9iNWpefVPhyWdj6fE9IZIAgAZdtJOehcYCVQp0hQLuIDA3YgnzpyQGgOsgsAbfNLhY9s/+m6nOzoIJPWVb5KC2/azyyl89A3QrKDfzUwLbzfYJK6I8lYT+yDc0GhuaAuYYWBJ8ggGtSGwWMpw7DMDvR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319190; c=relaxed/simple;
	bh=M8vDBm/XzAmvhXzuJ3OlLEKsDfd6qdqhRhmmBAvRukc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSwodM7uuJ93pXcUjF8TS71NeqkK1knVPWVkpm82h3wgNyDAyyeKUcn5KdGKu2AJkpiO0pu2OJ9fyLFMarb1NuD8eEumCCTxW2aV1z1usDcFxz8vegbhfktrOuLEvJIf/UhTy926KNh8+RfsIexcT6X8mw2Y0qYsXdXT4SFa1Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEwxIYvj; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEwxIYvj"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69ffb48d599so1149483a12.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 02:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785319186; cv=none;
        d=google.com; s=arc-20260327;
        b=XLO4Yik2RSWNqAgxSls+U7QD5g2KtVX4/bMFqlvk3sNfh8olp7ycXQmxqQHWXJ6j3c
         EK7Xh8EyDqmY7/ot7wOIxLpzKKy2hY5n2hienvlDntKZG1Ta025pNSY0slVjaWXNgc3x
         9F2abceFD/9P0Xd9R/5A9Gz2AbfXWPfekCsWr8pQzgREP15JUjW2PsVtMV9+gMQGeN7N
         kXrs3CSght7LFa3LDDU/uWSexoQYYKNE34cwDm1udf7iHLFt/QbMY+3g9x6/k0P39WF+
         ffDtrHzDqg3O9Mo47YWSgzKkRBkyDa/Uremud7IGzWtgHPw+xa31gxxO1/1Xp+Mzqqfd
         fa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F711l2ClFWBhGVb18rwSKOzjmCIrk7bnrqrsz7icxqM=;
        fh=2aAxuZ3FwNf3QcFlH2RvBEmGPgSA32B5xuUzbfpQbOg=;
        b=KGK85pbBvNzKMI/x9/k85PG7CdExBDlthWeTH3WX5UFHwjvLHKYdPq/pWWJIlo7dHH
         HNwT2EUvwwrFiVMOtCW341R0ZzyX9Aq7b0BdQrDtTUST53epxemWwgWwCl/ZCRvfkGyS
         Nu91y3g6dZEB9iVP6gDKU/NsEGhfBHEm/05uxTSfe2oehn8vjffauo0bSzKbH9v0/A6E
         ruygVGcVD2FcCkjfw1wCbvtuO6KLHET1As0608ZmMOLUs2l6K1MIMFZiEwBRIG+nxm3e
         zsk3o+ziP6b6PqHGWeWWQA2wYfnEeu/71uG64GqCwjVKPbWUwNqR23CZPJMWN1sbSpV6
         Y2ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785319186; x=1785923986; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F711l2ClFWBhGVb18rwSKOzjmCIrk7bnrqrsz7icxqM=;
        b=PEwxIYvj8K4KAEzb1YvBaAzUIxcSTSuCi1FlzHzNZuyhpzgTOVtknTrq3aLz4iL1me
         YzwOMGSCv+zf3iuhmevKNZXg2JGTN7bUA9egcZ5V50taUL2Mxla0Zb0VxVuLtPZ/Gogv
         vbiS8pJ7qYciR7414t4j8IU9F24qtqbEZcHUKxkihAZKXYS80/a5Q3/ed7NvLsS4/qWT
         XowVaJ5djE2qlkzgonKO34APmHPE8qSaLftKG+yLc5A5bgCrp0Uuz+U6F7rzNH3xRR1Y
         L+b2hyvxhDGoKcgxnNAC+lA4MF4TsFgl+0KpZjZHjhfo3SGBWn98BBqZKeMoooXYdGAq
         ZP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785319186; x=1785923986;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F711l2ClFWBhGVb18rwSKOzjmCIrk7bnrqrsz7icxqM=;
        b=Q421ZyNPJHikX1wSnrkALOzWHdb8EYSNnk5dmP91Fcr84m29EtbjPcdFoeQH3rqINj
         R7w2//OOmtDZQUMj2XbeBNADY22dl5T1iNlbvE/SXfefoN27YO0EH7ST49vNa2BxsTTy
         irF2vKtaWmvGBUc36IcNLSuJS6DpmsZcPVwujHe59eoPhkzHzeELNaumnIEODLFPgqhN
         GmPg46DnTSIInKZu0m4DU97fXTReCZCBetvHBSYvOLlHIR0qaUwu7TdpV4usUIHRQ1L8
         bVQINcJ220t79hnFJUtkK+OSmDbzNdKh1dMaUnKMw465/VtCs5ndC07eReAdCgu0dUyw
         UGVw==
X-Gm-Message-State: AOJu0YxxZbE/VwoxYMk0FN9TtaauYolEmuorgVzDY0v/Yn5c4VPvdgoW
	uxPJtCN07hVA3Cs7BenO9gxAo1iLqZ775L1Ce18D4Ffc1UxAthZ3CiUCl6milKMHCjq4kWbAJmo
	XrBFcw74Trn+ZvEc7x57ExZMqHn9te5M=
X-Gm-Gg: AR+sD133nEJ84E002xk8E8/a185KTbPjsJJw8IYXdeCk0VW1QNL9vV0m4q+DC50txRt
	I39HM8rwaEjiCfd/MQ2Tr98rbdIoMkWhfcOdgD78hVLnImrwhN/VmUdj59d5Ji0kl6bjkLmh1aN
	l8E6Y3NMUKk3jPnIo9x/Inj+hkFAujGpRg3pPV06/yQAn4wwjWAC/Sa6qpJ/Y4t7ZRjvlV7/2+Y
	Np/Z1ZqAO0rKKmwZOyngOOGNtzT3UfZQTSPwdLiOox4lv4DSuxm6luZrmmsBIOyhUfLEpHAjzAd
	WCf2lhmFB1+OVMQ+j+XGJp5ggPs38/PNiHrTqH2VfcAlI1tl8vnks1nPPJWBEuCAkQf5dMucRoE
	SpZf37q5bVhs0npX/cxZmsxYjyZo0RYQDQEMJEaKUnCerraXf/GjxH6TLhwQ9cnCUZ+Qw
X-Received: by 2002:a05:6402:c50:b0:698:9e5e:5df8 with SMTP id
 4fb4d7f45d1cf-6a0349eaa97mr2943931a12.7.1785319186200; Wed, 29 Jul 2026
 02:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com> <20260725-objecttype-support-v1-5-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-5-2d4ca3bbabf1@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 29 Jul 2026 15:29:19 +0530
X-Gm-Features: AUfX_mxl7J6IrF9kUazoiTY8R7lWpBtPNInZrD4Xm54is4Zeka0TtEv9uT_wOW4
Message-ID: <CA+J6zkQAAkeM67+yJGLG7z9+TV0sJ2cZp-dV+xCJn2c4V9wVJQ@mail.gmail.com>
Subject: Re: [PATCH GSoC 5/5] cat-file: unify default format
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> %(objecttype) is supported both by the client and by the server.
> Change the temporary default format to the unified version that other
> commands use.

s/other/the other

> Update documentation to remove %(objecttype) from the caveats of
> remote-object-info.
>
> Update tests that used the default format to expect type.

Not super accurate. We're updating the tests to expect the new default
format.

> Update documentation to show %(objecttype) support.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  Documentation/git-cat-file.adoc        | 17 ++++-----
>  Documentation/gitprotocol-v2.adoc      | 15 ++++++--
>  builtin/cat-file.c                     |  7 ----
>  t/t1017-cat-file-remote-object-info.sh | 70 ++++++++++++----------------------
>  4 files changed, 42 insertions(+), 67 deletions(-)
>
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index ac3b528c6f..514bfc0032 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -348,15 +348,12 @@ newline. The available atoms are:
>         after that first run of whitespace (i.e., the "rest" of the
>         line) are output in place of the `%(rest)` atom.
>
> -The command `remote-object-info` only supports the `%(objectname)` and
> -`%(objectsize)` placeholders. See `CAVEATS` below for more information.
> +The command `remote-object-info` only supports the `%(objectname)`,
> +`%(objectsize)` and `%(objecttype)` placeholders. See `CAVEATS` below for more
> +information.
>
>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`, except for `remote-object-info` commands which
> -use `%(objectname) %(objectsize)` because `%(objecttype)` is not supported yet.
> -
> -WARNING: When "%(objecttype)" is supported, the default format WILL be unified,
> -so DO NOT RELY on the current default format to stay the same!!!
> +%(objecttype) %(objectsize)`.
>
>  If `--batch` is specified, or if `--batch-command` is used with the `contents`
>  command, the object information is followed by the object contents (consisting
> @@ -453,9 +450,9 @@ scripting purposes.
>  CAVEATS
>  -------
>
> -Note that only `%(objectname)` and `%(objectsize)` are currently
> -supported by the `remote-object-info` command. Using any other placeholder in
> -the format string will return an empty string in its position.
> +Note that only `%(objectname)`, `%(objectsize)` and `%(objecttype)` are
> +currently supported by the `remote-object-info` command. Using any other
> +placeholder in the format string will return an empty string in its position.
>
>  Note that the sizes of objects on disk are reported accurately, but care
>  should be taken in drawing conclusions about which refs or objects are
> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index 7bf62014c3..de4bfb776e 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -558,14 +558,17 @@ object-info
>
>  `object-info` is the command to retrieve information about one or more objects.
>  Its main purpose is to allow a client to make decisions based on this
> -information without having to fully fetch objects. Object size is the only
> -information that is currently supported.
> +information without having to fully fetch objects. Object size and type are the
> +only information that is currently supported.

s/is currently/are currently

>  An `object-info` request takes the following arguments:
>
>         size
>         Requests size information to be returned for each listed object id.
>
> +       type
> +       Requests type information to be returned for each listed object id.
> +
>         oid <oid>
>         Indicates to the server an object which the client wants to obtain
>         information for. They must be full OIDs.
> @@ -580,11 +583,15 @@ space.
>         info = *PKT-LINE(attr LF)
>                *PKT-LINE(obj-info LF)
>
> -       attr = "size"
> +       attr = "size" | "type"
>
>         obj-size = 1*DIGIT
>
> -       obj-info = obj-id [SP [obj-size]]
> +       obj-type = "blob" | "tree" | "commit" | "tag"
> +
> +       obj-val = obj-size | obj-type
> +
> +       obj-info = obj-id [SP [obj-val *(SP obj-val)]]
>
>  If the server does not recognize the OID, the response will be `<oid> SP`
>  regardless of the number of attributes requested.
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 884b6d5ad3..8288511b19 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -841,15 +841,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
>         struct object_info *remote_object_info = NULL;
>         struct oid_array object_info_oids = OID_ARRAY_INIT;
>         struct string_list object_info_options = STRING_LIST_INIT_NODUP;
> -       const char *saved_format = opt->format;
>
>         if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
>                 die(_("remote-object-info command too long"));
> -       /*
> -        * TODO: Use the default format once %(objecttype) is supported.
> -        */
> -       if (!opt->format)
> -               opt->format = "%(objectname) %(objectsize)";
>
>         line_to_split = xstrdup(line);
>         count = split_cmdline(line_to_split, &argv);
> @@ -904,7 +898,6 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
>                 data->is_remote = 0;
>         }
>         data->skip_object_info = 0;
> -       opt->format = saved_format;
>
>         for (size_t i = 0; i < object_info_oids.nr; i++)
>                 free_object_info_contents(&remote_object_info[i]);
> diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
> index 175f778cc9..741bdf34a0 100755
> --- a/t/t1017-cat-file-remote-object-info.sh
> +++ b/t/t1017-cat-file-remote-object-info.sh
> @@ -139,10 +139,10 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
>                 set_transport_variables "$daemon_parent" &&
>                 cd "$daemon_parent/daemon_client_empty" &&
>
> -               echo "$hello_oid $hello_size" >expect &&
> -               echo "$tree_oid $tree_size" >>expect &&
> -               echo "$commit_oid $commit_size" >>expect &&
> -               echo "$tag_oid $tag_size" >>expect &&
> +               echo "$hello_oid $hello_type $hello_size" >expect &&
> +               echo "$tree_oid $tree_type $tree_size" >>expect &&
> +               echo "$commit_oid $commit_type $commit_size" >>expect &&
> +               echo "$tag_oid $tag_type $tag_size" >>expect &&
>
>                 git cat-file --batch-command >actual <<-EOF &&
>                 remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid
> @@ -152,28 +152,6 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
>         )
>  '
>
> -test_expect_success 'remote-object-info does not change the default format of info' '
> -       (
> -               set_transport_variables "$daemon_parent" &&
> -               cd "$daemon_parent/daemon_client_empty" &&
> -
> -               local_content="local object" &&
> -               local_oid=$(echo_without_newline "$local_content" | git hash-object -w --stdin) &&
> -               local_size=$(strlen "$local_content") &&
> -
> -               echo "$local_oid blob $local_size" >expect &&
> -               echo "$hello_oid $hello_size" >>expect &&
> -               echo "$local_oid blob $local_size" >>expect &&
> -
> -               git cat-file --batch-command >actual <<-EOF &&
> -               info $local_oid
> -               remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
> -               info $local_oid
> -               EOF
> -               test_cmp expect actual
> -       )
> -'
> -

I feel like deleting this test removes the only test in this file that validates
calling info and remote-object-info in the same cat-file --batch-command
session.

Instead of deleting it, we should update it. Perhaps something like this:

test "remote-object-info and info can be mixed using the unified
default format":
    // 1. Environment setup
    // 2. Prepare a local object for the 'info' command
    // 3. Construct the expected output. Since the default format is
now unified,
    // both commands should output exactly: <OID> <TYPE> <SIZE>
    // 4. Execute the batch command
    // 5. Validate
