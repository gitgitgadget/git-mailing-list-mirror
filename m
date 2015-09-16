From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/67] add reentrant variants of sha1_to_hex and find_unique_abbrev
Date: Wed, 16 Sep 2015 10:06:10 -0700
Message-ID: <xmqq613as399.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152629.GH29753@sigill.intra.peff.net>
	<55F84D9B.90004@ramsayjones.plus.com>
	<20150915175027.GA31091@sigill.intra.peff.net>
	<xmqqh9mvtai5.fsf@gitster.mtv.corp.google.com>
	<c62ef479c559cb040628fc4ede5b151b@dscho.org>
	<20150916103350.GF13966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 19:07:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcGAt-0007yB-NH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 19:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbbIPRHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 13:07:09 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34679 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbIPRHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 13:07:08 -0400
Received: by padhy16 with SMTP id hy16so214397974pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=y50IdAiE1A35ptj0ZhjNiKAtNjzq3bOMSV57qrm98vA=;
        b=oM5MBH29buKgiwbAER1kub8PxOrKwu0kNUdsoKzckXbsLC95Nx/21ppAXve+hzYrKi
         VprKwR6W1eNGBB8elC2h+1g55BALDyjvQ5acwZf5qhc7hhuKvOHqDBRYBDo4QXWCsbZR
         O9mgUC6gELxjhZFj1l7BVgO0DqO0Si4izBLzpsfI+c+5SmFQiI3e0LS6Zsh9Y5oCulHY
         tybWPwEVCjUIP89l9GfIWiXtdNZDynrNGgbelggdwIM0WS8pd+NKA3Kbzmuk7dj+vsbA
         /K+i2RV3jPY2oxvmxgy89HZH4SpR589ONdX4MvfTO3LloPQGbfH47Vql36Cr3rPbDdmD
         q2oA==
X-Received: by 10.68.104.66 with SMTP id gc2mr38420273pbb.21.1442423171790;
        Wed, 16 Sep 2015 10:06:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id fu4sm28844833pbb.59.2015.09.16.10.06.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 10:06:10 -0700 (PDT)
In-Reply-To: <20150916103350.GF13966@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 06:33:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278036>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 16, 2015 at 10:15:02AM +0200, Johannes Schindelin wrote:
>
>> Maybe we should stick to the established practice of the many, many
>> reentrant POSIX functions following the *_r() naming convention? I.e.
>> the reentrant version of localtime() is called localtime_r(), the
>> reentrant version of random() is called random_r() etc.
>> 
>> So I could see myself not needing an explanation if I had read
>> sha1_to_hex_r(...).
>
> I like this suggestion. By itself, the "_r" does not communicate as much
> as "_to" to me, but as long as the reader knows the "_r" idiom, it
> communicates much more.
>
> I'll switch to this unless there is any objection.

Fine by me.  Thanks.
