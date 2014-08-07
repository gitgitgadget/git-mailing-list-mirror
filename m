X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Nico Williams <nico@cryptonector.com>
Subject: Re: "Branch objects" (was: Re: cherry picking and merge)
Date: Thu, 7 Aug 2014 17:59:25 -0500
Message-ID: <CAK3OfOgg3fwQ2KZyG-V6-gHaWknZN_Y9KxQWwRZGcUOo7yjg5w@mail.gmail.com>
References: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com>
	<20140806200726.GE23449@localhost>
	<alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
NNTP-Posting-Date: Thu, 7 Aug 2014 22:59:50 +0000 (UTC)
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Tony Finch <dot@dotat.at>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=vEGtC5LE7upS5TOFaPfa
	VMxzUvY=; b=yevhAic8hJavzs6nC8em0r+Kirw5WEX1weu6UYd2VQAXm1K+3Sv0
	p+MTtDD+QAzyFinI2G5ye6uyd4qg8mzi4tn4LuIhAHOmx8Psv6qf8TjZdt0/gXh3
	su+tiOJ64d5z9B3Ex3THt3aLr6kpNAmCotGrx6cjrCUfsYea9FD9G2I=
X-Received: by 10.180.72.209 with SMTP id f17mr522297wiv.3.1407452365797; Thu,
 07 Aug 2014 15:59:25 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1XFWeu-000663-KS for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 00:59:44
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751500AbaHGW72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Aug 2014
 18:59:28 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:48063 "EHLO
 homiemail-a107.g.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1751197AbaHGW71 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7
 Aug 2014 18:59:27 -0400
Received: from homiemail-a107.g.dreamhost.com (localhost [127.0.0.1]) by
 homiemail-a107.g.dreamhost.com (Postfix) with ESMTP id 582EC2007F10B for
 <git@vger.kernel.org>; Thu,  7 Aug 2014 15:59:27 -0700 (PDT)
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com
 [74.125.82.41]) (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested) (Authenticated sender:
 nico@cryptonector.com) by homiemail-a107.g.dreamhost.com (Postfix) with
 ESMTPSA id CAAC22007F102 for <git@vger.kernel.org>; Thu,  7 Aug 2014 15:59:26
 -0700 (PDT)
Received: by mail-wg0-f41.google.com with SMTP id z12so4885715wgg.24 for
 <git@vger.kernel.org>; Thu, 07 Aug 2014 15:59:25 -0700 (PDT)
Received: by 10.216.231.131 with HTTP; Thu, 7 Aug 2014 15:59:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org

On Thu, Aug 7, 2014 at 6:38 AM, Tony Finch <dot@dotat.at> wrote:
> So I have a small tool which maintains a publication branch which tracks
> the head of a rebasing branch. It's reasonably satisfactory so far...
>
> https://git.csx.cam.ac.uk/x/ucs/git/git-repub.git
>
> ... though the structure of the publication branch is weird and not very
> easy to navigate. You can see it in action in my git.git repo:

You know, maybe you could even use this to automatically figure out
the merge base for downstreams that follow your rebased branch:
auto-generate the git rebase --onto <head> <head as it was prior to
all the upstream rebases>.

That would be awesome, particularly if integrated into git.  It would
then be fine to rebase published branches in most cases, for example.

Nico
