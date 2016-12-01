Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E0D1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758142AbcLASvi (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:51:38 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34641 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756655AbcLASvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:51:38 -0500
Received: by mail-qk0-f178.google.com with SMTP id q130so67317098qke.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 10:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YNbcsonKJvZ1DQ5HQpdCAVwsm07TxX0+R1g6eZt+0M8=;
        b=W5rCSwiLbtlBJ2emrApNofVpByuxZWy0dvBuTmLlMHS02QNeC7Nprbcq9jl9QDhdcL
         cIsFJBcsha8l8F8FSk3enxOomVM/cXf/64Llr5O/aVAc8lMxCsoA0X96GfuF+POS2LuT
         oi7TQD/t7nX7H3Ni+RMJwtZKfZOpzVvTd796675FlMQABI7aLqZf/Cl0y9l035bgiGxg
         SmZUj9uTguVJkp7BpvmJBGAZDoJS9Hm6PixHQ/Chv/JuJatmPpkAk0nkx7Uxdh2lhJ6C
         8NSuyDkzaUzBlnkOz9lQcx57Kb2P9TfRl18hBLM02J36BTYf4FwMxsxEHWp942zdmO2Y
         90xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YNbcsonKJvZ1DQ5HQpdCAVwsm07TxX0+R1g6eZt+0M8=;
        b=CGsTuNWvEa1VBRHvwCMBizQg3XADo3xgonSGwvST3Dncq9OBIYOkZ0FWOCFVJgXQhe
         m2wnRzuojllNPOGeHQ45TybdElsrWnqP2ciSb7UUIZFPNF1cLF87bCPZTr+HNchQsrOu
         Z077vd/2bL9JV5X+O3+QJSul/AZitMOvZPiI1s8pP/ztQcKMgold/aY4KyHIjB2cQ5zd
         fVA4sW4rxiwqJyKxx9YABJPp6w56pMIaHxK6q3d2DW78eLdXTae6h5abFcFsAhAfl7bc
         bas18uqmxtV+UlHEAmYs3mG8JTifi9GyGmoSqbQ/ihwe2i5yvZrG0aoS+7VMx2UI4kPa
         dZ7w==
X-Gm-Message-State: AKaTC027AZv+UZg5OpCuGRoHeM5GFtSgcguM4Gf2ehNFVatCrOtad5ztc95uEJnVvAcXDafuyCisfz2/BdzJUjQL
X-Received: by 10.55.16.147 with SMTP id 19mr34515349qkq.255.1480618296941;
 Thu, 01 Dec 2016 10:51:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 1 Dec 2016 10:51:36 -0800 (PST)
In-Reply-To: <xmqqoa0va3fw.fsf@gitster.mtv.corp.google.com>
References: <OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de>
 <xmqqd1n0552i.fsf@gitster.mtv.corp.google.com> <xmqqtwgb52py.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYS=XWBpEBJsj95FV+j+HLxg=5xqwD73618t7ERYrKUfA@mail.gmail.com>
 <CAPc5daURyXO6-yaOWPhvvdS8Dr5psEEc8MVP4wQJ_AuxyZraRg@mail.gmail.com>
 <xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com> <CAGZ79kZSEan5uXCUn4iVCWEc9zohMSr+UDyHDyQUHz84H=tR8w@mail.gmail.com>
 <xmqqoa0va3fw.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Dec 2016 10:51:36 -0800
Message-ID: <CAGZ79kbSApFA3G2nKjxJdyxF=YFzodLVwuYMhKy9fm9359frNg@mail.gmail.com>
Subject: Re: Re* git pull --rebase should use fast forward merge if possible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, neuling@dakosy.de
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2016 at 10:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Dec 1, 2016 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> +test_expect_success '--rebase fast forward' '
>>> +       git reset --hard before-rebase &&
>>> +       git checkout -b ff &&
>>> +       echo another modification >file &&
>>> +       git commit -m third file &&
>>> +
>>> +       git checkout to-rebase &&
>>> +       git pull --rebase . ff &&
>>> +       test "$(git rev-parse HEAD)" = "$(git rev-parse ff)" &&
>>> +
>>> +       # The above only validates the result.  Did we actually bypass rebase?
>>
>> Good catch for the test, but I think we can make the sed regexp simpler, as we
>> can leave out the second "[0-9a-f]"? (git reflog |sed
>> "s/^[0-9a-f]*/OBJID/" works here)
>
> This mimics the existing tests around there for consistency.
> Simplifying or cleaning of this test script as a whole is outside
> the scope.

Ok, in that case the patch looks fine.
