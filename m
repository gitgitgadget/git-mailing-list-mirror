Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB8C2022A
	for <e@80x24.org>; Tue, 25 Oct 2016 11:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755222AbcJYL1u (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 07:27:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:50124 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752711AbcJYL1t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 07:27:49 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LlV4F-1cWPdM271z-00bLOD; Tue, 25 Oct 2016 13:27:39
 +0200
Date:   Tue, 25 Oct 2016 13:27:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, e@80x24.org, jnareb@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/2] Use CLOEXEC to avoid fd leaks
In-Reply-To: <20161024180300.52359-1-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
References: <20161024180300.52359-1-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0qe/HEJKBm+rx1BcQ4XdrELnRrjuURQSUyeDRoHLbHBedZ3UUMZ
 p/tRcXwY3hd7mu3bqtWWO4mgwB+h5kZ5NxgveBBDLoTN/+gKZBn5JVMSTFSHPjz3vPFjiaQ
 WUhktehOE6LithSzPVJhVD/cZ/afn3fAsoryFc8WMbdaDjV/DlF6OfdSwZQlPNtv5SuILer
 2npFGlhOBxbEwCgvkXfWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JEN0hIkD3IA=:IcjrHp/e2MXyRXxoKeHe7r
 0Z97GsmumnC25AzlDGwFVbd3I/inItFMg+gpqp1UmWNz/6WVPHggOIg7w0nwHTB5qZGSi4krn
 unhMhur6N8gXX4sfg8Hdm7XTZPGnQ7fLvcIBLFcHCBADNz5nPu3250BODkuf10U/W8W4iDNj5
 /ItggetPcsfx+6w+Ck6GWrgsHFjjZCEtdldmX5Po9IPGv84LsDjPMu3aQUVVzkzNCIlCs9olU
 TAggMdjqBex2H/+mfEY4xw3wVrpi2rEqrvHnQOEvaMea9UzKu2+TcVWYJ3ej1Grcx+zB06tSM
 QKD3na+sqW1CpKaQq2MYTd3mFsxDrsABw3rLzCrLJywCBLuHt9ou6iXO7bx7p9M0rXzqrH+6O
 9edlZn7C835Kd7wRD4Ln1QLAi5QKqKfWJQ0H+LZtokVe96+WSQqA5WrPxLa7EuLj+6E0QookU
 hxcwLarUvqh5++LQ4t3DwFY/ScbH/Afr0E+tWrrkcgSCxAkRL8cE4+3s1D/3FmHD8PlNpN+Xl
 kY2Vbl4iUPM325pNldOX7JfQjK0WNSIVlrHfEo/mf5Fc6npZzCWa60WWvs2WuAJvEuCXylRTU
 LEceDs94DP9A5XC/ZKFWBq7ljTJV6v8Hw3vcNHoE7eOlRGSynUN8/ULwlHXyjKqzuAJv+KAJz
 zu7RG7pZfkS8KR/CGaHpvAC02skvCn9j0geJJGpgeS9dn4JZoHMFONgSr6VjYAZCdkcVBZ3jA
 0+gb23EGQodgAk1B91gKPu7SpUMuCIczTgpJ6M5cDNha2nF0CYODOVxKCe56fAmN4dS3vaymW
 Qy5/s9G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Mon, 24 Oct 2016, larsxschneider@gmail.com wrote:

> This mini patch series is necessary to make the "ls/filter-process" topic
> work properly for Windows. Right now the topic generates test failures
> on Windows as reported by Dscho:
> http://public-inbox.org/git/alpine.DEB.2.20.1610211457030.3264@virtualbox/

I acknowledge that this fixes the test failures in Git for Windows' SDK.

Thanks,
Dscho
