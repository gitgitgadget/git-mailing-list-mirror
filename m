Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 22091 invoked by uid 111); 16 Aug 2010 02:01:14 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 16 Aug 2010 02:01:13 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab0HPCBI (ORCPT <rfc822;peff@peff.net>);
	Sun, 15 Aug 2010 22:01:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45978 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab0HPCBH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 22:01:07 -0400
Received: by iwn7 with SMTP id 7so1155967iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 19:01:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+1EXRGNhP9fDm/BRv7k+aGyGyQsV/YjToEHRlGoYhhk=;
        b=T8lHNQWoFw7GHJhpZS3WT90YD4w5upsE+mmkYDCFoa8yKgZREsBzMblns2FdPwvpxW
         +MUy36ROP/ptdlyNpscDl+fBsQ6ZhLu7NNJzkk1if1NtR/ylGujs2TepuUhe4NnH1fTj
         4X1wgR3u79hpqeG2upGPuH7fKatl9E7Tz30EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xwwgmwzRkNfhcrNJXibVYtYIN7bceGpMnycITSzUX4SZrKodFY3elejbPhpokhw13Z
         fN6ZUVOmb5eq4RtDSuOaiOvE4HXaDUvcZsNRzprFolbN40ooft5aH7pPxbD+8+ynVEkz
         vNmEzTvCQjfmdM4LzreVDEzS7ARrKaf8qyZIU=
MIME-Version: 1.0
Received: by 10.231.190.10 with SMTP id dg10mr5306379ibb.46.1281924067307;
 Sun, 15 Aug 2010 19:01:07 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 19:01:07 -0700 (PDT)
In-Reply-To: <7vaaonfhs8.fsf@alter.siamese.dyndns.org>
References: <7vzkwqi10w.fsf@alter.siamese.dyndns.org>
	<1281748247-8180-1-git-send-email-avarab@gmail.com>
	<AANLkTi=Na_K=9oXM7iyeKodWXyXuSy-0UL792igTEjEe@mail.gmail.com>
	<7v39uggs5h.fsf@alter.siamese.dyndns.org>
	<AANLkTi=PAW_Owy_-DSQ32sboB28373Gb_aySbpeprwLg@mail.gmail.com>
	<7vaaonfhs8.fsf@alter.siamese.dyndns.org>
Date:	Mon, 16 Aug 2010 02:01:07 +0000
Message-ID: <AANLkTi=otHzT0n6Do0EzBMMbb0dyh8C6O0G+KpJjtAhg@mail.gmail.com>
Subject: Re: [PATCH] log: test for regression introduced in v1.7.2-rc0~103^2~2
From:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 16, 2010 at 01:49, Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>>> +     # Needs an unrelated root commit
>>>> +     test_commit README &&
>>>
>>> This is not a "root" commit, is it?
>>
>> s/root/first/
>
> It is not even the first commit, is it?  It comes on top of whatever
> commits that earlier tests left.
>
>>>> +     >Foo.bar &&
>>>> +     git add Foo.bar &&
>>>> +     git commit --allow-empty-message </dev/null &&
>>>
>>> Does emptiness of the message matter?
>>
>> No, I was just going for a minimal test case, no commit message is
>> more minimal than having one.
>
> I do not think having to write "--allow-empty-message </dev/null" is
> aiming for being minimal; it is doing something unusual after all.
>
> If you do not remember why you added this test 6 months down the road,
> wouldn't you be confused to think maybe the commit has to be unusual in
> that it has to lack the message to trigger the bug?

My v2 patch should address both of these issues.
