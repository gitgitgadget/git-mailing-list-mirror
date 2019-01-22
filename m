Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29971F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfAVUAW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:00:22 -0500
Received: from mout.web.de ([212.227.17.12]:49085 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfAVUAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548187210;
        bh=aPparIRtkHZGhAKLPLlYhdMqkKFCjnauBKECHpxmoVw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QNFAsHm1TfttKOi4P/5AwqxfD1ZYzfBj+oovHcFbY5V0JFTinykcBaX0c4wUbjmsC
         MIHwIJ/idq1gYECcM82Sgs66K6FPG1bhcaXge5B6QzYRcm54PO+7xlqLLVJXaAAVgI
         NzZk1l/vadgTacsQvg81AO1BnwZLr5szymeC7Eq0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.209.21] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MINAx-1gmJSn31bj-004G55; Tue, 22
 Jan 2019 21:00:10 +0100
Subject: Re: [PATCH/RFC v2 1/1] test-lint: Only use only sed [-n] [-e command]
 [-f command_file]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        zhiyou.jx@alibaba-inc.com, sunshine@sunshineco.com,
        avarab@gmail.com
References: <20190110115704.GL4673@szeder.dev>
 <20190120075350.5950-1-tboegi@web.de>
 <xmqqo988fpag.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <799c5063-b0a7-df6b-6f86-a92b8b6d679b@web.de>
Date:   Tue, 22 Jan 2019 21:00:09 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqo988fpag.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MvPFyZ//dq+RBp9Ix4En9WGWG5ejYIzYiwS1q634wUQjeTg+WF4
 Unb4zKfEE7u1iMA8oX7CSMJJoi4QNq7/HTXzXhCt7nUbxyiEv2STc2t4phplmuHdpKMVFwG
 7E5HNELjLhxA4sSo0zoXRwOmU2LqjiURswLQa8P+L3pR4+goj4LgWf92cVUWkpwoH5xsMO+
 ppQJmgixUXS27ef2X2XEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F7Pra8yEdBc=:snuPI9ulTgRAbdsf+9w6v2
 kE2Q6OUx99mC/aapW1/7pX84Ika9yW2SpWP/YiRWHL3cpt4DThXQqOGsFgIms2AiRKkWXZA4R
 jO+ZWTmVe3C0nn53UJsad+fjvWhNCTD/IK31ikNnqW+Z4YDe0Hp+nFkgOUpGvlefseJUkH5xo
 S+kqJocdRVtEAx06Xrtmaf6gdvibSF5qhhwd7yZnn3OgJSYGXrr6bbVCggs4bVNr6xRMQfIMB
 6Rgn4SYZ/atC5NnE9SOQhlVsOuFiclIAPKOr5y+sBufepYMSJ4T+O5UX5JGKWb2Y1ZZWhhXA7
 DQ4+VEDbV9Q3bdVWA+9FexNJywKXyLdvKZkwp2l+BNoc+xNbz/6Xb7OOl0RUFqRshjRS2sj8V
 RpJTyyRa2CpdttFICquoLESkn2cY5vAcl5JpFoLbhGWLeiU15nVRcrshIU/GrvjDw/Y/OL/km
 q/J6cFjUj5CXlk0shZlHifzf+MW0uNQGqKJtvcPxiza1SSD8F0ZVLIqGmqfaZa6fzrgvMJDTM
 ziCcW62Mb7ZIIZH4/EeLBVXFwWXi78Owxks0sEiDCoepvC8UHlysF5N0ZD4K2Rm4hScuHu0Vk
 RHrn5+TAwsnTrUL54H29iLIJHV3fgum0oC7sN8N15xcVaNfEekfR4yu5MsVG1MVDJLbWoxZHl
 tBmD4pzEzcSaNPmjvX4BkDXOb8EXcSTeNWH32TSsr0Kgg74rjKXBEsiJTdeDBtGo8o18PU9RO
 Z3Dn3ra0Yzz43DwHOGrjVayrBwM5/CkPUMhTdFhVu0RNjDoIzHMiysVluG1Fk96xTs6bxmb8Y
 nKvfOxxP84MEevxAzeygrHqszR+DgC74kCHyrdAkFVtDozJId71YQ+6ayV9yrTdHTQeFaANWN
 pnj65gWlIP8q+4DxDHVvWYymTdMh2wLhKqdr0zqSvnsRBz5AzuCqkHSWfrc+Db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.01.19 20:47, Junio C Hamano wrote:
> tboegi@web.de writes:
>
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> From `man sed` (on a Mac OS X box):
>> The -E, -a and -i options are non-standard FreeBSD extensions and may n=
ot be available
>> on other operating systems.
>>
>> -	/\bsed\s+-i/ and err 'sed -i is not portable';
>> +	/\bsed\s+-[^efn]\s+/ and err 'Not portable option with sed (use only =
[-n] [-e command] [-f command_file])';
>
> "sed -n -i -E -e 's/foo/bar/p'" won't be caught with this as an
> error, but that's OK ;-).
>
> Is this still an RFC patch?
>

It seems as if everybody is happy with it,
so it may be ready for for pu.

