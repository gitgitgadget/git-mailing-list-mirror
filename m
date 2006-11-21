X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] gitweb: make HTML links out of http/https URLs in changelogs
Date: 21 Nov 2006 15:55:04 -0800
Message-ID: <86wt5oicdj.fsf@blue.stonehenge.com>
References: <4563777C.4050108@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 23:55:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.14.18; tzolkin = 5 Etznab; haab = 11 Ceh
In-Reply-To: <4563777C.4050108@openvz.org>
Original-Lines: 15
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32059>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmfSJ-0003FD-5E for gcvg-git@gmane.org; Wed, 22 Nov
 2006 00:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756880AbWKUXzH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 18:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756882AbWKUXzH
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 18:55:07 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:691 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S1756880AbWKUXzF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 18:55:05 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 1B7708FA20; Tue, 21 Nov 2006 15:55:05 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 06768-01-49; Tue, 21 Nov 2006 15:55:04 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 7D3D18FA32;
 Tue, 21 Nov 2006 15:55:04 -0800 (PST)
To: Kir Kolyshkin <kir@openvz.org>
Sender: git-owner@vger.kernel.org

>>>>> "Kir" == Kir Kolyshkin <kir@openvz.org> writes:

Kir> +	# make HTML links out of http(s) URLs
Kir> +	$line =~ s/(http[s]?:\/\/[^[:space:]\]\)]+)/<a href="\1">\1<\/a>/g;

Perl tip of the day:

On the right side of s///, you want $1, not \1, because \1 accidentally
works, but \10 (instead of the proper $10) will give you a control-h.  Ick.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
