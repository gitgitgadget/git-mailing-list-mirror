Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE0D20966
	for <e@80x24.org>; Mon, 10 Apr 2017 16:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755936AbdDJQ4n (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 12:56:43 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35676 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdDJQ4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 12:56:41 -0400
Received: by mail-vk0-f52.google.com with SMTP id r69so99302020vke.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lpnvbBA+fEtr4p5cHjWI2Ta5QwM7H6WDs4kDE8U3Ock=;
        b=X90cb2nG8ZeqJ113bYgS667o6jiOnuXvmCFZKFPq80DHuVbZm0etTwEDL/Wh7JMnlz
         PAI9i3SVXQslRae1fyuKunsWGFv5DtSXSPFAweREilY1JxzSvCMDrXsYjVkonIyuPzgO
         ICRfeg5HuqOtT8Pa39wdmAK0FC6s4wSErtjA3y5utfXAviBMknnCt/N+puMtsqoxE0Pk
         jRgh2q4lk/x818gK2ZqBqUgJ3Dw+ugAeGebSQDkPAf6JgRABCMdEHObLW8ZBz9/tqUSJ
         sgvc038AYKfiVE4MhDfP0gB6raOrPkVnnLrtnBp6NujJnOo5LdOBtEDQmH9CHBKx2DrD
         3K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lpnvbBA+fEtr4p5cHjWI2Ta5QwM7H6WDs4kDE8U3Ock=;
        b=GF2QFdvq7SnAGPGjDymLpR65INWdn45QWUqKz3v0QSNX9A5lGjW8PBu+x7kzDKxBc+
         oYkMpBnl5vFrBBFXK6+xbIsceQgGhyehGcDBnxVIuNcontV3wCtVjMW0rIBUT7XbrLGB
         5TOFs1Tving4kMj05UG95T0kfH9KltYelc7GWY3osgkA/QHbjGZrO1Z7xxkkcsW+tGKQ
         706egtqW9va9i9IygEUMIJb29vAGDhjy//thNJFeYdNDU+CKMCO5xSPln1ExpdNgahML
         pCiccMT2d0YB0icsbQcDuVPMVq0bACPXUd4LtP5ZTwDMC4SxN7K1GeITK7rQgKexmJfM
         sJBQ==
X-Gm-Message-State: AFeK/H3c8d1u+ysDPqjm18je4D1upP6jRC4mWhDo1jw2mlLGyciGT8RzHeEz1+NddIlM0i7RDk7bL1mry71hEA==
X-Received: by 10.31.1.7 with SMTP id 7mr24174993vkb.0.1491843390612; Mon, 10
 Apr 2017 09:56:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.16.94 with HTTP; Mon, 10 Apr 2017 09:56:30 -0700 (PDT)
In-Reply-To: <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net>
References: <20170410125911.6800-1-szeder.dev@gmail.com> <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
 <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com> <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 10 Apr 2017 18:56:30 +0200
Message-ID: <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test script
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 6:35 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 10, 2017 at 06:31:54PM +0200, SZEDER G=C3=A1bor wrote:

>> This means we can write this simply as:
>>
>>   doesnt_matter=3D$(git gc --auto 9>&1)
>>
>> It's still hackery :)
>
> Heh. Yeah, I would call that _more_ hackery in that it's much more
> clever. But it is shorter. :)
>
> I think as long as the trickery is documented that's OK (and calling it
> doesnt_matter and explaining in the commit message is fine by me;
> hopefully that name would induce somebody to look in the history).

For the sake of self documentation and potential future users, I will
put it into a helper function like run_and_wait_for_detached_auto_gc()
or something.  Jury is still out on the proper function name (it would
be a shame if the funcname were longer than the command ;), but time
is up for today...
