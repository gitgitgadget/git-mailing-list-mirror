Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946731F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeEQWjj (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:39:39 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:36531 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbeEQWji (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:39:38 -0400
Received: by mail-yb0-f180.google.com with SMTP id o14-v6so2041769ybq.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ErAqJgmUmUcJqegH4wScLETQnIikmvKXP1DnFHX2RF8=;
        b=dc8WB/Zu3dhdPI4lEPz6fkYuCM0nytaMNlK4jjiEsovlsKFe/ZgOLbSkQoCEdgIklY
         n8rvbYtjhwCWaUvZlySwi7ECwr/eD893mqp/x/WjFNPrC3caUtpX7SyxOKXSh+qqYMXg
         rhD82supl91NazrmuQbqo8iP2c+WFebs2MsJ3erFx6vdotafy4xlch+4FhagS0jC16rZ
         OVqH8vPIN0NE0MyDOJa+LCveGodTWZxIuyMpR37NkyEJRBRMW0tagNnfvKURTKAdVYyv
         H0zvnLKIG95OhiKCb0MADJnmjPcuev7DzHnXrWGygJCuvGFcgl2c6fxbZ56iUjTezh5z
         X/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ErAqJgmUmUcJqegH4wScLETQnIikmvKXP1DnFHX2RF8=;
        b=OyBtM9PQqm0NgwKutS6JwE4DYC03C1EsTXxqYlFvxl8Q0V8jkbfj3qaG8c0rdX7O/p
         KPcrdvHL0FdAkkcpN+hU0D7iEk+jjNsupcyVPFXG4+zStgfo9vvsV6Nlf7q+tryMz4tD
         3N9gPCdVXIGb3BIYBTPLqditj8E90Uyk2fx6JfeDebAiLkfH6GfVAxxC4vLU3/nZG4Yn
         6CDy9bmPRD+LRR7mfbcF7K0jtgZdwQvaE7V0KH1KrsHQvFKoyvWtQId/HtJ1AEfx4E8N
         LFW2qGsfPn2QSzNfPWwHtxHm9E8MTpqkY/frr8JC5NlTgFVB8UhdvM+LYmf8Zjr+av9v
         LbAA==
X-Gm-Message-State: ALKqPwekVp/xuWuT2aRys6bB72iirCWvcas7qTU/iszsFkug+gBY+9NJ
        LuidnKbDh4YNuRZRZbjWpYOFfIKmBSq0bmSi3tnoLEJ1
X-Google-Smtp-Source: AB8JxZpFk9heC46x/jw5FqvJRYSZBsD8oCO4a3ZjZjfMFt8qBiuBErSSPtHd2e7chKxk9nsD1+rVR8xV5+cI7qsgMXc=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr3951139ybc.307.1526596777472;
 Thu, 17 May 2018 15:39:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 17 May 2018 15:39:36
 -0700 (PDT)
In-Reply-To: <xmqqbmdd6hb5.fsf@gitster-ct.c.googlers.com>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <xmqqbmdd6hb5.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 May 2018 15:39:36 -0700
Message-ID: <CAGZ79kbUXz5fgvSF20UZQbhByq-UcZHR81d4UFAcvASqQb3A-Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #02; Thu, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 17, 2018 at 3:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> * sb/object-store-replace (2018-05-10) 2 commits
>>>   (merged to 'next' on 2018-05-16 at 41bbedcc81)
>>>  + replace-object.c: remove the_repository from prepare_replace_object
>>>  + object.c: free replace map in raw_object_store_clear
>>>
>>>  Hotfix.
>>>
>>>  Will merge to 'master'.
>>
>> Please do not.
>> (Or do, but then be prepared for another hotfix.)
>>
>> The commit sb/object-store-replace^ needs more free'ing and shall be
>> replaced with
>
> Please do not replace what already hit 'next'.

I missed that it hit next. Sorry about that. I'll roll a patch on top then.
