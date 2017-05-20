Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FFC7201A7
	for <e@80x24.org>; Sat, 20 May 2017 22:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbdETWAQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 18:00:16 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32999 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdETWAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 18:00:14 -0400
Received: by mail-pg0-f44.google.com with SMTP id u187so52250335pgb.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i+OKrTAuIpa5VUigKidBatHX/af1tLKjFkIRYRqsOIc=;
        b=t8wZ8EfTmSWMWb0owzrv+kZ/11Gu43fVIQ3WRS0vl7ayTxyPiikRNUjtNFckaX2cCl
         K/Yk4mlM3ue0bIBBEgiMS+MwiIdTLu1/FwbuzRkMlwVDztXH0kaf5nPRJoi0DG+NkVGs
         CdDCr59txL80/jQHMagfDIC+CbZ/XAXAAw6/cOrHaGc3sIAPoar/cmVHs0Z01TNz3ZhM
         B75x59KnQqnbGAKal3lrlDlk5p0S33uYd/tQuE+o+hw1zS2clpyl3HVowvSl43biLtl4
         EGeaL1j/6N3uPUBYlSQPN7ZNu5IKIj54ItSFlC1bpYWNphMnkpBBmwpD/3ciLE8yxp8a
         015Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i+OKrTAuIpa5VUigKidBatHX/af1tLKjFkIRYRqsOIc=;
        b=gvmrj9Eq/r7m8OQz99YVMD8E9Jef2vuQ/g8Slln6zMFLvcqUiHJfQ7AK1xzgCoVtbn
         GR6moE9aUGfEJWSw6fFp9chqKo9xKqFxI9pnPfHHsXqeSOyjqOp2bA7r04teMRt85lPX
         pretp5evm+YfA8AxI0bHaAbU33Gz/HzyntfogHxz44f3YlPXuC85I3R2Z6K2P1rK6XPu
         2W8Q8O4qIJNgP29bkezID+rHKkYbio5S1v3Fy31/eU0dVMTRGzWm0Vfv7DatCYGp1jD9
         DjU7QI2/zQbgGxmdGDswl6vT5MwYbV+toZEGP65BZ4ze8TvPp16B7eYWRzUyQ5E+ShBI
         yrYw==
X-Gm-Message-State: AODbwcCgOi22MZJ9FTtK23asZfuyoBQH9eRNW53oPDxjBrSm8Xlb0Cyk
        4f/0IVGxc5GcOULgSrT3z7El7NMAIsAF
X-Received: by 10.84.248.73 with SMTP id e9mr19583471pln.76.1495317614099;
 Sat, 20 May 2017 15:00:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Sat, 20 May 2017 15:00:13 -0700 (PDT)
In-Reply-To: <xmqqk25ct9lh.fsf@gitster.mtv.corp.google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170517025857.32320-1-sbeller@google.com>
 <20170517025857.32320-13-sbeller@google.com> <xmqq8tlwxdp3.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbCYiDRbf2+uXANqBiR9sG4ir4m6VK5+t1LS-kE7T1aQg@mail.gmail.com>
 <xmqqinkyvobp.fsf@gitster.mtv.corp.google.com> <CAGZ79kbXyjTaE=F7YU8yu8=eNzLS96sA5r5N4xrhmOfw+T4Lwg@mail.gmail.com>
 <xmqqk25ct9lh.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 20 May 2017 15:00:13 -0700
Message-ID: <CAGZ79kaHS2O90M8BXj_fEouSRgO+top7mkiawjqM7Xd=tUiX9g@mail.gmail.com>
Subject: Re: [PATCHv2 12/20] submodule.c: convert show_submodule_summary to
 use emit_line_fmt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2017 at 9:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> That could be added in ws.c:ws_check_emit, as these certain words
>> are similar to coloring whitespace.
>
> I actually was envisioning of highlighting a part of a line, like
>
>     -Very <red>poor</red> SCM
>     +Very <green>nice</red> SCM
>
> which would be done by finding semi-matching removed and added lines
> in the same hunk (i.e. local buffering) and makes a coloring decision.
> That does not have any place in ws.c.

Yes such a feature would not want to be in ws.c

For the problem above, we're still fine with the given data structures IMO.
Though it may hint at bad naming of the struct 'buffered_patch_line'
as it is not a complete line.

Assuming the example above, running "show --word-diff" would produce
the following "buffered_patch_lines"

{show_prefix=1, sign='\0', line="-Very ", set=NULL, reset=NULL}
{show_prefix=0, sign='\0', line="{- poor}", set='red', reset='normal'}
{show_prefix=0, sign='\0', line="{+ nice}", set='green', reset='normal'}
{show_prefix=0, sign='\0', line=" SCM\n", set=NULL, reset=NULL}

so in the future, we may want to produce

{show_prefix=1, sign='-', line="Very ", set=NULL, reset=NULL}
{show_prefix=0, sign='\0', line="poor", set='red', reset='normal'}
{show_prefix=0, sign='\0', line=" SCM\n", set=NULL, reset=NULL}
{show_prefix=1, sign='+', line="Very ", set=NULL, reset=NULL}
{show_prefix=0, sign='\0', line="nice", set='gren', reset='normal'}
{show_prefix=0, sign='\0', line=" SCM\n", set=NULL, reset=NULL}

instead.

I think the data structure can be used as-is, but is just mis-named.
I'll fix that in a resend.

The algorithm to highlight what changed on a word level after a hunk
would have to be put into the current hunk finding
("mark_color_as_moved"), and then split up the actual lines into pieces
of a line and add different colors like we see above.

>
>>> Having said that, we need to start somewhere, and I think it is a
>>> reasonable first-cut attempt to work on top of the textual output
>>> like this series does (IOW, while I do agree with the NEEDSWORK and
>>> the way this series currently does things must be revamped in the
>>> longer term, I do not think we should wait until that happens to
>>> start playing with this topic).
>>
>> Ok. I share a similar reaction to submodule diffs that we discuss above
>> and word coloring, that Jonathan Tan brought up off list.
>>
>> Both of them are broken in this implementation, but the NEEDSWORK
>> would hint at how to fix them.
>
> Yes, but if NEEDSWORK has to say "the current hack is working at a
> wrong level, we need to do all of this before producing textual
> diffs that are passed to the layer that colors lines", that wouldn't
> help that much as a hint X-<.

For the word coloring, I think we'd just need better post processing.

For cros-submodule move detection, we may want to wait in Brandons
work to be able to run submodule stuff in-process and then we
have the lines buffered directly there, so we can operate on them as well.

I agree that "NEEDSWORK: the current hack is working at a wrong level"
is not useful. But I thought we're in agreement that it is not? I must have
misunderstood parts of what you were saying.

By saying it could go to ws.c in my reply I rather meant:
it could go into some post-processing function of the "buffered_patch_line"
struct. Currently we only have ws_emit_line that does it, but we can do
it either similarly or just split up one buffered_patch_line into more
than one and color up each individually.

This would also be possible for us now, too. Instead of running it through
ws_emit_line we could split up the line and color each piece differently.
However that could be a problem in the algorithm to find similar hunks
(as we do have different rules for added and deleted text).

Thanks,
Stefan
