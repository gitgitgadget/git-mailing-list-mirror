Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C291F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 20:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfJBUbD (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 16:31:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:41139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJBUbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 16:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570048256;
        bh=JvXLnBDaFK52J4mNbG9Xcnlscmzv84yYQsFu9P8Ka84=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gvH2hvSTTzBBAtcKUiXp+Xvs3kO0gYK+v2Shm0Rb8hNZVU8Fxr1EC/vbW4wBurJ57
         yWAj8zG6yVE0+ZQI7s0e86gSOETB9ONcmjGnLta2dK2wgPb9fQTEFXqKtuYzQbcd0L
         z7rimXpiCYFrebSsvHTRpzT6plMTdTtn9xrmVGkw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1icQqT1Ax8-00VOe6; Wed, 02
 Oct 2019 22:30:56 +0200
Date:   Wed, 2 Oct 2019 22:30:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] range-diff: internally force `diff.noprefix=false`
In-Reply-To: <xmqq4l0qewu5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910022229340.46@tvgsbejvaqbjf.bet>
References: <pull.373.git.gitgitgadget@gmail.com> <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com> <xmqq4l0qewu5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8f5GpyXArBxViipFyp4/1YDvQuyf6SGf/vevmYSHbxE351VZ+AS
 tJLT8hsPZuUGsRM7LEw7zbPp1p1UaU/PxK0AFnHFvG8l2eqATwetoTbPYu8Px9eTLIZokOO
 jhINAe2Q6Vbf2bVqgPe2euULvRvdK2nmORh0btv8OZSRQbID+huhDzHJybisTb2rBD/eRTA
 /vtAiyLBE4dfoBZzZ8Umw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vZWFSmeBDmw=:jX68fZ7tCV5rSwXJsoVP7b
 fxFlpsu+0JBYCnXiKhQq5EevHQcwqCHJuX3LwT1NK/qPleseY4cSRTQ7cy8TOenafF3ecwcQt
 aavk2x9xMl1XhLZ+53ij3+OTxirCQDWAR7/ZwP6hFJon9Apk2qccyL3r0j0qer9TKstKVWcFx
 wRUb+t8Vtvkm67M3Bba3/UnQ2ZEgdJCmWx+g+p5UpJOTQLZXT1txxaLFrthmQf9WxfK6b57oJ
 LID1dhcT66Vqf3cHGwypMtiuIxIrcoS5YAs3SHP7qe7nbsFhUsI5YEstiuSBJOnHUy/HodEF1
 mBepelzIAn4NLjVcNKlXHod1izD5pJpG9W2soXpRmJVDuG9C9kkChSpJAb4f7+egSx8E+eJrd
 Be0li2yiHau0RdTXtOJumd/MJlYrqsWXWJx1anEYYbisWQPNlvlqor4e8WtLI59NWnWoc9avv
 1QWs+OuJpOFXZZANBxulk258pmS6q7pXmt815Bs5wcujkpF3x0m5GbJEdHQSZp/uFSy2FrukP
 rb76aBnuzXs4y0FAutAa8b5Qc4TI+32THsTzYJrIdzv/AD+H6R/z3MkwWENRPzita5rLXFYQg
 jxARgerrzh7YZdII9hGpAThdpf50hzYXakAnQUIPY6zS5vJYVelOMN8n+0hQ/eEL5CDDghdXS
 tv4E/lpOuZZ6hcpmhTZBxC9C+qdGSIcPyiv7+vxvhhklU3hXS5S04HhussS96PmRan8i0SP0B
 io0zPbnff+nHhPKb/N3aukMR0HIbRlE4Ze+LRFTYlvL/MXN+hOdKISC7MY/iffJkWRTbJ7Qfz
 V8fPlX8FaU8LTAWPJxQbrsqUXzsEMo21mFJBNM3h4rx4PDXFlU2nOVTpBzSDTAUg+aKu5YPDA
 Hk09K5RNB2jzBKV+cVyLnkVaCpbxtmFHjqvW+biZcFBa7wlNmhArN7tratNXDBpGSFWzRNhNY
 gT01hxmPuqbKt5uIycpMszwO8Qo3GXyMbc8J5SQx4JbV4XM5qFivPNHnxKPd8a3q38diU+2ke
 3EKbdm6gxVyDB1xPhM6Nu7RZxGja5qRkAK8FRBrWfniht/HDCyrjKr+gby2tYGfHyn8kqv8f5
 U/yos1uHGUtj8vT0It/BpLPQAcYciu6WYZ5V/Xid5nKtgTf/Q2aFyU9vRqKRxl2eT8x4d2JX0
 Gzjpjtoe94EUp4UX/yp6Lhov4oedbSuIVUyaLK4z07vw1rP4YSmLrEfzmm2ENimehMVwVgJuD
 D/CZmVZ2HfosUpNbVOMcUnqMIjWu24eBGRh2zPdaBez53lHVPeK7/vSY7D+c=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 3 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When parsing the diffs, `range-diff` expects to see the prefixes `a/`
> > and `b/` in the diff headers.
>
> If so, passing src/dst prefix as command line option is a much better
> solution, I think.  diff.noprefix may not stay to be (or it may
> already not to be) the only thing how the prefix gets chosen.

Good point.

While at it, I invert the logic in v2: instead of forcing a prefix, I
now force no prefix (and reduce the strip level from 1 to 0 when parsing
the diff header).

Thanks,
Dscho

>
> > -	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> > +	argv_array_pushl(&cp.args, "-c", "diff.noprefix=3Dfalse",
> > +			"log", "--no-color", "-p", "--no-merges",
> >  			"--reverse", "--date-order", "--decorate=3Dno",
> >  			/*
> >  			 * Choose indicators that are not used anywhere
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > index 0120f769f1..64b66f2094 100755
> > --- a/t/t3206-range-diff.sh
> > +++ b/t/t3206-range-diff.sh
> > @@ -461,4 +461,8 @@ test_expect_success 'format-patch --range-diff as =
commentary' '
> >  	grep "> 1: .* new message" 0001-*
> >  '
> >
> > +test_expect_success 'range-diff overrides diff.noprefix internally' '
> > +	git -c diff.noprefix=3Dtrue range-diff HEAD^...
> > +'
> > +
> >  test_done
>
