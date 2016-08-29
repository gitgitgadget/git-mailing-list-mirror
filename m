Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDEF1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754805AbcH2TDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:03:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34790 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbcH2TDN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:03:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so14689wma.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/qpNw9RgKCmyln/fCW68NqHA2VeY5IWqVQOlIOrK+/c=;
        b=YDUTYxzJHQsaWCSJPp+r+MGAURNhXhoytVSXVNXyu5yhEVyUK45I/FhCxCmivIwBxA
         5dXcUOO7U8vSySNkiX1sQuCZcHRelcc0FXbuwMegh2/C4h++9Qn8DXtpBgx2Ex6wA35+
         5ZUcpaHajA3ZPp+l72Pkh8MloDT1NHdeWr36rbXptVMJp71p6VyViQUwP8mA+lebcSR/
         C8IKDTl8qRmCIteP4hB4OOKy7e+CIje/nActz4cWKTYTyj7wwRUyOG7a/0GDhBBgk6YO
         GtCN8KhvIdzpCNFDpO4VnoJdYF3hhNIBheKPLLxUi7u+yUxSbKo9FYAudzmKWyt8p9u+
         pc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/qpNw9RgKCmyln/fCW68NqHA2VeY5IWqVQOlIOrK+/c=;
        b=hOO1ANNBdrOkRxiU42MDyT0iciXUWDYEYK/en0g4QaMGd+ArR3P1TKMGWEKvadJJdL
         e3BNXUTN9fJjx23TohwYYnkuLC/alKfX4Ba6QwFNCO896vkvSgauleDdIZWWSr+ghaAh
         a3bLnHlZyGx9b8tpPfC8rWko8EBs1O1SZCdBlvTWESCjGxKwVn/1PJRX3TwtkwyMazs+
         YHUFAPAbXQd1oOGyPfyg3+m5W/9nkFmQeYDhowCziPPnQmgduZ4jUSFaIR7aILij5GoG
         OYGtLAuo6NNMxSXEmnxuScdEd4Pd1GoBajSpJLXEgxSwGZ7pFy9WR/6Jmsu/OflXjITM
         OiqA==
X-Gm-Message-State: AE9vXwPem3rO2mZGhqgfi2Sxn5z4l+67gnx+yDE0Zznagl7CKHyzH7rUp/y0hhXieFXbTg==
X-Received: by 10.194.41.194 with SMTP id h2mr16542271wjl.2.1472497392041;
        Mon, 29 Aug 2016 12:03:12 -0700 (PDT)
Received: from [10.32.248.244] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 4sm14858244wmu.2.2016.08.29.12.03.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 12:03:11 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 13/13] read-cache: make sure file handles are not inherited by child processes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqy43fbgcj.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 29 Aug 2016 21:03:09 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D9E5AED-7003-4707-8791-1C25432DB558@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-14-larsxschneider@gmail.com> <xmqqy43fbgcj.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Aug 2016, at 20:05, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Consider the case of a file that requires filtering and is present in
>> branch A but not in branch B. If A is the current HEAD and we =
checkout B
>> then the following happens:
>>=20
>> 1. ce_compare_data() opens the file
>> 2.   index_fd() detects that the file requires to run a clean filter =
and
>>     calls index_stream_convert_blob()
>> 4.     index_stream_convert_blob() calls convert_to_git_filter_fd()
>> 5.       convert_to_git_filter_fd() calls apply_filter() which =
creates a
>>         new long running filter process (in case it is the first file
>>         of this kind to be filtered)
>> 6.       The new filter process inherits all file handles. This is =
the
>>         default on Linux/OSX and is explicitly defined in the
>>         `CreateProcessW` call in `mingw.c` on Windows.
>> 7. ce_compare_data() closes the file
>> 8. Git unlinks the file as it is not present in B
>>=20
>> The unlink operation does not work on Windows because the filter =
process
>> has still an open handle to the file. Apparently that is no problem =
on
>> Linux/OSX. Probably because "[...] the two file descriptors share =
open
>> file status flags" (see fork(2)).
>=20
> Wait, a, minute.  "that is no problem" may be true as long as "that"
> is "unlinking the now-gone file in the filesystem", but the reason
> does not have anything to do with the "open-file status flags";
> unlike Windows, you _can_ unlink file that has an open file
> descriptor on it.

I see. Thanks for the explanation.

>=20
> And even on POSIX systems, if you are doing a long-running helper
> any open file descriptor in the parent process when the long-running
> helper is spawned will become leaked fd.  CLOEXEC is a possible
> solution (but not necessarily the only or the best one) to the fd
> leak in this case.
>=20
> How much does the code that spawns these long-running helpers know
> about the file descriptors that happen to be open?

Nothing really.

>  The parent is
> very likely to have pack windows open into .pack files and they need
> to be closed on the child side after fork(2) starts the child
> process but before execve(2) runs the helper, if we want to avoid
> file descriptor leaks.

I think I understand what you are saying. However, during my tests
.pack file fd's were never a problem. I use start_command() [1]
which wraps the fork() and exec calls [2].

How would I find the open .pack file fd's? Should I go through=20
/proc/PID/fd? Why is this no problem for other longer running=20
commands such as the git-credential-cache--daemon or git-daemon?

Thanks,
Lars


[1] =
https://github.com/larsxschneider/git/blob/protocol-filter/v6/convert.c#L5=
66
[2] =
https://github.com/larsxschneider/git/blob/protocol-filter/v6/run-command.=
c#L345-L412


