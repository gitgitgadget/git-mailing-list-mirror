Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE77E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 01:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeBBB3E (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 20:29:04 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36753 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeBBB3C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 20:29:02 -0500
Received: by mail-qt0-f178.google.com with SMTP id z11so29038994qtm.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 17:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fyQ9435p3sHIpvP8cM2tSam/FIboDkccOaY/cNCRLcg=;
        b=NkogLHEsaLFS29Fnow5f8lEsgH877Wr2IAHC83xwDapuX/xQ3PyrZVuB8xXKAhGy3+
         2aNFj2RDiT65rH/m8WmoVPu7Sw5ALjNlJdQdEv+ASjITu0lSIxXIseSfMS1iDDruLaAu
         zk627vey4KiGYqKr2JshNan1VU3DfyMO/r1g7NlVZIn1kNPR9C/Mz6n82ji1md82hPiZ
         xD9LDacHWDrcGA4fO01Exa8Z5YYVLJuxT55oOz88aoI0TKeEKoj/cMoIFWTCDcVt3Zal
         U6exDEmzw4d1/tE9Xco2CpVnrsUZWp8Kl4hZJu8RZrgBozS0xJNzd69/V9pGVLanMEK8
         De5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fyQ9435p3sHIpvP8cM2tSam/FIboDkccOaY/cNCRLcg=;
        b=hZCXyA6yworwe3M8qdpPeuPlRlw8wP8kNUv2F+pmDex0nbzOHq7rFJycAopt65gYrN
         AUuHlepWhT/oX8P+x4tJsWJsTf8vBXBBbSezzXBeIzdfTK8plc+GWXnVbmExijxWmDVS
         v19V24ygX4OxoT8r5WRc6miMD5/IX+ipmLqgj9DnYT0lHz4vyhvNuL7FROjY1xw0Vncu
         36Jk6Bs9OVWRgJdQxlMncs1sVMwC7TCkn4fP5nlZgOj2kQMp5Vigh8mi8VNm9MPPFn5b
         oYcfdTPS6sUcTOXHYrAev7CHyEe4ZGojnhqmaZ2BLOLpXcwXBTucJCCr6SvSkU1f81A0
         kenw==
X-Gm-Message-State: AKwxytcsLIn6y87uQaYG4xMmBlktWxCbWhKIVVInkB8QDpqIyXKjvW3h
        FNLeq6kuqmj5pVQXdqM3N6MA8ERig5yJwrug+/w=
X-Google-Smtp-Source: AH8x2278QZ9vOuWSRrQAJqMIrZg6RsyEXPjUKEFsRe6Y16SwgQAqBnIRVVUWLuR4w3t5BQ/G/AtflUFPfAf0VfPec3c=
X-Received: by 10.200.9.42 with SMTP id t39mr59881361qth.74.1517534941959;
 Thu, 01 Feb 2018 17:29:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.133.131 with HTTP; Thu, 1 Feb 2018 17:29:00 -0800 (PST)
In-Reply-To: <e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com>
References: <e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Feb 2018 20:29:00 -0500
X-Google-Sender-Auth: Dr5BEaJGvOxqay883ESvk1VpMWs
Message-ID: <CAPig+cT8vKyhq6DvFMz-0CPRO-Y7R4EE_JhN6yuiSUNXW8-Yww@mail.gmail.com>
Subject: Re: [PATCHv2] tag: add --edit option
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 12:21 PM, Nicolas Morey-Chaisemartin
<nmoreychaisemartin@suse.com> wrote:
> Add a --edit option whichs allows modifying the messages provided by -m or -F,
> the same way git commit --edit does.
>
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> ---
> Changes since v1:
> - Fix usage string
> - Use write_script to generate editor
> - Rename editor to fakeeditor to match the other tests in the testsuite

Thanks for explaining what changed since the previous attempt. It is
also helpful for reviewers if you include a reference to the previous
iteration, like this:
https://public-inbox.org/git/450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com/T/#u

Cc:'ing reviewers of previous iterations is also good etiquette when
submitting a new version.

> - I'll post another series to fix the misleading messages in both commit.c and tag.c when launch_editor fails

Typically, it's easier on Junio, from a patch management standpoint,
if you submit all these related patches as a single series.
Alternately, if you do want to submit those changes separately, before
the current patch lands in "master", be sure to mention atop which
patch (this one) the additional patch(es) should live. Thanks.

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> @@ -167,6 +167,12 @@ This option is only applicable when listing tags without annotation lines.
> +-e::
> +--edit::
> +       The message taken from file with `-F` and command line with
> +       `-m` are usually used as the tag message unmodified.
> +       This option lets you further edit the message taken from these sources.

You probably ought to add this new option to the command synopsis. In
the git-commit man page, the synopsis mentions only '-e' (not --edit),
so perhaps this man page could mirror that one. (Sorry for not
noticing this earlier.)

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> @@ -452,6 +452,21 @@ test_expect_success \
> +get_tag_header annotated-tag-edit $commit commit $time >expect
> +echo "An edited message" >>expect

Modern practice is to perform these "expect" setup actions (and all
other actions) within tests themselves rather than outside of tests.
However, consistency also has value, and since this test script is
filled with this sort of stylized "expect" setup already, this may be
fine, and probably not worth a re-roll. (A "modernization" patch by
someone can come later if warranted.)

> +test_expect_success 'set up editor' '
> +       write_script fakeeditor <<-\EOF
> +       sed -e "s/A message/An edited message/g" <"$1" >"$1-"
> +       mv "$1-" "$1"
> +       EOF
> +'
