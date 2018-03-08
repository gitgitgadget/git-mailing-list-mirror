Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D481F404
	for <e@80x24.org>; Thu,  8 Mar 2018 17:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936112AbeCHRwB (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 12:52:01 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33045 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936048AbeCHRv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 12:51:58 -0500
Received: by mail-vk0-f43.google.com with SMTP id z130so379041vkd.0
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DrRIAkBLbfBAuJTu0PzbRw3t/GjEUrCo4Hn3VPRwnO4=;
        b=jXCZL8Mpvo2/cVI3t4qH1dDDvjxi2S7ybzDtO79M6+dT+th8R8kbV11BZxbmi8LQls
         WlU2sokFKo8Hi2vCEDCH5ONA57iAFXoWw045TpqmMk1MGa/kq63jfE288qWoTyrd1QUj
         ITM5kIAJDGMnsJW0dJNbe5umfB5tEH6EvpGtuH0wZ2XgoDVBVDpj0EHc/JmjLP75PLav
         EFDdswpR/l5FSfbAXWxwCmvtIX9hw1eq0WpX2WrxCfTezRoSJoMw54cfBTwtEYZxTUBx
         swxRKv7o1czUG7aslLbaXqRLYggIuLOBbv78VrM8onRvXJl9vvJzDLHte5h5vUM98t8w
         /uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DrRIAkBLbfBAuJTu0PzbRw3t/GjEUrCo4Hn3VPRwnO4=;
        b=Y72B8AOiFIF1c/Lonc6sYxLi9EA0xF6s2VSe6Re+AJE6GXnwJ/vUjotrWqPtc2wDOw
         zjdhG7v6E7U6wBKjXu38l4wqfxVQao9ibRgm6FMWssJ8DVJY0UFtWLjgDBea/xOW4h/H
         29vOJXgPUyvdrm7U1GFh/u06nJet3P/rpJJYnIraEBpt6Md+81TUzlwkfzbWXWjkCfCI
         gnpDRrNn2Bne+n1UXMS7VWPEOZuScsBmNGXghO6ChOYXmpYOJ9lsOtHCXFM67J5oFzr3
         XgDwHRFqy1Q8V+67UB4Rp7JEBJBlsO4tvkeQivNNyXmXRKs3vuLnIzWDNEiCz7KCOCyR
         DJ6w==
X-Gm-Message-State: APf1xPANdaA9RipJ8iYENnNMtowe2UqeWLfsN7O0/8FuWhOzStaqR1Dy
        IKcW/avb9adt/wJN70oaMFh9f5w0Sb8BgJ/w2ws=
X-Google-Smtp-Source: AG47ELu6lU+0ukDpMJR1zkaIb+efK/F/qbPLq/e2zeFOLUAXfB2sRGm5g3FhjGC2Rx2A3ox6RAaMIRCTJV0X7ayQyao=
X-Received: by 10.31.204.5 with SMTP id c5mr19256122vkg.76.1520531517309; Thu,
 08 Mar 2018 09:51:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.49 with HTTP; Thu, 8 Mar 2018 09:51:56 -0800 (PST)
In-Reply-To: <20180308122523.14434-1-szeder.dev@gmail.com>
References: <20180305171125.22331-1-newren@gmail.com> <20180305171125.22331-2-newren@gmail.com>
 <20180308122523.14434-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Mar 2018 09:51:56 -0800
Message-ID: <CABPp-BGO1m=OAbUS8RUKdqP+8p-DokzbjGa3TcigmTSSa_r3-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] Add testcases for improved file collision
 conflict handling
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sweet!  Thanks for taking a look, and for spotting lots of
improvements (and some really embarrassing errors).  I'll keep the
fixes queued up while waiting for other feedback.  A few comments...

On Thu, Mar 8, 2018 at 4:25 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:

> This setup test is enormous, and the conditions for the combination of
> the two sides and the add/rename conflicts are somewhat distracting.
> I don't know how it could be structured better/shorter/clearer...  I
> couldn't come up with anything useful during lunch.

Yeah.  :-(  It's part attempt to test these conflict types much more
thoroughly than other tests in the testsuite do, and part attempt to
keep the test setup consistent between the types to reflect the fact
that I'm consolidating the conflict resolution into a single function
as well.

Two possible ideas:

  * Split the tests for "*_unrelated" files and "*_related" files into
separate tests (doubling the number of tests, but making each only
deal with half the files.  That would make each setup function about
half the size, though both check functions would be about as big as
the original.

  * Instead of programatically generated tests, just manually write
out the tests for each of the four combinations (rename/rename,
rename/add, add/rename, add/add).  That means four "copies" of fairly
similar functions (and possible greater difficulty keeping things
consistent if changes are requested), but does allow removal of the
three different if-statements and thus makes each one easier to
understand in isolation.

Doing both would be possible as well.

Personally, I'm much more in favor of the first idea than the second.
I'm still kind of borderline about whether to make the change
mentioned in the first idea, but if others feel that splitting would
help a lot, I'm happy to look into either or both ideas.

>> +                     cat <<EOF >>expected &&
>> +<<<<<<< HEAD
>> +modification
>> +=3D=3D=3D=3D=3D=3D=3D
>> +more stuff
>> +yet more stuff
>> +>>>>>>> R^0
>> +EOF
>
> You could use 'cat <<-EOF ....' and indent the here doc with tabs, so
> it won't look so out-of-place.  Or even '<<-\EOF' to indicate that
> there is nothing to be expanded in the here doc.

I just learned two new things about heredocs; I've wanted both of
those things in the past, but didn't even think to check if they were
possible.  Thanks for enlightening me.
