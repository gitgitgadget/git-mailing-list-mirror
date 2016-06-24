Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D281F728
	for <e@80x24.org>; Fri, 24 Jun 2016 09:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbcFXJVx (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 05:21:53 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33864 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbcFXJVu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 05:21:50 -0400
Received: by mail-qk0-f174.google.com with SMTP id t127so138863809qkf.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 02:21:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bTt/Tl7br/wTU9HeIm25nl6vxqrQBTz+Lh65c4U/UZM=;
        b=J/24x2TUbpIyGDEf1N8B3p1RMPxJZquoKAEi3WOFGloF8415n8Uq/mZC6CRU+IJflI
         +gf5IDdSYnM0gVxwAnLRqYfohIt9f+GIGjj5OREiH1J4Bbcn+Empw+1Dguxf55bOEkeB
         HS/aTOyKCmWhCq8ul8ayzLIZNFHGnN1iX4t4YBOck8SDx85/qsbP8cD0Lo+A+60z6NRK
         FYMc7WV5kJt1Opy37ulF6Wxrf8Yq2Y8POvIHlmOVUJf9UO8o7V5ZIOr2gWxsjcL4XKn/
         7ixeF3qocG5885QCUcZ0WZmcjBFOzyzD2urMYJGpAFLUQW9TG4JUpmmFm1OCHtRWKtcC
         wOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bTt/Tl7br/wTU9HeIm25nl6vxqrQBTz+Lh65c4U/UZM=;
        b=R06atdyK5OhOK9Q2yG/qaGNzyTDhjOsSAeXX9NLHJjtKQ1wmUu9veZkKcw68J0WrGu
         01R4DDw4f++d7RIEPpVXqNESqglSdkhzhn1OSlC5Try7VPKH13RCvAeX/l0XZd46seXV
         rZGNIY2XnonufsFFXmYmrbzO1eYcguLzHm3rL6s4NZ94ip34BpEGrPDCd+9I6wEP2n0Y
         haI55Z8fAEj2A2bih4uqE23bCvBYP1RL9kMqkaUB8PXZj99hWp7oBXAQGi+2gLh7OENW
         wFT/HnT6firAS/IvYqbhlVeLQ4U0fboaIRoJhDYQDdcXmnizMjse9DqunmB3/4rreDEp
         cHtQ==
X-Gm-Message-State: ALyK8tI/OjaY9gyRNlaMsfdp4PcU8BW6Dmh6CMJcSNVOCOloJC2mUUwXjNEO7dq90h8eApril8x0fRPTKVKWuw==
X-Received: by 10.55.165.4 with SMTP id o4mr3263372qke.15.1466760108967; Fri,
 24 Jun 2016 02:21:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.123.6 with HTTP; Fri, 24 Jun 2016 02:21:48 -0700 (PDT)
In-Reply-To: <xmqqd1n8jtzk.fsf@gitster.mtv.corp.google.com>
References: <20160622165126.12786-1-mehul.jain2029@gmail.com>
 <xmqqr3bpklsd.fsf@gitster.mtv.corp.google.com> <CA+DCAeQUJ4D4kjR6FtTibwPO8o+wv-hQNDDj2ysJaBHGTPkHgA@mail.gmail.com>
 <xmqqd1n8jtzk.fsf@gitster.mtv.corp.google.com>
From:	Mehul Jain <mehul.jain2029@gmail.com>
Date:	Fri, 24 Jun 2016 14:51:48 +0530
Message-ID: <CA+DCAeSvb14W5CoEa72DQtM+FHQ+jppSVvoTmQ7rX0EHQAMy6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce log.showSignature config variable
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 12:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> In patch 2/3 and 3/3, there are many tests which requires a branch
>> similar to that of "signed" branch, i.e. a branch with a commit having
>> GPG signature. So previously in v2, I created two new branches,
>> "test_sign" and "no_sign", which are identical to that of "signed"
>> branch. And with these branches, I wrote the tests in patch 2/3
>> and 3/3.
>>
>> As suggested by Eric [1], rather than creating new branches, I
>> can take advantage of "signed" branch which already exists.
>
> Yeah, I understand that part.  But you do not _need_ to do the split
> you do in 1/3 in order to reuse "signed".

If it's fine, then I think it would be OK to drop this 1/3. Without splitting
the 'log --graph --show-signature' in two test will also serve the
purpose for the new test to use the signed branch.

Should I send a new patch series with 1/3 dropped or you can do
it manually at your end?

Thanks,
Mehul
