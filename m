Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0102027C
	for <e@80x24.org>; Tue, 30 May 2017 23:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdE3XcC (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:32:02 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35708 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdE3XcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:32:01 -0400
Received: by mail-pf0-f176.google.com with SMTP id n23so682536pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2QVcCL8mcPAzmKxcwhjsxKRf0enG0eAPKDaVQLrrY9s=;
        b=qSGR3gqJXGbL2xi3rTSKsGconhcPfLuK068RU6vtYN4SZ5lbrciAtn1guYXot+oFZV
         k8ifOZnyDDVBkv+GR0LbTJZglq6AnCv9BbwJf7l+Qt00Df+97b0hxM/ZOSrxGyEQ3c/L
         KvXQSqzOb1Rx2PV7FJS18Qw+dx5cmY5VQNoVGt8FhDHsqf5xX6HUlPbPBwyDQTddxQ10
         bCfgSbJgUZisP9a5ZMSTsBB3aCNAsmgF917GVwaWVsz4O0ksD89CfTDB/WannK5IUstA
         w7aDoW4nIECOZf1zUi7uEoIUVIgu15+xLJM5sAEanUtEhe4kaz/dALs1K8d1SkqgBNAU
         s0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2QVcCL8mcPAzmKxcwhjsxKRf0enG0eAPKDaVQLrrY9s=;
        b=UW/sGnTDbfo1D33cOiAqsjE3ojfOQ0+MB1c+3cCNj2nBj+Lo8dEG9EUpg/tdYmngZW
         IEGrt4yt68DutkkwwGDxwauawCXVkB24fyYSc0jNWDHcnaVSvXkELXCnz0jrK/I/c5AQ
         6lunUI7LuwNVELLSqzDqdX5qOOvDzygKqT0DiuUsZYTMphyZ7/0NuqnlOcQcn0CTMmzF
         9fY8RxOIcIiMKrxxEuwjWclWvB82BhVfip00fnYAO8DKeXgiwTGHEijdsGzxlz98dCrh
         Mx+AzfHWt4NFFqZv/h7E0KmAuqyMCUfXe4cmc4zqVmIIRvVd089DaKLx4JDD9MNS9PjB
         sqTg==
X-Gm-Message-State: AODbwcAwe6taXneQ68dhU137ygzFGipbiSp0DfJJWIW9CPRKEBEogzqq
        6fCuFCU7vZHPjTkPjdCeovmCdmksdZml
X-Received: by 10.99.18.65 with SMTP id 1mr29225389pgs.40.1496187120604; Tue,
 30 May 2017 16:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 16:32:00 -0700 (PDT)
In-Reply-To: <xmqqo9ua9btk.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com> <20170526033510.1793-6-gitster@pobox.com>
 <CAGZ79kb2LJ-aqDq9o7Z015aNYo0zoK5DdwDGyABOe1V8ifF2wg@mail.gmail.com> <xmqqo9ua9btk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 16:32:00 -0700
Message-ID: <CAGZ79kbnV85dZ8jQ=eaQnMSphBvy-6VJcJHv4R=G4sA9YQ6d3g@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] config.mak.uname: set FREAD_READS_DIRECTORIES
 for Darwin, too
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, May 25, 2017 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Do we have any reasons for that, or pointers on the mailing list, that this
>> is a good idea or needed? Does it fix a bug or enable a new feature on Darwin?
>
> BSD lets you open() a directory for reading and hence we require
> this workaround on it; I think somebody in an earlier round
> suspected that that Darwin would have inherited the same from its
> BSD lineage, and I don't see a reason to contradict with that
> suspicion, either.
>

Sorry about not being clear:
I - just like some future reader - did not have the context of the previous
round, so please put this information into the commit message.

Thanks,
Stefan
