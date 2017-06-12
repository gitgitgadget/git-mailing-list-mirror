Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012921F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 17:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbdFLRLT (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 13:11:19 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35684 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbdFLRLS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 13:11:18 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so14802306pgc.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=thwZDAE7uMYPvQpjVTatlw18V7jp/r00PSmdmrsnHhE=;
        b=fTZF1a+Ubm0bflmmhBQ4kU5yEdoweEOJFeEgCyXDpHRPIC1iHeCJr54ma8p2OvWtnn
         9MkFW8iR1Sw12uY6p8/Eo1K+vmFamkU5zC6jwif3thADDqOZNtYLtClFcPUFJnBInIVD
         zTWp151PomaBhn49n+FVQBViRvhlZDmukUVwxJS4y2BlfxPPM6wwwQ+FH//GDO4OSIZQ
         eYGgOlC83J2X7TghkRPyO7GWRCZEdw2FSKii5QX+dZ7orZ+0d9/31PeHEUsigQnTTfVY
         k45vLHnkxDlKtCG1w0Bl4vyq6xHl4m6BxDlD5RqA/A8bf/QFjcTt8wyvw92Txkq0VN0h
         QlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=thwZDAE7uMYPvQpjVTatlw18V7jp/r00PSmdmrsnHhE=;
        b=OG2tH0rN+hz7nimOLqQEd6Td/z1osgWBqtvWcVYJ6Lz7tZEiAhJUmV15HloAXhMYrf
         hGY5uY1YJflnIKLUTB0ZxI5a6HgGo1xqUU4jrbmKSat1j7QKahPgHVndWy18aXObYUHh
         LKuqIlKQH2UiXSlkTm1eqoutSHDPL7yad9evclqQcbI1TsZyuUz/f+OMCyMuoH5IkY0L
         HZ1Tneo05xK92fbk8cyEMZmDuz3/sOJqD0avenezTMeR17O3/m4zLoxkoeVQgTzbmiaw
         W2mzjZwmQvAf7vtZFd2DLBDSOqnIi8FuCWdrVNOR0DcJqat9dntbGNicUbpsLNWSehmq
         MaVw==
X-Gm-Message-State: AODbwcDj2sPaD9iISDCSdNSDFQY9NGXUcM3u7lZ8S5N7ONBpMN318BzY
        gvlod6fkw51ZFg==
X-Received: by 10.98.74.5 with SMTP id x5mr44357888pfa.149.1497287477591;
        Mon, 12 Jun 2017 10:11:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id y8sm21913824pge.0.2017.06.12.10.11.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 10:11:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Yurzin <jurzin.s@gmail.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] Fix KeyError "fileSize" in verbose mode
References: <0102015c9b535a84-fd59d55d-387a-419e-b8ec-439873c4b7f5-000000@eu-west-1.amazonses.com>
Date:   Mon, 12 Jun 2017 10:11:16 -0700
In-Reply-To: <0102015c9b535a84-fd59d55d-387a-419e-b8ec-439873c4b7f5-000000@eu-west-1.amazonses.com>
        (Sergey Yurzin's message of "Mon, 12 Jun 2017 08:02:30 +0000")
Message-ID: <xmqq1sqpp1vv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Yurzin <jurzin.s@gmail.com> writes:

> Subject: Re: [PATCH] Fix KeyError "fileSize" in verbose mode

The convention around here is to think how a single change appears
in "git shortlog --no-merges" output.  The above commit title does
not tell readers of "shortlog" what the change is about in the
context of the whole system.

    Subject: [PATCH] git-p4: do not fail in verbose mode for missing `fileSize`

or something?

> From: Sergei Iurzin <sergei_iurzin@epam.com>
>
> ---

The blank space above is to explain why this change is needed and a
good idea, followed by your Signed-off-by: line (please see
Documentation/SubmittingPatches).

>  git-p4.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 8d151da91b969..b3666eddf12e3 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2523,8 +2523,11 @@ def streamOneP4File(self, file, contents):
>          relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
>          relPath = self.encodeWithUTF8(relPath)
>          if verbose:
> -            size = int(self.stream_file['fileSize'])
> -            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
> +            if 'fileSize' in self.stream_file:
> +                size = int(self.stream_file['fileSize'])
> +                sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
> +            else:
> +                sys.stdout.write('\r%s --> %s\n' % (file['depotFile'], relPath))
>              sys.stdout.flush()

I can see from your patch that self.stream_file[] sometimes may not
have `fileSize` and when that happens the current code will barf.  I
also can see that with your patch, the code will NOT barf but output
would lack the size information (obviously, because it is not
available).

However, it is not at all obvious if this is fixing the problem or
sweeping the problem under the rug.  The proposed log message you
write before the patch is the ideal place to say something like

    In such and such circumstances, it is perfectly normal that
    P4Sync.stream_file does not know its file and lacks `fileSize`.
    streamOneP4File() method, however, assumes that this key is
    always available and tries to write it under the verbose mode.

    Check the existence of the `fileSize` key and show it only when
    available.

Note that the above _assumes_ that a stream_file that lacks
`fileSize` is perfectly normal; if that assumption is incorrect,
then perhaps a real fix may be to set `fileSize` in the codepath
that forgets to set it (I am not a git-p4 expert, and I am asking
Luke to review this patch by CC'ing him).

Also note that in a real log message that is helpful for future
readers, "In such and such circumstances" in the above illustration
needs to become a more concrete description.

Thanks, and welcome to Git development community.

>          (type_base, type_mods) = split_p4_type(file["type"])
>
> --
> https://github.com/git/git/pull/373
