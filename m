Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 6115 invoked by uid 107); 10 Mar 2009 03:25:32 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 09 Mar 2009 23:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbZCJDZO (ORCPT <rfc822;peff@peff.net>);
	Mon, 9 Mar 2009 23:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZCJDZO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 23:25:14 -0400
Received: from 9a.26.1243.static.theplanet.com ([67.18.38.154]:39033 "EHLO
	rubble.crucialcrossbar.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751960AbZCJDZM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 23:25:12 -0400
Received: from [70.230.183.79] (helo=[192.168.1.123])
	by rubble.crucialcrossbar.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <mr.gaffo@gmail.com>)
	id 1LgsaW-0005ft-HB; Mon, 09 Mar 2009 21:25:04 -0600
Message-ID: <49B5DDA6.8070108@gmail.com>
Date:	Mon, 09 Mar 2009 22:25:26 -0500
From:	Mike Gaffney <mr.gaffo@gmail.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
References: <49B5AF67.6050508@gmail.com> <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903100143550.6358@intel-tinevez-2-302>
In-Reply-To: <alpine.DEB.1.00.0903100143550.6358@intel-tinevez-2-302>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rubble.crucialcrossbar.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I guess it makes sense to split the config out into two patches. I wanted both to help with automated builds, and as it's a read only account I wasn't worried about someone reading the password. I'm not very impressed with the permissions on the .netrc file actually providing security so I can see not allowing the password in the config either. In my system at work, we have shared machines but all developers have root access, so file permissions don't really secure anything for us. It's also why we can't really use keys (there is no way to enforce that a key is secured afaik).

I wanted to do a remote specific config as well but a global works well in many environments where your push repo is under http as you don't keep having to configure it. I also couldn't see a good way to do a remote specific config without changing the remote struct (which seemd like putting specific in a general). I would love some advice on this and where to put it.

I can see your security points but I would argue that if that's what we are worried about then we should not allow the netrc file at all. I added notes in the config documentation about this. I'm open to discussion on this point.

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 9 Mar 2009, Junio C Hamano wrote:
> 
>> It appears that none of the issues I raised in my response to your 
>> earlier round was addressed in this patch, except for the line 
>> rewrapping of the proposed commit log message.
> 
> AFAICT my concerns were not addressed either: misleading subject unless 
> the patch is split into two, remote specific config variable instead of 
> global one, security issues.
> 
> Ciao,
> Dscho
> 

-- 
-Mike Gaffney (http://rdocul.us)
