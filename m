Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F2E1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbdCaNXR (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:23:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:25871 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933300AbdCaNWL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:22:11 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v2VDM5A4034177
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Mar 2017 09:22:06 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Mayne, Joe'" <JMayne@LSAC.org>, <git@vger.kernel.org>
References: <4bb4871d8a78402bbef91231134a613b@EX1-PRD.lsac.org>
In-Reply-To: <4bb4871d8a78402bbef91231134a613b@EX1-PRD.lsac.org>
Subject: RE: Git Branching - Best Practices - Large project - long running branches
Date:   Fri, 31 Mar 2017 09:21:59 -0400
Message-ID: <001801d2aa21$ca45cb20$5ed16160$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIQX2kDVhWvP0kAoaltuV2MV7dCjKEzgYqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
>On March 31, 2017 7:56 AM: Joe Mayne Wrote:
>Subject: Git Branching - Best Practices - Large project - long running
branches
>I work on a team of 15+ developers. We are trying to determine best
practices for branching
>because we have had code stepped on when a developer has a long running
feature branch. 
>We have a Development branch. Developers are instructed to create a branch
when they begin
>working on a feature. Sometimes a feature may take a week or two to
complete. So a Developer1
>creates a branch and works for a >week or two. In the meantime, other
developers have created
>feature branches from Development and merged them back into Development. 
>At this point we are not certain if Developer1 should: 
>* Periodically merge the evolving Origin/Development into their Feature
branch and when they
>are done work merge their feature branch into Origin/Development. 
>OR 
>* Stay on their pure feature branch and when they are done merge into
Origin/Development. 
>We have had issues with developers stepping on code when they have long
running branches.
>We are looking for a best practices.

One key thing that may help is standards on formatting. I know that sounds
silly, but many merge
issues result from developers hitting the source format button and create
merge problems. If you
keep things to format standards, it will help merging in future. Even
lengthening lines to 132 instead
of 80 may reduce confusion - another silly suggestion, but I have seen it
help in a couple of places.

Keep your interface classes and base classes stable. If you are changing
those during development,
you are going to impact the larger world and probably should set up a
dedicated feature branch
off of Development and have all topic branches involved in the API change
branch off that one.
Frequent merges into topic branches are common when API changes are ongoing
(as are conflicts)
- they should not be as much when the APIs are stable. If you can, get the
API changes done first,
then create topic branches after the API is stable.

From what I have seen, frequent conflicts are sometimes an indication of an
underlying
development process problem - you should look into this and see whether
there are issues here.
Conflicts happen, but the "why" is important to understand.

Cheers,
Randall


