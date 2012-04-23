From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4 v2] push.default upcomming change
Date: Sun, 22 Apr 2012 19:50:16 -0700
Message-ID: <xmqqzka3kvpz.fsf@junio.mtv.corp.google.com>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
	<1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120420203552.GC13103@sigill.intra.peff.net>
	<vpqipgs81ru.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 04:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SM9MK-0007Eb-9j
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 04:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab2DWCuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 22:50:24 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:35536 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab2DWCuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 22:50:18 -0400
Received: by bkcjk7 with SMTP id jk7so35697bkc.1
        for <git@vger.kernel.org>; Sun, 22 Apr 2012 19:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=2OGOZsFjR9VImhRFYsLMTyOvN2s3bJFpAobhfhtSMq0=;
        b=KZexriga8WfLPYBo5qijiPKJ9mfmGFeQ8w9dfgihJprLXcnZMhVrz2AfEokl2i0yWG
         oUGC3N+Lme5KDt7xVpYS016S+eFkkdm7IOurn6ZVV6RsxVdCtqMIHdriWC/um9as3rNi
         m5GWhuSy1fu3iEVQuY/Zww3BlIrkb3lrG8bwKuBvOL+LVaJZRvIoYw/DJi+ZdcrDs9EI
         cXAPXt6/vyqhzJ8VKhpF4wdnLoU1oqpm4qQ8uFb6j24nBVwSpUWoAwVexj0B1WQTvMTL
         MuBURwxkMKdIlRgnbNwC5riRKzZOG8PEZgmj+5kHWGoEEbZ4Qm7Sf9WpoWQJrpdlxYTu
         2qqQ==
Received: by 10.213.13.10 with SMTP id z10mr1167490ebz.1.1335149417310;
        Sun, 22 Apr 2012 19:50:17 -0700 (PDT)
Received: by 10.213.13.10 with SMTP id z10mr1167478ebz.1.1335149417162;
        Sun, 22 Apr 2012 19:50:17 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si8510862eef.1.2012.04.22.19.50.17
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 22 Apr 2012 19:50:17 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id EF33E20004E;
	Sun, 22 Apr 2012 19:50:16 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 439A5E120A; Sun, 22 Apr 2012 19:50:16 -0700 (PDT)
In-Reply-To: <vpqipgs81ru.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sun,
	22 Apr 2012 13:05:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQl+2PtsxgutE2W6gYy8HRGUnxPRyqNe6GmBLjGAFWLv/tFSHCdIB53HU1tCRuS571FFWe22k6dtruryXp3TigibHdXAZE9bRqwTcvITfHRDnm8le5p1Zxn7kqTSE6E7hqo2dqXOxubcc6UXgt7axNqiHyzL+f05/er6KHoAyjUqu7VPPqQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196096>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, I'm starting to think that the "warning" part should be
> delayed a bit: we probably want to wait for the "simple" implementation
> to be available widely before we start advising people to set it
> explicitely (otherwise, people using different Git versions on different
> machines, but sharing the same configuration will get complaints from
> Git about invalid value).

Yes, that is a good thinking.
