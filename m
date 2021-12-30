Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D337DC433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 12:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhL3M0l convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 30 Dec 2021 07:26:41 -0500
Received: from elephants.elehost.com ([216.66.27.132]:43232 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbhL3M0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 07:26:41 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BUCQclS043876
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Dec 2021 07:26:38 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <nickgearls@gmail.com>, <git@vger.kernel.org>
References: <52591f5d-d4b5-90ea-e84e-32b99803a3e6@gmail.com>
In-Reply-To: <52591f5d-d4b5-90ea-e84e-32b99803a3e6@gmail.com>
Subject: RE: Git Diff feature request
Date:   Thu, 30 Dec 2021 07:26:33 -0500
Organization: Nexbridge Inc.
Message-ID: <00dd01d7fd78$7e69e150$7b3da3f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFH+jfZF3ufw6poUXBHJlhKZ8e1lK1q+olw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 30, 2021 6:33 AM, Nick Gearls wrote:
> On top of the option ignore-all-space, it would be very handy (for several
> programming languages) to have an additional option ignore-all-space-and-
> eol where the following snippets would be equivalent:
> 
> if (...) a = 1
> 
> if (...)
>     a = 1

One interesting technique I have seen used is to set up a pre-commit hook and/or clean filter to format code according to corporate/team standards. Reprocessing code prior to the commit would allow a normalization of coding standards and removing of EOL or space/tab concerns. So even if a developer did

if (...) a= 1

By the time it reaches the repo, it looks like

if (...)
    a = 1

We use a similar technique (enforced only by policy right now, not a hook), which is to require code to run through standard IDE source formatting. Improperly formatted code hitting pull requests gets a decline until the code is properly formatted. A pull request diff might not include an above suggested diff option.

--Randall

