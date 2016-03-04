From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [PATCH] stripspace: add --line-count flag
Date: Sat, 5 Mar 2016 00:13:28 +0530
Message-ID: <56D9D750.1030703@gmail.com>
References: <1457116723-20206-1-git-send-email-tigerkid001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 19:43:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abuhT-0008Cz-DM
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759821AbcCDSnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 13:43:35 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36286 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759782AbcCDSnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 13:43:33 -0500
Received: by mail-pf0-f170.google.com with SMTP id 63so39483871pfe.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=s17YdFuL3JGKv4657r8gbesXcpy6uTYx1YiNlirHduQ=;
        b=MAPWqsafbY42y7t8rlJ16a+V3e6r1FLb7LZLyO2u6QaM98rF+RL5vNM1ge49eZ8x2m
         jEBVjOTyo7nbvc6S9kFVyuWB8nNAWRYkJoq9oV6tEmiOjITi26xYWrE9j0WJmjs6p0pw
         70LFnlpo2d6tf+scj2/6l9NN1criL489MAt/mq/FNyQ3PHnqVNJPuEK7xangF5xiwtAm
         kDMN2Ti/W7rlXcztptBJCOzxxAzVHiqbYVNKNu4mg9+RAW01LgX87Nngi0WlI7cCUi2s
         spAYRWGhYJhBqDHHKQyIXh2ziN9fkI+9vQpJ/BRl29e5V5jAD1cI28gH/BLkyNZ8vM7x
         WwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=s17YdFuL3JGKv4657r8gbesXcpy6uTYx1YiNlirHduQ=;
        b=FH1rJMSOXrZN6iRMg9qlJQ/Ne+rhiguIFdXB209LizyQ75YAcO/wt7ojPOctYtB65o
         tkDLyNgNeUepg6g1F5B2AyNgp8/2531Gk+NOMthuOIu8FUN6nZO9hUgWtO/gmCaJnh09
         yA6EV9064Xp/yYsE/3OXs8PnGJcw/NF0AgkS3AUirGKj7lMBxq9FcIm7BJpcdtnI5qFJ
         nIZ0EET6lzkC5tPoFyngDeQHvVBLlOP+GZegf1w6vT7bNFLXgsQNZyD8RpPAfCHfYrgB
         v6eDTy/EnA4S0o/WNaRPKDw9DrdUD8Htg96RRNcr1S6Zo2bV3BUso9bA/g/K+spAfe9V
         saww==
X-Gm-Message-State: AD7BkJK+6LniH157y4kAlsFu48UBHbzJ7tIGEEJ+YWEIzpBiuJdv48/sBytZuSeM1/A93A==
X-Received: by 10.98.16.150 with SMTP id 22mr14257582pfq.128.1457117012559;
        Fri, 04 Mar 2016 10:43:32 -0800 (PST)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id to9sm7173281pab.3.2016.03.04.10.43.30
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2016 10:43:31 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1457116723-20206-1-git-send-email-tigerkid001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288268>


>  builtin/stripspace.c       | 22 +++++++++++++++++++++-
>  git-rebase--interactive.sh |  6 +++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
This is my first attempt at the small project listed here: https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#implement_.27--count-lines.27_in_.27git_stripspace.27.
With this, --line-count can be used with stripspace, instead of having to pipe its output to `wc -l` in git-rebase--interactive.sh. I went with --line-count and not --count-lines since its short form (-c) is already in use, and I think -l is more apt for this.
Comments?


Thanks and regards,
Sidhant Sharma [:tk]
