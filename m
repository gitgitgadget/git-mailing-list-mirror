Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B2D1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 21:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbdLJVmY (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 16:42:24 -0500
Received: from elephants.elehost.com ([216.66.27.132]:65472 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbdLJVmY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 16:42:24 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBALgL8J000977
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Dec 2017 16:42:22 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <mqudsi@neosmart.net>, <git@vger.kernel.org>
References: <0101016042190a3b-091dfab3-e010-4fbe-94e7-739ae3090883-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016042190a3b-091dfab3-e010-4fbe-94e7-739ae3090883-000000@us-west-2.amazonses.com>
Subject: RE: SSH port ignored when ssh:// prefix isn't specified
Date:   Sun, 10 Dec 2017 16:42:16 -0500
Message-ID: <000a01d371ff$c2aca590$4805f0b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJUsdWkb7uoi7JVbnQWN1T8rkMteqI6muKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 10, 2017 3:24 PM Mahmoud wrote:

>It appears that for non-standard ports to be specified for ssh-based
clones/checkouts, the leading "ssh://" prefix must
>be applied. I am unsure if there's a reason for this or if it is simply an
overlooked idiosyncrasy in the parser.

>Basically, while `git clone ssh://git@example.com:2222/path` works, the
same with the `ssh://` prefix doesn't,
>and attempts to establish a connection to port 22 instead: `git clone
git@example.com:2222/path` (I'm not
>sure what it will do with the `:2222` should the connection actually
succeed).

Git is attempting to resolve the repository "2222/path" as it's default
behaviour since the ssh method is not specified. This is a situation where
the default is ambiguous so while git is choosing the ssh method, it is also
choosing repository resolution after the ':' which is also default
behaviour.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



