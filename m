X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: should git download missing objects?
Date: Mon, 13 Nov 2006 20:45:32 +0100
Message-ID: <20061113194532.GA4547@steel.home>
References: <ej7fgp$8ca$1@sea.gmane.org> <7vwt60bggs.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 19:46:57 +0000 (UTC)
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vwt60bggs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-ID: bVgYxUZDwe+LDMBmrig3kMdnXA9AN4tee61rk+BfmCFHC4M0F9EAo3
X-TOI-MSGID: cbd86ed3-e975-4b99-97bc-6e56da9ac34b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31313>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjhlR-0007wf-HV for gcvg-git@gmane.org; Mon, 13 Nov
 2006 20:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755240AbWKMTqR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 14:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbWKMTqR
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 14:46:17 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:21949 "EHLO
 mailout09.sul.t-online.com") by vger.kernel.org with ESMTP id
 S1755240AbWKMTqQ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006
 14:46:16 -0500
Received: from fwd26.aul.t-online.de  by mailout09.sul.t-online.com with smtp
  id 1Gjhkj-0001Yj-00; Mon, 13 Nov 2006 20:45:57 +0100
Received: from tigra.home
 (bVgYxUZDwe+LDMBmrig3kMdnXA9AN4tee61rk+BfmCFHC4M0F9EAo3@[84.163.84.190]) by
 fwd26.sul.t-online.de with esmtp id 1GjhkM-1p7hQm0; Mon, 13 Nov 2006 20:45:34
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 71795277AF; Mon, 13 Nov 2006 20:45:33 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GjhkL-0002AA-0D; Mon, 13 Nov 2006 20:45:33 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano, Sun, Nov 12, 2006 20:41:23 +0100:
> Since this is not everyday anyway, a far easier way would be to
> clone-pack from the upstream into a new repository, take the
> pack you downloaded from that new repository and mv it into your
> corrupt repository.  You can run fsck-objects to see if you got
> back everything you lost earlier.

I get into such a situation annoyingly often, by using
"git clone -l -s from to" and doing some "cleanup" in the
origin repository. For example, it happens that I remove a tag,
or a branch, and do a repack or prune afterwards. The related
repositories, which had "accidentally" referenced the pruned
objects become "corrupt", as you put it.

At the moment, if I run into the situation, I copy packs/objects from
all repos I have (objects/info/alternates are useful here too), run a
fsck-objects/repack and hope nothing is lost. It works, as I almost
always have "accidental" backups somewhere, but is kind of annoying to
setup. A tool to do this job more effectively will be very handy (at
least, it wont have to copy gigabytes of data over switched windows
network. Not often, I hope. Not _so_ many gigabytes, possibly).
