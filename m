From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] date: make "local" orthogonal to date format
Date: Tue, 01 Sep 2015 15:16:50 -0700
Message-ID: <xmqqwpw9pyy5.fsf@gitster.mtv.corp.google.com>
References: <20150901083731.GE30659@serenity.lan>
	<cover.1441144343.git.john@keeping.me.uk>
	<35b1313d4eb084ddc2bd70510d56e11a1d84e993.1441144343.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtrM-0002RB-7h
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbIAWQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:16:53 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33150 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbIAWQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:16:52 -0400
Received: by paap5 with SMTP id p5so1566941paa.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=75yqXZ76pRPhELeIBGjzigjmdoLJVAUx5XRhO5p165w=;
        b=0yh/uUViLOak0h7BHnQaR+MaAwHzzKfoOcfBD3D3jmaVWuX8PAwZEvZs4eimgUOOcF
         wkZhUfEblU8x6qcD5hjOsmCHQdjfYx8e5VL3IY0qYuhA1/KjIiQxUr0ud0JO64dkxwMO
         FrAhlCsLLjjFF5ZPKaxZZHpyR8NiPnLj/bCTIj0jZ2iP/8nWZCXbtzfMYZD0RMMbiLrr
         kh9FjSu3ZM2gh4d42gSE4T3w+4ysN8EdzsQzefdi4brwyJVvI+JYc43r9GczHKlLLcD+
         wBqKmiPKLlhNPQRoLxtYq0FeRYQED0a/D67CX6/ZAtvlotRrK28785uV3ibO6UZiK6Q4
         qAIA==
X-Received: by 10.69.11.196 with SMTP id ek4mr50814395pbd.148.1441145811626;
        Tue, 01 Sep 2015 15:16:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id h4sm19309992pdr.41.2015.09.01.15.16.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 15:16:50 -0700 (PDT)
In-Reply-To: <35b1313d4eb084ddc2bd70510d56e11a1d84e993.1441144343.git.john@keeping.me.uk>
	(John Keeping's message of "Tue, 1 Sep 2015 22:55:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277053>

John Keeping <john@keeping.me.uk> writes:

> This is Jeff's original patch with my fixup for DATE_STRFTIME squashed
> in and a new change to reject "raw-local" (in both Documentation/ and
> date.c).

Even in --date=raw, we do show the timezone offset, so I do not
necessarily agree that raw-local is nonsensical.  That's the only
difference between the one I queued yesterday and this one.
