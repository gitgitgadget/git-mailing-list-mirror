Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 614A82018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbcF0Q50 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:57:26 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34149 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcF0Q5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:57:25 -0400
Received: by mail-io0-f180.google.com with SMTP id g13so150294256ioj.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 09:57:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=etDg3MsGqV7uj6GFF/aTnVEM7I+ncDiHuSiZSDq1O9o=;
        b=U2iTtuw/wRf1Ov2OMTFFAZbdA51LApHCVm0EuMOugplekrJYcyussn1YoF9t3Gnj1D
         FUkNiJv2GuYLdBAkmfbvL4dxHccH4oM3GJ6jXQI392bOw6iJMTRHalXNQaZ4IAxdcEZq
         Wgk8j45Sb8cmKfk6HCiLZEcgqY5uTuUU/g+MRfjJjzQ2wkmjb9MILoQ5qsVFYNsKJG9H
         +Tf8yX27fSQE+qn6QgYsB+b2wR6IrVwMAqGMx7qsOYPOTmNAUXFTVM2pqxgqrP7CrIcT
         MAOuDFX7ywLM1sluGSn99JSI3Dg7A82IeU/CLXofXnyVDbvLCl0RstjwL/je85gR8qrt
         28Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=etDg3MsGqV7uj6GFF/aTnVEM7I+ncDiHuSiZSDq1O9o=;
        b=aOj9PW3OTxJ9Lbmhoag/MsCf+8iwAvJzEvoSVz3eMxy2+LSJ5swesLPz/HOMcitbsu
         CMdQYo1cNxm2rJsCgdFVP96IQRSSvpyZ3/OvoT9UTptWvBtMoIxm1v6X246Y1kawrsNW
         eFosjU5GvDAf9JK6+y+qFWU/5USczy03K9KfsC0UTRt2QDGAzBRkHSa8xKwo6tJdr3qh
         pSVpBrUDQW3T2UuRGunxWz5NvBg+m4AVruTvDpqkxleQCWNyB/ooXIeR6NnHRap37QPy
         BQ/niq2QKGDd/30auPx6sQ8RnMz9dIjNKlcyyA4HYGiklJoBFN8oKseINAHfWzArWGaE
         FGhg==
X-Gm-Message-State: ALyK8tLaOQ+jNpMqC80GQhzu6bsF52sb/fBreCWz9gceNLJDwKS5+dRbhUdnYQZRoJL+rVVDOcV5a0zzt0nxeL99
X-Received: by 10.107.178.4 with SMTP id b4mr1779062iof.83.1467046644732; Mon,
 27 Jun 2016 09:57:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Mon, 27 Jun 2016 09:57:24 -0700 (PDT)
In-Reply-To: <CAOG-3GJdH5q9fdj+7zdEv-UUZMTAnunZu1PRJYjFNV360r6+sQ@mail.gmail.com>
References: <CAOG-3GJdH5q9fdj+7zdEv-UUZMTAnunZu1PRJYjFNV360r6+sQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 27 Jun 2016 09:57:24 -0700
Message-ID: <CAGZ79kYKBxL4xLyySALBv_-gqkss9_iCk-qSc4T7u7fKDMOFWw@mail.gmail.com>
Subject: Re: Git mv -- submodule -- recursive
To:	Bart Bogaerts <bartbogaerts@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 11:01 PM, Bart Bogaerts <bartbogaerts@gmail.com> wrote:
> With a repo structured as follows
>
> main-files
> |- submod
>     |- subsubmodule
>
> git mv submod newlocation
>
> does not do what it is supposed to do. It actually breaks the git repository.
> It can be fixed easily.
> A complete description of the bug, including a workaround, can be found on
> http://stackoverflow.com/q/32782382/2274140

Which version of Git are you using?
I think this is fixed in a127331cd81233 (mv: allow moving nested
submodules, 2016-04-19), which is first included in v2.8.3
(or v2.9 and later).

Thanks,
Stefan

>
> --
> Bart Bogaerts
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
