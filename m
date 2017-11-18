Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3299A202A0
	for <e@80x24.org>; Sat, 18 Nov 2017 07:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162996AbdKRH4q (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 02:56:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55739 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1162993AbdKRH4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 02:56:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F6D9B2B07;
        Sat, 18 Nov 2017 02:56:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IVzDoPNM41K4
        iV4P+Xd+MUBeB7U=; b=Y2cLkzfC96/II94lciYQxCje503f0SGAaNgOtcIq4SvM
        WTdS6pNHbpyYC0JbnCFLmPxr2ljK87gTYy6r+IUQ14BE+h6g+RdDSYw3Q5B7H6tV
        l1nMWP+FHUeH+MIvOhlgK5ErrQQtT5oxE1XiRIoMQ9JxuWVFubu0aV6vYDKrOho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BMZWMp
        ri8fSHOY/dBoUMy9v4P52/TRCLynMWHV6qKrVfdzqrdI9S8udGAgC1R9cymr0+lI
        ioyOP93WDDB6IWIkw/Qunjg1zsl/V6xi52FeXWzFeyA+D9w9KGTwZzFApjCRSa7K
        ZOnOj3eL/Iy/9ZaiIPv79jdtt5A5StDrIoz04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87141B2B06;
        Sat, 18 Nov 2017 02:56:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03F65B2B05;
        Sat, 18 Nov 2017 02:56:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Is it not bug git stash -- <pathspec> does not work at non-root directory?
References: <CAC2Jkr+brEKLy-z45WwP2iqssA14na9xpaCoKrNKbPcTvtUxJA@mail.gmail.com>
        <xmqqzi7kp7j2.fsf@gitster.mtv.corp.google.com>
        <CAC2JkrLWVEHvV7tf24bPmVEDpgnrKTFtHR5UHMh+kC8v_fWumA@mail.gmail.com>
Date:   Sat, 18 Nov 2017 16:56:41 +0900
In-Reply-To: <CAC2JkrLWVEHvV7tf24bPmVEDpgnrKTFtHR5UHMh+kC8v_fWumA@mail.gmail.com>
        (=?utf-8?B?IuWwj+W3neaBreWPsiIncw==?= message of "Sat, 18 Nov 2017 13:12:29
 +0900")
Message-ID: <xmqqmv3kow92.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04494C16-CC36-11E7-8CA5-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E5=B0=8F=E5=B7=9D=E6=81=AD=E5=8F=B2 <aiueogawa217@gmail.com> writes:

>> Please make it a habit (not limited to when interacting with
>> _this_ project) to state a bit more than "does not work";
>> instead, say "it is expected to do X, but instead it does Y, and
>> the difference between X and Y I perceive is Z".
>
> Thanks. I'll rewrite the issue.
>
> Assuming that we have sub/something and something is not included anywh=
ere else,
>
>         cd sub && git stash -- something
>
>  is expected to make a stash for sub/something but instead returns erro=
r like
>
>         error: pathspec 'something' did not match any file(s) known to =
git.
>         Did you forget to 'git add'?
>
> .
>
> I don't know what I should write about 'the difference between X and Y =
is Z'.

If the difference between X and Y is obvious there is no need. =20

I just tried it and I do not see the command is broken in the way
you describe.

Trial #1 -- the command fully spelled out.

    $ git.git/master: cd Documentation
    $ Documentation/master: echo >>Makefile
    $ Documentation/master: git stash push -m "doc-make" -- Makefile
    Saved working directory and index state On master: doc-make
    $ Documentation/master: git stash show --stat=20
     Documentation/Makefile | 1 +
     1 file changed, 1 insertion(+:

Trial #2 -- lazily issue the command without subcommand.

    $ git.git/master: cd Documentation
    $ Documentation/master: echo >>Makefile
    $ Documentation/master: git stash -- Makefile
    Saved working directory and index state WIP on master: 89ea799ffc Syn=
c with maint
    $ Documentation/master: git stash show --stat=20
     Documentation/Makefile | 1 +
     1 file changed, 1 insertion(+:

Trial #3 -- make sure having files with the same name is not hiding any b=
ug.

    $ git.git/master: cd Documentation
    $ Documentation/master: echo >>CodingGuidelines
    $ Documentation/master: git stash -- CodingGuidelines
    Saved working directory and index state WIP on master: 89ea799ffc
    $ Documentation/master: git stash show --stat
     Documentation/CodingGuidelines | 1 +
      1 file changed, 1 insertion(+)

Trial #4 -- simulate a PEBKAC

    $ git.git/master: cd Documentation
    $ Documentation/master: echo >>no-such-file
    $ Documentation/master: git stash -- no-such-file
    error: pathspec 'Documentation/no-such-file' did not match any file(s=
) known to git.
    Did you forget to 'git add'?

The last one is an expected result---the pathspec given to the
command does not match anything tracked, so without first adding the
file, there is nothing for the command to do.

