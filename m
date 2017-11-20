Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DBB2202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 17:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdKTR0p (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 12:26:45 -0500
Received: from e1i183.smtp2go.com ([103.36.108.183]:50852 "EHLO
        e1i183.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdKTR0o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 12:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1511199704; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Subject:To:From:Reply-To:Message-ID:Sender:
        List-Unsubscribe; bh=zsqYwTcQGtC5eP+tRTc5asQrRbVRdguComh5VO7sTkk=; b=Igzru3rp
        H1iwbNJEsB/jaqu2cPiyEGU6ePI1g4e714ZAygWqSUTRQnWw9bWCWUp1Z3sEYrn6UDzKBWvQ1HdQY
        5ObfwmC0/A2f8QlpZwKfm0kH+qYCszUEvEl+1xCXyGUvjilR738hjPEdpZfFOj/2x9sJIqZGqMIoi
        bGpI8e5y7eppE1VVFzkFSLTfXkFVa1y7nzrFjF1Fnnarxu7w4LWlIZ5rDYnlhWjHM00yFz9u/wJ7g
        iIIMtMKc67YZmywRC9uzs8xqpqllhdHmZZoaOECaYM2u7KbbkUV2VGHy2K81e1zCfNpl/Ibsi7GFH
        xDZt/cdUyoeeRZUZ1Vxyr0p18w==;
Message-ID: <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Ann T Ropea" <bedhanger@gmx.de>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        "Daniel Barkalow" <barkalow@iabervon.org>
References: <20171119184113.16630-1-bedhanger@gmx.de>        <20171113223654.27732-1-bedhanger@gmx.de>        <83D263E58ABD46188756D41FE311E469@PhilipOakley>        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>        <20171113223654.27732-3-bedhanger@gmx.de>        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>        <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v3 5/5] Testing: provide tests requiring them with ellipses after SHA-1 values
Date:   Mon, 20 Nov 2017 12:25:34 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1-GpMI9EFLrbTj.Ey7JGYcn6
Feedback-ID: 66524m:66524aMf6O2Y:66524sRv53HvUS8:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-contact@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Ann T Ropea <bedhanger@gmx.de> writes:
>
>> *1* We are being overly generous in t4013-diff-various.sh because we do
>> not want to destroy/take apart the here-document.  Given that all this a
>> temporary measure, we should get away with it.

So, the need to reformat the test for the future post-deprecation period is 
being deferred to the time that the PRINT_SHA1_ELLIPSIS env variable, and 
all ellipis, is removed - is that the case? Maybe it just needs saying 
plainly.

Or is the env variable being retained as a fallback 'forever'? I'm half 
guessing that it may tend toward the latter as it's an easier backward 
compatibility decision.

[apologioes this is mid thread, I'm catching up on 2 weeks of emails]

>
> I do not think the patch is being particularly generous.  If
> anything, it is being unnecessarily sloppy by not adding new checks
> to verify the updated behaviour.
>
> The above comment mentions "destroy/take apart" the here-document,
> but I do see no need to destroy anything.  All you need to do is to
> enhance and extend.  For example, you could do it like so (this is
> written in my e-mail client, and not an output of diff, so the
> indentation etc. may be all off, but should be sufficient to
> illustrate the idea):
>
>    while read cmd
>    do
>            case "$cmd" in
>            '' | '#'*) continue ;;
>            esac
>            test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
>            pfx=$(printf "%04d" $test_count)
>            expect="$TEST_DIRECTORY/t4013/diff.$test"
>            actual="$pfx-diff.$test"
>   +        case "$cmd" in
>   +        X*) cmd=${cmd#X}; no_ellipses=" (no ellipses)" ;;
>   +        *) no_ellipses= ;;
>   +        esac
>   -        test_expect_success "git $cmd" '
>   +        test_expect_success "git $cmd$no_ellipses" '
>                {
>                        echo "\$ git $cmd"
>   -                    git $cmd |
>   +                    if test -n "$no_ellipses"
>   +                    then
>   +                            git $cmd
>   +                    else
>   +                            PRINT_SHA1_ELLIPSES=yes git $cmd
>   +                    fi |
>                        sed -e ....
>        ...
>    done <<\EOF
>    diff-tree initial
>    diff-tree -r initial
>    diff-tree -r --abbrev initial
>    diff-tree -r --abbrev=4 initial
>   +Xdiff-tree -r --abbrev=4 initial
>    ...
>    EOF
>
> There is a new and duplicated line with a prefix X for one existing
> test in the above.  The idea is that the ones marked as such will
> test and verify the effect of this new behaviour by not setting the
> environment variable.  The expected and actual test output for the
> new test will have X prefixed to it.  t4013 is arranged in such a
> way that it is easy to add a new test like this---you only need to
> add an expected output in a new file in t/t4013/. directory.  And
> the output with these ellipses removed will be something we would
> expect see in the new world (without the escape hatch environment
> variable), we would need to add a new file there to record what the
> expected output from the command is.
>
> I singled out the diff-tree invocation with --abbrev=4 as an example
> in the above, but in a more thorough final version, we'd need to
> cover both "abbreviation with ellipses" and "abbreviation without
> ellipses" output for other lines in the test case listed in the
> here-document. 

