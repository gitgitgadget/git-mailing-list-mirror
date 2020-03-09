Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDFC10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DF4208C3
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 18:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iNinUYLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCISff (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:35:35 -0400
Received: from mout.web.de ([212.227.15.3]:53377 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgCISff (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 14:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583778933;
        bh=4mnW0bjSvFZ6fp5wMabBQtmv5NfXqFPd9bN3/gnKjDo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iNinUYLxT6RhmPJROLRy/+kTl8AvXA8Rx/WRLWNrOUNnxsIeu9DjSrTuyzow+fmQM
         EOxemY18TUvpEK9G8ge5U2eJUNgnkyqpG3lo7u/MkEKdIC/Kf9HFG1SV2/KktpUAC/
         UVtktHR5GYliHWhLG1TnZsV3HNk6dPtWBJCGoB+4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljahc-1jmcsX0qa0-00bbU3; Mon, 09
 Mar 2020 19:35:33 +0100
Date:   Mon, 9 Mar 2020 19:35:32 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCi0YDQtdGC0YzRj9C6?= 
        <alextretyak2@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: number of added and deleted lines for UTF-16
 files
Message-ID: <20200309183532.lsh74dxjlxdqhdox@tb-raspi4>
References: <CACDhn-QHqGFhZw+3K61v+Qtmm5y35nARWJaBkZ_YyZevJu8HBQ@mail.gmail.com>
 <CACDhn-R6ZKvgMxJdxP7NpsAViY97PfC7aM8xTJgaQK_GLJRyvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACDhn-R6ZKvgMxJdxP7NpsAViY97PfC7aM8xTJgaQK_GLJRyvQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:5FGyn5sN8Fm9V3sIk+wutIn0/U0wmpQGVoYvy6NdvNWzGWMYNbZ
 GZr5pc8O0lvA81sKFEXXca7dy7wySSNkxWbRVfIjHvfPSvMRKfMcd/YtUOofxlJcJ3xf3a9
 WsMNtXY+hoXypzymqCL1YnEG+DAlNnJW2V4HbYJSj8dC/7wPkAtBWG2IB7q4/qAo6BdJoBV
 icBqf08LnbmzokhchmTGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FcvBZaifcB0=:Kn5X/3kcDJtdxsrstQ+Rqa
 4PMbNojR/jT/NRxsbHf+h5IkLSuZPqHMJ/fzWETtKsqFamVLZzyMf6KTRhcgW7hbhfa1G5uZe
 ykvBqFWWSoFIsuwiaN8C9Fg6oYaCZ1yW18X6Oz7SltpCHU536WCzkWowGsvXhgkf4t1PUpdr4
 5SlDel08+EPmyerU4yO5CoZtNDqwurMo1zBzdCzuYr3nh6anoM070fx6kUbnS2mcrhD7SJc2w
 8OokFw61k49h4EiZOFqxWf2mugXDLOroKjsaGhsi39yh7pbqpS5kOmfokCmawPw8YVEDPxcut
 sNzzN4LRwgDOyU9C5dap8RiiQdphbyG6EWtwZU/ai3b5K8xysL0nfct2CuO9l2D76Z1i5O+qP
 MJ4JMjO/8wcs6svZviBr4qPcr4XdJrqNgW0A6kLQvzLRyehHqh5ku+LAyZJrdO27zhOAVXEk5
 pIdcw72QFLB8F0aFltSmcDmrRqoEdR+/I1lxRWMTy96zofGrkUXOJ3Ldc68AktzcfT3f31wDB
 S3xLVitPcW4/uARE+Z/ln28Ctby1FQQN3I82EMI03tIZTkQ/BtK93zLK7YNKlilngHwSirEed
 Us7TfksbocLbp+jRx0eYhmhU6OD7Tf2jemRxwlbA8Q75EBvLlFCOVTiDnC73bJxmsGfgJw49B
 7zxftGMAnPC3p3qIZugA4wNW6sAXLDjp3j+hnhpJ6mJNlzW7liB3x7/5XLsTVNRwjI2dGdqLd
 ol6+t1XQ4Qowaw4IRgwttjC8XBlqWho80A01D5JXncj2vTa3kfb0Y0g3czJbAUFCEVHmX59Fp
 TctdHBJP2HvM/pEzGikXgQOD+u9F4OtLd7UGSsqU/H+LO0/oqo2q/erW9es1jWqSW06gEnw3K
 92ZZNnjLX0YAnqGUugEBDuImO3yUD5qIaIyl8WBtGm/EwDi93B+AZdjcwokZiGoBS5ce9K27s
 kK7I09gnY/LoUvs436KKCxVb7C8M91LxaQXyt+/KEfYHqc244V8rodoMW+N252kD7OdEU6bsl
 B7vSgY0mzbclfCGRdan503NN8aiz5EysViSxFoPAmmPTHMLlUDi3Nl+nGSXe+EbcKgrGijrRm
 JxveRuRwnK0hpEypquGeV4Tj/hJRljgY9wkJXdMcOVg5eun4StpIj4UFUJnw1d8YVxOO1hyp5
 1qA+j117O/ijuUw1XjtfIyL+U648zI/dsMKcHsltYbKY51ix7vYPZJl8JbsJOMzIinNr4w3Vf
 WBuN+TbRUJtfEx4Y8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 09, 2020 at 07:37:56AM +1000, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=
=D0=B0=D0=BD=D0=B4=D1=80 =D0=A2=D1=80=D0=B5=D1=82=D1=8C=D1=8F=D0=BA wrote:
> Some source files in MSVC (e.g. resource.h) are encoded in UTF-16 (LE)
> with Byte Order Mark (i.e. signature: FF FE for little-endian and FE
> FF for big-endian), and `git diff --numstat` shows `-` in place of
> number of added/removed lines, e.g.:
> -       -       clientapp/resource.h
>
> Can you auto detect UTF-16 by reading first 2 bytes of the file, and
> correctly show number of lines added/removed?

There is an attribute "working-tree-encoding" that can be used to
have the files in "UTF-16LE-BOM" (in your case) in your working tree
and in UTF-8 inside the repo.
This will allow commands like "git diff" to display added/deleted lines
in UTF-8.

More details may be found here:
https://git-scm.com/docs/gitattributes

I hope that helps
