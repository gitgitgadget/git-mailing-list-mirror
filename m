X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: stgit: No patches to pop
Date: Mon, 11 Dec 2006 16:11:50 +0000
Message-ID: <tnxpsaqwgxl.fsf@arm.com>
References: <7ac1e90c0612110632x56a2917cu4db33e47923f34c2@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 16:12:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7ac1e90c0612110632x56a2917cu4db33e47923f34c2@mail.gmail.com> (Bahadir
 Balban's message of "Mon, 11 Dec 2006 14:32:46 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 11 Dec 2006 16:12:16.0966 (UTC) FILETIME=[208DD660:01C71D3F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34011>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtnl4-0001yA-5u for gcvg-git@gmane.org; Mon, 11 Dec
 2006 17:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936957AbWLKQL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 11:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936967AbWLKQL7
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 11:11:59 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:50779 "EHLO
 cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S936957AbWLKQL6 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11
 Dec 2006 11:11:58 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id kBBGBtYo000834;
 Mon, 11 Dec 2006 16:11:55 GMT
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Mon, 11 Dec 2006
 16:12:16 +0000
To: "Bahadir Balban" <bahadir.balban@gmail.com>
Sender: git-owner@vger.kernel.org

"Bahadir Balban" <bahadir.balban@gmail.com> wrote:
> I've just recently started using stgit (v0.11, git v1.4.3.4). On a
> test repository, I do:
>
> % stg applied
> first
> second
> third
>
> but when I pop I get:
>
> % stg pop
> stg pop: No patches to pop

Can you write a list of commands or script so that I can easily
reproduce this? It works OK for me.

> I also get things like:
>
> % stg pop second
> popping patch "third"... done
> Now at patch "second"

In version 0.11, the "pop" command is equivalent to "goto". I changed
this in the latest version (in the StGIT repository) so that "pop
<patch>" tries to only extract that patch from the stack by popping
all the patches to the given one and pushing them back without the one
you specified. It also supports patch ranges (i.e. patch1..patch4).

-- 
