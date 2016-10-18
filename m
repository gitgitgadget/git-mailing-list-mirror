Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81AAD20988
	for <e@80x24.org>; Tue, 18 Oct 2016 17:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965078AbcJRRRr (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 13:17:47 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35025 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964785AbcJRRRq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 13:17:46 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so229766qkc.2
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jMV2uE2lqZvzi2QQiTaVxBcS4ypjVgCZ3hgHImIjm2Y=;
        b=gjQagRj3pxHy4TSvInZoJtfFdvyOh0LpBAgABPhGGmKUocB2eLW0mm1KrQ0NSdxK8F
         bdlKpZx6+LMzR66bCnL6DsOlM+sAeRI3Fa+5kNfG9e2VQTjUoQSlxySY/xMH9Jiz1bwQ
         EmsqRy2VT3NrIs2Sqm3esNj47Q3J85SSvZqwfB8+xy6z5SzeojEE9ZaEERtd/9jbegz3
         sJqDQPMkWCYjWiCNZyDWpUYl/aULOysm3FKBQJpOR/FoK/pNEJPRMxeS/QvdroFk1z8v
         Q7bGXhzNJXEv3xNXLP33d7vr0xEA1XTQ4jJcKy90++nK6IiwYnAGUWDx1VepnM5wOYve
         IzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jMV2uE2lqZvzi2QQiTaVxBcS4ypjVgCZ3hgHImIjm2Y=;
        b=ErlkQJFUDw91NpVi03v0dYZnV31IeTvNHEnCkn34fO7BjpJPe9iQpQy/tKYIuOEbTf
         eMGAL2oBx2c92jIqgnC+nN16VcWxng+gMEXidT0bhte1hU/IXdkXe2Xes2a6pG130So2
         sHjGrbAxQFFvAFHeK57v2CXlH7czXUsvxYx5OTHuthJu78TpUfojFLcZbVLlrjvmZxr5
         zgoOsmASzjN01FzQdKYNqd0wSdyggd8uEh4TfPqBLkpjhbyBCoboMdnKXLWnHJav55zN
         stDmmnapP2crAo9uA8y0davf4GT8tAL1gvonIK87iE0RIDzmIqKrUhLiHGn3NyQYh2GY
         UMMw==
X-Gm-Message-State: ABUngveIuMmQgBhBiI1UpGk4cEzH2/fhZRNuE5CdV0ryroqTfa/afLiRWVY0en11boFOAOelwxu2N+RoZuzcT7uw
X-Received: by 10.55.56.11 with SMTP id f11mr1535381qka.255.1476811065253;
 Tue, 18 Oct 2016 10:17:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 18 Oct 2016 10:17:44 -0700 (PDT)
In-Reply-To: <xmqqr37dpoip.fsf@gitster.mtv.corp.google.com>
References: <20161017221623.7299-1-sbeller@google.com> <xmqqbmyisiae.fsf@gitster.mtv.corp.google.com>
 <xmqqr37dpoip.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Oct 2016 10:17:44 -0700
Message-ID: <CAGZ79kZEFanPpdrE4sD64LJHmyrBiHafo1VzoGtoGh+wO_HCuw@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: normalize funny urls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 10:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I also somehow find the "check-url-stripping" variable ugly.
>
>         while (URL still has something that could be stripped) {

for(;;) {

here ? (this code would not need a variable, and
for wins over while:
$ git grep "while (1)" |wc -l
107
$ git grep "for (;;)" |wc -l
128
)

>                 if (ends with "/.") {
>                         strip "/.";
>                         continue;
>                 }
>                 if (ends with "/") {
>                         strip "/";
>                         continue;
>                 }
>                 break;
>         }
>
> perhaps?
