Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9FB1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 18:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfILS7R (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 14:59:17 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:40184 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfILS7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 14:59:17 -0400
Received: by mail-vs1-f48.google.com with SMTP id v10so13691153vsc.7
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCPETSdTGVogHRNCHcqKiGoyqCMawe4dO8SXLB23lPU=;
        b=XDTuz/arOngyyFS5dp3zqIOW59/XVwAqjEHMWAbu/QgdKCoWXmXaU6R/+R4/BoHIPN
         HQc9r227amLomnWX7gz9NQJ4dbM5kDDgIB9N1baaDw9O76arhI3STgKoIIIeBYRjo7E8
         e7LrXPQnawcZGwwm5417aDVopyHIURSDgBzi0X37NxC2H4QCUATpbGUbH3yXXv9bN8XK
         l66/Kf1H6lFOugZqghkdoFUy+q4GqiCzr61RIHHnfbNldOdOsEJSLqRpdzmMjxXueI4I
         9hgAGhift9PQcvByoyHXGDJvNMEZ2Sh17EDS50nihP8Fif5aujqtaN7+3gDfZFRmyYh2
         o5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCPETSdTGVogHRNCHcqKiGoyqCMawe4dO8SXLB23lPU=;
        b=cQ1m9h9iHjRXVEegyNha8B4IanB/hhZZQj+cxYkpWfXP0uDxce2+uLiMD3TkZX2c1J
         wYDvG7in6DIXnQ2Z+wqxCjMdt0KWFpO//2oXdQbuz2rT2r4eIJ/stT1GGVr3sDdC63fc
         9R22rWh473L3jC99LzbiZjS5QYOglM7NoiMz92ns0MJizo9DU/wLvsnSZosnJ2DYVl8n
         kBRnAwJBSTfZd54FhpmcAxs319U8tVtFEBxfZ6rQJfzy4laiPQdPlBCsk9xX2yMBwHFh
         SXRzmnJ2I9FUhdn/AbTMHmWKvF8hkPk4FUqRWgCvZGAxPrdjVgeEBMJ52pTBpV7SOVlq
         WrcQ==
X-Gm-Message-State: APjAAAU2+jUhGpH/1lHAQO+0zFqLu0UC+jkPUp9b909yF0zk8OudPzQ2
        xQU1LC8iqEulzfgxhVG7RTP8a4uDQGPM27S3rtM=
X-Google-Smtp-Source: APXvYqx02YGEILj/G/CSMQfmWu7BdoLIPj39wgd3j+yb1OnzDlUXBlO1k25wvIAQ7oc5gBAK75gXfagiWdHE75HvE8I=
X-Received: by 2002:a67:c408:: with SMTP id c8mr19375023vsk.63.1568314756114;
 Thu, 12 Sep 2019 11:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190828215725.13376-1-me@yadavpratyush.com>
 <20190910192107.umew74b4mj2vyrd4@yadavpratyush.com> <4c60ce63-5eea-42b3-aef2-92dd04b1f34c@kdbg.org>
In-Reply-To: <4c60ce63-5eea-42b3-aef2-92dd04b1f34c@kdbg.org>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 12 Sep 2019 20:59:04 +0200
Message-ID: <CAKPyHN2fv4=QTE3iuToRVXk-g=T5UtCJj=dRLzty8=0BCz4W7g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] git-gui: Add ability to revert selected hunks and lines
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 10:26 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 10.09.19 um 21:21 schrieb Pratyush Yadav:
> > If there are no further objections with the series, I will merge it in.
>
> No objections. I use it in production.

yep, Since 2012 ;-)

>
> -- Hannes
