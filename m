From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 13/19] fsck: Optionally ignore specific fsck issues completely
Date: Mon, 22 Jun 2015 11:04:17 -0700
Message-ID: <xmqqegl3hb6m.fsf@gitster.dls.corp.google.com>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
	<cover.1434986506.git.johannes.schindelin@gmx.de>
	<4ae672be6b7ca7727cadc3b94c5f731b7df7abaf.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 22 20:04:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7652-00022t-LO
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 20:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbbFVSEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 14:04:20 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37070 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbFVSET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 14:04:19 -0400
Received: by igblr2 with SMTP id lr2so58962436igb.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=4MasP/F5ewcgcRCem71MrYspgDGvDw8IodU5wMIsFMM=;
        b=SHBbIpF3TA5chUk01C6IYb8myYQg9ma/ac7QsPwTX823RJkQeEOxURiKsoT1giRF8X
         xsumdaa9aZAo9iwlaxArNynvySalUXq9PN3vO9d2Ke5b//RampNw+SrjFmjlcUaLTUwz
         ZphHaAy+eppIVG+S0ATSSPpW7TSv1mPC6FzcgVCf9odARNJbsOpq0VqhMSOaMSGi8WcB
         j8hC/gDLSWJgoJKXWB21IRQo/MerdA1lUmGYIayxl0QfA30Q8IUatyVDgGMYHEp0j9y/
         yfwhmOAX8wXOHS0rECYY138S78EX3plAs0jB0UKPv4JXa/iXUTNVz4aDCyH/XYj+KDLi
         T7Pw==
X-Received: by 10.43.61.78 with SMTP id wv14mr27243059icb.93.1434996258793;
        Mon, 22 Jun 2015 11:04:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id l128sm13220231iol.1.2015.06.22.11.04.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 11:04:18 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272401>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	git --git-dir=dst/.git branch -D bogus &&
> +	git  --git-dir=dst/.git config --add \
> +		receive.fsck.missingEmail ignore &&
> +	git  --git-dir=dst/.git config --add \
> +		receive.fsck.badDate warn &&

Funny double-SP (will locally fix).

There are a few other minor style nits (not in this patch but in
other patches in the series) like

	s/free((char *) var)/free((char *)var)/;

that I locally added SQUASH, and I may also have tweaked some log
messages.  Please check what you will see in 'pu' when I push the
day's integration out later.

Thanks.
