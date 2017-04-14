Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D12332013A
	for <e@80x24.org>; Fri, 14 Apr 2017 23:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755544AbdDNXuI (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 19:50:08 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33854 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755449AbdDNXuG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 19:50:06 -0400
Received: by mail-lf0-f43.google.com with SMTP id t144so46992040lff.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b1D5GJLeURo1TskRK4Y63obNZvRYuFRd4mavAiEVBbU=;
        b=VKqgU5v4MaD9h3+wBiPbzBPPMETu6rMQUkgdlCzDmdMIfhmRmO96WEwSe3yKl35Jsj
         OhwzH9nhpQAQDP20n7cvBOcBc3/YU3Dt7scwb0tzQGdfQ43qnMQLBkCBoXPmF7GQbf+l
         Nx9C70xi3RqbnESkFXDZm2Qqty3pjc7GzR7ApGCcd/p9BFtkDwldrVc7EnpQInERMRkQ
         3epQunMd8a4z8htuVSHA5aC8+Y6jr0HDdFMmozRj5Gb2473QdepC6T6wnOrTg62WE02y
         4Cu01NfIeXGvwKhK3hqX4j8ZMp5kfq5YMRNDxo8GEoNBiAOgr83Vh80Qv/hT4n4AZNJs
         5tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b1D5GJLeURo1TskRK4Y63obNZvRYuFRd4mavAiEVBbU=;
        b=gfPyTGLi9DngrwJAuB5YH82fu1RlZAGM1INhH1MqncSLpoCSagr+bsi0AJPqp44HdP
         5YwOpZ/qf5lVZfQMMrb/IfjwQXLtBpe7o7dS4/0Ao93Lwr0z/QSTmY5OmUJO9CP59NjT
         5XxyjCS5CM2w5PhIRj1KQpLqGAC5e4KBAERO3dOATHc7xs78JTDniGztHMUcOGykIXUN
         T+RI+M1WW0fPM21wGX2uU4CLmAzyB/M/70U5q4h2OuD8EQMTPcsJiX4DwmQ9k2R4wxVA
         TVvwFaUok9tNq9CBzMHxVSnWnjFDO0vQWgQZ2n3qwlgp3Sg/0V6GTeOEKwxImIIbmpg4
         +ESQ==
X-Gm-Message-State: AN3rC/5PauIw7Be59x+p895BctTOozlMyEi+Gujmh/G5UaCF2WH7qH3G
        ocmVSyN8R1z2Y8lSXTsjJbXbDkxYNA==
X-Received: by 10.46.22.10 with SMTP id w10mr13959ljd.35.1492213804838; Fri,
 14 Apr 2017 16:50:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Fri, 14 Apr 2017 16:49:44 -0700 (PDT)
In-Reply-To: <CAGZ79kY_Faantt9s3aBrWk6F9vDaKidjYpWt0be00w1vXu9PWg@mail.gmail.com>
References: <20170413171224.3537-1-jacob.e.keller@intel.com>
 <20170413185707.97746-1-bmwill@google.com> <CAGZ79kZ8KV+c2StKR8tp=s_E1+uEaSezgsmUfyyO9HUrmzdT+g@mail.gmail.com>
 <CA+P7+xp=1PUsq1_or=J8ED+-1NMaF=BckC9bK4jqWbA+RFeszw@mail.gmail.com>
 <CAGZ79kaRTrgHMnP6mA3V2rDHzf8iOidqLTpp2aXmi6x+6YeZxw@mail.gmail.com>
 <CA+P7+xoY-FFXEkPgQBA4=Twq+G5YZrHkBqiO+sKHcGJe7xt7vw@mail.gmail.com> <CAGZ79kY_Faantt9s3aBrWk6F9vDaKidjYpWt0be00w1vXu9PWg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 14 Apr 2017 16:49:44 -0700
Message-ID: <CA+P7+xoFNve37_QOwQoicSm0B1ko76ntHrSMHZnCi5=4Bn2twg@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 10:02 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Apr 14, 2017 at 9:33 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> Never mind. git ls-files doesn't support showing files for a specific
>> ancient history. (I guess you'd use ls-tree for that?). I'm guessing
>> we want to run in the actual work-tree for ls-files here.
>>
>> Does "is_submodule_initialized()" going to ensure that we only operate
>> on a submodule that's currently checked out?
>
> I think for that we rather want to use is_submodule_populated.
> And I think it would make sense as well to check for that instead
> of the initialized state.
>
> Thanks,
> Stefan

Right ok.

Thanks,
Jake
