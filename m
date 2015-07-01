From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Wed, 01 Jul 2015 08:15:27 -0700
Message-ID: <xmqqh9pnc3jk.fsf@gitster.dls.corp.google.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
	<xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
	<CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
	<CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
	<19801032cd7af95bc8030f54d740bf48@www.dscho.org>
	<20150630122323.GY18226@serenity.lan>
	<CAKDoJU4cEvWvfnFsvfOJ_P0UOrD3RpLK1NdfxaUPiDTWXYg-oA@mail.gmail.com>
	<CAKDoJU42kDs3QXYjo7rJ-vLMJtUdv9AwttJLHnya+toG6cSatQ@mail.gmail.com>
	<20150701115036.GA31158@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lawrence Siebert <lawrencesiebert@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, tanoku@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 01 17:15:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAJjb-0007hs-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 17:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbbGAPPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 11:15:31 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33794 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbbGAPPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 11:15:30 -0400
Received: by pdbep18 with SMTP id ep18so27419974pdb.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EoqNWGXbb6A1opnkmYS0p21Xkj9PX7g8HFieBaCqoSI=;
        b=Ph7Pmg6PIqIhx5m8wniy53cr+N/iShcNVtpQVbHtXVo0IrYqZVr6tDpZTHJZ8AluE7
         qKvZfR7AjdVcHLWriAQWTAIJdesEJsawZXdNEgYfepY0cz4KbCl7csL7tEyOfqU9MIhy
         Sx/p5oIOh5YNFTCkFhcB+wdM4rg8qLxSIwtPCmHeMnzbeprSKNve439/rKmthQcvBVfY
         OjniMKpleoTH6rVt+3h7fWE38FKsBka3cNlhhUAybGsHBQcTSGJAOtuoPdRV0CX1pq1A
         520T5YmXnz6dXH3axKnWoi+ZyzHZMNoz5RCfKOWTdhNMJrYK48TyPC7ZRUOH57XCDPUC
         GADQ==
X-Received: by 10.66.121.101 with SMTP id lj5mr55462189pab.113.1435763729529;
        Wed, 01 Jul 2015 08:15:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id ie3sm2620433pbb.49.2015.07.01.08.15.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 08:15:28 -0700 (PDT)
In-Reply-To: <20150701115036.GA31158@peff.net> (Jeff King's message of "Wed, 1
	Jul 2015 07:50:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273155>

Jeff King <peff@peff.net> writes:

> Note that this would not work with, say:
>
>   git rev-list --use-bitmap-index --count HEAD -- Makefile
>
> as the bitmap index does not have enough information to do path limiting
> (we should probably disallow this or fall back to the non-bitmap code
> path, but right now we just ignore the path limiter).

Yeah, at least the former but preferrably the latter.

Thanks.
