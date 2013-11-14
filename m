From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 21:50:34 +0530
Message-ID: <5284F852.8080609@gmail.com>
References: <2137000803.2895009.1384440156683.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 17:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgzf5-0003jI-9B
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 17:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab3KNQUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 11:20:45 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:45561 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab3KNQUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 11:20:39 -0500
Received: by mail-pb0-f52.google.com with SMTP id wy17so1039667pbc.11
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RK0+p5SOcJfIExh0a8X2WDiyC2ILhvD4d/7PyD6qrGk=;
        b=omC+dtLbzJsOtPMsqNpPavbYK5BtZOhkPq4FjUQv/JomNiQhGAIci9aZ4LOeE2M/GQ
         KdJQBXHdhuus068FwOAcLTcfpV9dqvX6cUMIAgWRSN6IwJLsTj1aaCmeHUM6t/kuhc7c
         S2xj+KT02rNBZfPpQe4Cr+ZEclhf5o+4qXhU9re5xg0V7+jFryy/A2xeprfuvh6G56nr
         HBQ3/2TuWSUJGOL2CWwn9XbrojUdIxhpWWK1lZOxz/R76Vn084U+mKJYmC56pIFBgJ8b
         I1ms+IAIp+ljpbrOylA5bDUiATX7yzRRocXnxMan99GInJE9enCcxFlZBl5I9OxRCoJG
         vx8g==
X-Received: by 10.68.202.42 with SMTP id kf10mr2133418pbc.191.1384446039100;
        Thu, 14 Nov 2013 08:20:39 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.164.152])
        by mx.google.com with ESMTPSA id gf5sm52540302pbc.22.2013.11.14.08.20.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 08:20:37 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <2137000803.2895009.1384440156683.JavaMail.root@genarts.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237856>

I can't resist...

On 11/14/2013 08:12 PM, Stephen Bash wrote:

[snipped some stuff from Peff]

[snipped 60 lines of python]

In honor of your last name, here's what I would do if I needed to log
ref updates (and wasn't using Gitolite):

#!/bin/bash
# -- use this as a post-receive hook

while read old new ref
do
    echo $(date +%F %T): Successful push by $USER of $ref from $old to $new
done >> push-log.txt
