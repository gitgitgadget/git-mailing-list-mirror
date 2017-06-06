Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AD5209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbdFFWct (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 18:32:49 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36077 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdFFWcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 18:32:48 -0400
Received: by mail-pg0-f48.google.com with SMTP id a70so32000433pge.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mbiOm619Fu+uPmj/WWB8DxEQNQQRcDzDM1wQVbfE8Rw=;
        b=XbJBPqL3RElmOs9Wlsv+jG9dwl3stagwdGy8Z+ai4mFfv2Zpa5tl7O9LU2PYcabFSi
         x+xrUkBO+vOO6L+fDKz3ogF0zEKIe+Aa6jfybn8gI2GGSBl30fw4wPoYmwx8xiXfWQ1I
         ha6VUHTqbcZzaIG1GtZ6pBTmApnislWTjxJhpUpxGaGzoNA5pUl7Zelzr1Pn8azv0uwL
         wXBlhLBkw0UjYuX3HHN8+YnOLZgpusdrUAnreG3eBbBjAYgdx9wwNg9IoUk9A/bW/gA8
         Fv8o73q6MixV6Qlbw1jthYZMScEhv13KiV1uU7AQi99FIe+Z9fHWzvNwKekqz37dhtq5
         b52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mbiOm619Fu+uPmj/WWB8DxEQNQQRcDzDM1wQVbfE8Rw=;
        b=d/kCjrpvTpI1hHFtG5HHecJH0CAUaqh1BSSYw6mhfyD2qIekHE76E3PuhRBJjLUrO/
         AuK0R5ik+4wGCMsAVlSP5Tc+vSwECL/QJaDhnd8pCojo3ooAZCeEGr0aPpMiAWAeFqGr
         u8Dc0kiGLfH9vyIMhc7xk0MTHb3p1emG7LAHjtfd0sFK3aXGaV8hE/PYUfoc2Mgq2Zce
         vGK23WgDHKCCkWEEtSKELW8mrngi8AJC3o7vjdYslnhraqRlyOW8NKt9BDMub5iU15fL
         QGzu+XWhu0uuZtkI7ecPjz/rYi2Vli2/qU/SrCW9myr5Hxrbs2LR1OrTmfjcF0DcL0ab
         u1hw==
X-Gm-Message-State: AODbwcATQNRZd6+w+aJjN/AQJH+XCmwJ59M7MzSKeZP2JWFGwmowLVHA
        34o/b1E5Qiy9Og==
X-Received: by 10.84.217.73 with SMTP id e9mr12745790plj.133.1496788368217;
        Tue, 06 Jun 2017 15:32:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:411:1ad6:6716:25ff])
        by smtp.gmail.com with ESMTPSA id 81sm790813pge.46.2017.06.06.15.32.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 15:32:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Davide Fiorentino <davide.fiorentino@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: How to avoid "Please tell me who you are..."?
References: <CAH8yC8mjTXQ_5uRedHi=fytKtQttyq_WemGFNQTP9C3PK4x5cQ@mail.gmail.com>
        <532E194B-3A76-4416-A652-4B1DCE78AB8A@gmail.com>
        <CAH8yC8k9pJHLuzWneb4aRAEF2zOTCVO_5YJxrCpw28x8bDox0A@mail.gmail.com>
Date:   Wed, 07 Jun 2017 07:32:46 +0900
In-Reply-To: <CAH8yC8k9pJHLuzWneb4aRAEF2zOTCVO_5YJxrCpw28x8bDox0A@mail.gmail.com>
        (Jeffrey Walton's message of "Fri, 2 Jun 2017 02:37:40 -0400")
Message-ID: <xmqqefuw927l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> On Fri, Jun 2, 2017 at 2:30 AM, Davide Fiorentino
> <davide.fiorentino@gmail.com> wrote:
>> Is there a reason why you don't want or can't set those details?
>
> Well, they don't exist so there's nothing to set.
>
> The machine below its a CubieBoard used for testing. I remote into it
> with test@. As a matter of policy, no check-ins occur on it. Other
> than the password database and authroized_keys file, there is no
> information on it to be lost or stolen.

One thing I forgot to ask you.  Are you reporting "I have used this
exact procedure to set up a test machine in the past and did not
have this problem, but with newer Git I get this message and cannot
cherry-pick or tag or do anything"?  Or is this something you
noticed with a version of Git you happened to have?

I am trying to make sure this is not reporting a regression, as I am
not aware of any recent change that wanted to make the "unconfigured
user" detection stricter than before.

Thanks.

