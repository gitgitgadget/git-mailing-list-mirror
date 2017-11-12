Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0898C201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdKLT1n (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 14:27:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:58391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbdKLT1n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 14:27:43 -0500
Received: from [192.168.178.43] ([92.76.226.11]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk7n-1ehS5e021r-00XsnX; Sun, 12
 Nov 2017 20:27:41 +0100
Subject: Re: [PATCH v16 Part II 5/8] bisect--helper: `bisect_next_check` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <81ae6057-d293-2dcd-64db-4dac41849131@gmx.net>
Date:   Sun, 12 Nov 2017 20:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:efrahg+o2tZbRVy813E0/U4FvlsdbTMgk+WGkEGVWgGo4ac06Dy
 0B3zHkDvitfJTD8vu9bf+q30FmlQBaZTDxvPiCEHV5D04D1ZnjPYsF+MQE4slhCopgAGxv8
 JF+R54oaF1YgpSuJZs/1mfHTuMOgtLY9tLr+0rhkczKNSpby8llTmPABJANSu/7RJloERfE
 Rou1z8BoRTaCGwbmt/tjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xnN+PgNfy9U=:Kx+Bmd9ziUJovXsbdftNM+
 jpzzlgD2FTvnihhrg5qdLEye7N0uKUQzBNf7wy94pvnSwPoA0PCfs+m0Qb8qoVvcQps5SGL8w
 jFKvZlCfUDHhKDLB1rHRCdz/GGc/QsVH8uy4uFsLcAT0e02JLNCxtjLkBujbch/Szw4WD1N0L
 z6eNU0j9YIIWK0K0xRywvBs0EcZDx++ZbRWPK/KPPiQ7mNMotS5FvNnQXhBk49yOZlIlkPqSh
 HU3rjvTADMNRzQiJCd2rDWc68fP+0k5Hv5XlChxKp51l3hVdojWuABKb+9FbcbmzPEkplD8hn
 pOihdVY/S4q0IfSSxs8QWJBJaih7oMBohwHnELvUNMVnlmCoFV+DNu9lLTzrL6ls0nTnvry2q
 kj/N4BO8HGfLI38Y5seZg5YWaBDLwqW2wJ/pflXdpMJ205qBz4BA0GR16XLKWIMjDmO4C8UEG
 8XJ2mdrdFVmqr7vE47ypCExfXFQ0clIuqJgz6Wa5yq8hdMVTnfBpFg3/99rH0tWX1451N8VIy
 a6n34Dmk8KM++/dnyrKwCmAQ1Muq50CIDPy5JKRTI/F8/lxBnDTHqKCY3j1xhjyA057EVgBio
 MIahC5EDkoHYd+3a/AkhJKrO6Dq2eMS5ntibqCRCCjyT5QvPS7pRSK6BifCV6TZN5jknRvT2B
 7J0uQchVa1v0wuMlTZpGTgfG4tvoGLwjV3XAv90xbN7VMNXbb921O8bd9uaUiUlJn6Dy8z0Dy
 QYpomcQQrusB8PwzeGXiTbgP/r3m6xYIj3MlS+Vzpe60cNV+lCEcnyROO8jMof6zs4sJQEoLG
 IsbmEdZqNlTNoadMqhoiXUZz0z+GgRDTUhd/OxszS9lHu0VqOY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -21,6 +22,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
>  	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
>  	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
> +	N_("git bisect--helper --bisect-next-check [<term>] <good_term> <bad_term>"),

I think the order is wrong. It is <good_term> <bad_term> [<term>]
