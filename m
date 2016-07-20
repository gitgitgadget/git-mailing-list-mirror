Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6581F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbcGTUyK (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:54:10 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38193 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbcGTUyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:54:09 -0400
Received: by mail-wm0-f41.google.com with SMTP id o80so85644616wme.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 13:54:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lI7LekS4wrzJg5d4yYqMaRjj4MxQqZC80jNKtCUs86Y=;
        b=E7O3JwbsUsNuBd5dkbKhtc4WA7Mc1i5L5H5amzXi6HqP7uv4ks/FwGPyxZEvlcq/yA
         KAsTZqE/V0ZNsCSKgwEUufq/kvEMhXqyrPbM8CA4oqk4Bg0TTyVve9qxNJx/EA6BPC08
         hMdmuDS2IS1FFz+6e2VwZppj5MfqW8ePjdzyV8sJmlZJ7348Kk65QUz7y4aMzs2smLRH
         K93gKm7Ei+ZuZFs/dOl0UBUe1cW5QCy6Nsn5ptccS7mfW7TCPB4P+lSs3exqzOcao/Hk
         PZ35m5zawSK8Yj0EwJDuhWOFauayAp7rMgfowjx+yO+AUk1fAe0mrJJegkdnKubp30tg
         Sc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lI7LekS4wrzJg5d4yYqMaRjj4MxQqZC80jNKtCUs86Y=;
        b=aJ0Oany7xxFKzvUEANvS7wG1feCsnuEXjHvPuIip/qr8YGN7bPw7w8bArcPvGJk96s
         ONIl/YneTF2O4ZKVOBs3xTIClBflC7SgenaP1/WCuj79j+fhp+Ky9IWYV0eIKkIKOOBD
         /aEKXTTGrkVJIGL5gyE01hLMCER/fdQga+ztOMU5RgHBPsLjujwqGsa+dkW3QO6WTDzw
         xnnFxbkoWLUoUCNAzHnRWDRpyNu/UZjgjM6nUCyvI/Y2UDg+dcVeNvOeIomJcu4Ly1kp
         VI0mq8UbrXNCQ8LzKrfP5I4WIlQFX3aLgwBiUE1b8q8vqdrKI8sGVy9P7gVgncjvfis5
         p9xg==
X-Gm-Message-State: ALyK8tIDs+yuiAI5eASYZxTHI+cuuztdAPLbPv7c5sDtkbFMxrRP75e6/Z8bNIUwYuAbd3DzY903L2xiNrFOkA==
X-Received: by 10.194.51.167 with SMTP id l7mr3232385wjo.78.1469048048083;
 Wed, 20 Jul 2016 13:54:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Wed, 20 Jul 2016 13:54:07 -0700 (PDT)
In-Reply-To: <CAPc5daVyjuTquUbYixTNj3hkwNeGd0fsTBe7OmxnEfoa_S1dnA@mail.gmail.com>
References: <CAP8UFD2PjKHkcs-EWzDU6eWF9ar7BzOxRB838iFr6iDAaGnkeA@mail.gmail.com>
 <CAPc5daXoL+v-YWy-EQ=d-8m9o8twv6Cs5U_NL14KGzPMVNQUPg@mail.gmail.com>
 <CAP8UFD1TWYct7OJDcP+w8AYNTroquZ++T_1ovt-Z7SrBtn_S+Q@mail.gmail.com> <CAPc5daVyjuTquUbYixTNj3hkwNeGd0fsTBe7OmxnEfoa_S1dnA@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 20 Jul 2016 22:54:07 +0200
Message-ID: <CAP8UFD2p448LpQ1m+6LprurHZ-MJfWFo9NKFtQuK6pvMdiC4nA@mail.gmail.com>
Subject: Re: [ANNOUNCE] GitRev News edition 17
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 10:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Jul 20, 2016 at 1:38 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>> Micronit. 2.9.1 (or 2.9.2) would not be a "major release". 2.9.0 was,
>>> and x.y.z (z > 0) are "maintenance releases".
>>
>> Yeah, I wondered about that when I saw :
>>
>> https://github.com/git/git.github.io/commit/d2eb8fbbb30594d19fcda731c309ad03229dc5d5
>>
>> but forgot to ask or do something about it...
>
> As long as it gets fixed quickly, no harm is done.

Fixed with:

https://github.com/git/git.github.io/commit/5d50fd0d807d0f8046b712aac1492c30aea7a652

While at it, a maintainance/maintenance mistake is also fixed in:

https://github.com/git/git.github.io/commit/ae08ca7689b4bc0c55b87edd27641fbe721e3220

Thanks,
Christian.
