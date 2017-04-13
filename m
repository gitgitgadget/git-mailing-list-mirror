Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDA120970
	for <e@80x24.org>; Thu, 13 Apr 2017 07:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756185AbdDMHUn (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 03:20:43 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35223 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753286AbdDMHUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 03:20:41 -0400
Received: by mail-lf0-f44.google.com with SMTP id 75so25202380lfs.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wLScsaPfNHS3aElyTEzGnit2P3C2XgLNW4FLrunvN7g=;
        b=BFnTk8mzyRlSzaUK0A7kIQPdScyDhp67mD3SR0sOsX9OpH7KeR505go9pGbbVv7x3t
         gSxcmcti00gDld0BbWnnavFjo4dXPXDwe9BpbMq/NCbOvWKPeIw47IkckDts3RiP1pMX
         qJ/Z2XPQwrizXyHIGDJomoKXh64m53Wn0wrC648DsLp9+E1cIRDLR0bffOJ4JSwjn9Lc
         S+p+SNpvYhSrvcSbfscJay4V2V2/RzKBnYj2MGmI78maEJ6LPwGyvUi+GhXqENlQ34J7
         YUaGOlq0hanQZ+xQlNI0vCS9DHqydyxMBAIvOfbrna8nUCZSqj+9i0GC3Crwdo+Uu1xa
         rUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wLScsaPfNHS3aElyTEzGnit2P3C2XgLNW4FLrunvN7g=;
        b=B5BKoTKDUGzcA903pH0v5B3Sqqd+xqkR4trm926Kw0TO+Mvo+7C9QQMyjDHmtYIvMn
         l7ZczUpv2rOCI38Yb8rrxuqwgPNnGaVoRi0BtPcpmvPmQPxfpOlDTlpBUSYzxJtpYgZz
         xsgMfsO9gwA8z5p77emijzHyDliPgh0W255cI+3Wk/umIq8WHnKBtr+c55EcXVm1giQ2
         Jm3kbPxXEsCZWk7/d8l0xvsRCTtF5nItObrruq1jckzxc6UUddmEOBcMbZictUP5dg4n
         410LLqydV6qkWNZ2ylneDxtLt/POuKX5MlrUAXNtWwD27HNcut4L9Y80xdr4kawQiz2h
         gjEg==
X-Gm-Message-State: AN3rC/5URNceAk7BHeyUqB9KMWpB7DgYpN7qSO0RR6DNtVeXG5y8wvtB
        FmloUVhS3+Roqlw1764bbG+fmI5qV/c3
X-Received: by 10.25.216.212 with SMTP id r81mr591972lfi.66.1492068040158;
 Thu, 13 Apr 2017 00:20:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 00:20:19 -0700 (PDT)
In-Reply-To: <xmqqmvbkq1nn.fsf@gitster.mtv.corp.google.com>
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
 <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com> <CA+P7+xr37owZbCnwVKh0y_vUny9_pP380Y8sFA+7A-hv0Oc6AA@mail.gmail.com>
 <xmqqmvbkq1nn.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 00:20:19 -0700
Message-ID: <CA+P7+xqu1oB2J2C9OoqaYAwdNOXT7f0kvHEHHZ4nXaefewBrNQ@mail.gmail.com>
Subject: Re: [PATCH] status: show in-progress info for short status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Personally, I would want this to become the default and not have a new
>> option to trigger it. I think we could also extend the porcelain
>> format to include this information as well, but I'm not too familiar
>> with how the v2 format extends or not.
>
> I think the general rule of thumb for --porcelain is that we can
> freely introduce new record types without version bump, and expect
> the reading scripts to ignore unrecognised records (we may need to
> describe this a bit more strongly in our document, though), while
> changes to the format of existing records must require a command
> line option that cannot be turned on by default with configuration
> (or a version bump, if you want to change the output format by
> default).
>
> I am getting the impression that this "we are doing X" is a new and
> discinct record type that existing readers can safely ignore?  If
> that is the case, it may be better to add it without making it
> optional.

Correct. But either way we should be free to change and extend the
non-porcelain format without worry I thought?

Thanks,
Jake
