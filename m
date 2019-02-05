Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF111F453
	for <e@80x24.org>; Tue,  5 Feb 2019 15:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfBEPC3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 5 Feb 2019 10:02:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55742 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbfBEPC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 10:02:28 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x15F2Ive031867
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Feb 2019 10:02:19 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Dani Koretsky'" <Dani@cybereason.com>, <git@vger.kernel.org>
References: <CANcfovV3Pq3pubtNq4HCSZOJ5OC9dVSm+19VkOiQimAH+fttYw@mail.gmail.com>
In-Reply-To: <CANcfovV3Pq3pubtNq4HCSZOJ5OC9dVSm+19VkOiQimAH+fttYw@mail.gmail.com>
Subject: RE: [BUG]: git checkout on a new tag with current HEAD shows "head detached" at previous tag
Date:   Tue, 5 Feb 2019 10:02:09 -0500
Message-ID: <000c01d4bd63$c8fc7ff0$5af57fd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHgwXGMn7Nz/J07H/AVhftWQNshyqW5RAXA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 5, 2019 4:20, Dani Koretsky wrote:
> I have 2 tags such as release-17.6.230 and release-17.6.220:
> If I'm changing commits, all works as expected.
> 
> If however both are pointing to the same commit, the output is as follows:
> 
> git checkout release-17.6.220
> git status
> HEAD detached at release-17.6.220
> 
> now if I run:
> git checkout release-17.6.230
> git status
> HEAD detached at release-17.6.220
> 
> Which is theoretically correct, but I'd expect after checking out a certain tag
> I'd be see that specific tag...
> 
> Sorry if this is intended behavior, I couldn't find clear mention of this
> behavior on the git checkout documentation online..

Please use

git checkout -b release-17.6.220

What your  commands above have done is resolved release-17.6.220 to a commit, then checked out that commit instead of creating a branch. Alternatively, use

git checkout -b new-branch release-17.6.220

to name it something else.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



