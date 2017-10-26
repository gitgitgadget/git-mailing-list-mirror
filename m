Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80912202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbdJZVpa (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 17:45:30 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:56237 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbdJZVp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 17:45:29 -0400
Received: by mail-qk0-f170.google.com with SMTP id x82so6123480qkb.12
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8zd+TgrFLUusZ03ywPLCMvRrHNElJwwoE76wpwJrX9Y=;
        b=GGJ8r+jbxZe4L7cEjVzKbzzHwwCy5czDDsASszYhI7gaWMaGyGq7vIJfholibRqnLx
         z5YOVKg3WvKfyXcIof5xU18TNrxaFAxZxleSurNEgIF1wKpIZitkWVAsXtxaG6w6x3Ed
         6Es/nsDeBeGH3Kn0c1tAS6RMuDdOJkT9dMDvNLzVygBKbi22gm84E7bxJDBkWUSJxrVm
         aP482AshuuuYF06TTnwxqDV2z6v9kirfVuaKGExyvdp7biXTQ5EoqqSOugcwEnkumfq4
         +a7aYsvm8iMigsywyfUp1NRNLKPg9FiCYrW4uBSKbeJ/RWb8if2hWqG0hIiySTojcp8O
         dJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8zd+TgrFLUusZ03ywPLCMvRrHNElJwwoE76wpwJrX9Y=;
        b=cq2L/s3S5W8Po4Y3wiZPhq7EHOJ955EPjYwvpf3E36ItI3Z3FVbJTsjyI0uhFKeQO+
         ZIv6wcMmniIq/t5CWf4D63Bd7cC332dwjMK0WKM/wYNtc69FUl75Wr6pQtF6lScAYx8o
         aWGbtAot8mI1mcHjH/NmhILbvv0nGDXMkfilcdJNVhrXtNY7lH7Ht202/11BI/laWOeO
         qs84FjzG9ug2H8BERNVjXX4VHAqAvl6W7c42NxakA6bTTqeaDnoHRxnnVb3D3LpO0u38
         GqdopdHZ4q4qu/3TPY2qBJ0u3IKdK6ohODYiz34BQtnknaUH24AmMRYwVyN/+DodJJ3v
         TCgA==
X-Gm-Message-State: AMCzsaVAtamH+c14SVhekd6jC1yOvBgj4cvmPbaZvAY2zlq1Ze7Q9Kgf
        JQU98W8RX7JznJCbGw0JhJMN4J2AK7e/Gi76aQ258w==
X-Google-Smtp-Source: ABhQp+Q3X0H1mhzoJXEzxeD1rR5vEiQUSmrsPnGf86e2Ne3IQkYyMmgHK+/Q6QkFVvLgcspvAJHvuYT+iAvGXW177ew=
X-Received: by 10.55.175.132 with SMTP id y126mr10742690qke.45.1509054328859;
 Thu, 26 Oct 2017 14:45:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 26 Oct 2017 14:45:28 -0700 (PDT)
In-Reply-To: <20171026213337.kbmwnaxlsyubat4w@aiede.mtv.corp.google.com>
References: <20171026195516.3354-1-tigran.mkrtchyan@desy.de>
 <20171026205509.2ydjd3bai2l6pqxi@aiede.mtv.corp.google.com>
 <1113033991.3307260.1509051676201.JavaMail.zimbra@desy.de> <20171026213337.kbmwnaxlsyubat4w@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Oct 2017 14:45:28 -0700
Message-ID: <CAGZ79kZahLWdYJ2poi1QhMKaMQDNiJmQFe+M50HM-TfPtOx_iw@mail.gmail.com>
Subject: Re: [PATCH] tag: add tag.gpgSign config option to force all tags be GPG-signed
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 2:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi again,
>
> Mkrtchyan, Tigran wrote:
>> Jonathan Nieder wrote:
>>> Tigran Mkrtchyan wrote:
>
>>>> In some workflows we have no control on how git command is executed,
>>>> however a signed tags are required.
>>>
>>> Don't leave me hanging: this leaves me super curious.  Can you tell me
>>> more about these workflows?
>>
>> Well, this is a build/release process where we can't pass additional
>> command line options to git. TO be hones, is case of annotated tags
>> there is already option tag.forceSignAnnotated. However, non annotated
>> tags are not forced to be signed.
>>
>> Additionally, the proposed option is symmetric with commit.gpgSign.
>
> Now I'm even more curious.

I started digging and found
https://public-inbox.org/git/20131105112840.GZ4589@mars-attacks.org/
which is an answer to "Why do we have commit.gpgSign?" which is
a very similar question to begin with.

Maybe the answer is also similar (bonus points if the answer also touches
when to prefer one over the other)?
