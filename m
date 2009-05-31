From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Managing submodules on large multi-user projects
Date: Sun, 31 May 2009 15:39:28 +0200
Message-ID: <81b0412b0905310639i12440ae4i9331d57a752a6b96@mail.gmail.com>
References: <20090529184125.GE11222@starfruit.corp.slide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Sun May 31 15:41:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAlIE-0003MJ-VK
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 15:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbZEaNj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 09:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbZEaNj2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 09:39:28 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:33699 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbZEaNj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 09:39:28 -0400
Received: by bwz22 with SMTP id 22so6989358bwz.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=71HBMPWHXWaqdB4kAejZfrSJEm6l0kpL3Asrr05Vyyc=;
        b=Zv5qyoi+Q8Ak6cNante3NURhjZQ0aP9y2nLbSTro2jd8hgG6NjMr8zwnRkpeu1R6gA
         jLKmq2l/Yu1Kc+MmN1PQYy/JGw8aNmmGJvdN0vdqGv0utFe+XkHa8FZeC5lJGbFbw8aP
         GW00fxeWLClbOBv+LzoZBJI9w9PaYd31MqJrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JJcgtgS7M1uuXNDckBeDbuFi2LzgIkZPEgXAx6S0W1/qzzpoaN184rVp8xCrGgB+5M
         d7NemEehQnF2LvDd7H6Z0HAVOd8kYt+mSXuZMOdowPQ/wddr6Lhucxw9reSV+KSsjHA2
         EgDYqvZGuoaSThHXKHqtmIDat+WMHTOX6Jktk=
Received: by 10.204.62.68 with SMTP id w4mr4629559bkh.122.1243777168933; Sun, 
	31 May 2009 06:39:28 -0700 (PDT)
In-Reply-To: <20090529184125.GE11222@starfruit.corp.slide.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120399>

2009/5/29 R. Tyler Ballance <tyler@slide.com>:
> Other developers with other branches will then periodically merge master
> into their project/topic branches but will either neglect to run
> `git submodule update` or our bootstrap script (which also executes the
> submodule update command). At this point they'll have outstanding
> changes of their own, and the submodule will be marked as "modified" as
> well. Usually what will then happen is they'll `git commit -a` without
> thinking and the submodule's reference will be changed (typically from
> B->A, undoing the previous change).

This (the fact that "git commit -a" updates submodules in the index after merge)
is probably our bug (or at least an unfinished feature).
