From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH v2 12/16] Smart fetch and push over HTTP: server side
Date: Tue, 13 Oct 2009 09:30:15 +0200
Message-ID: <4AD42C87.6000205@viscovery.net>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-13-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:39:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxbw6-00016f-ED
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933673AbZJMHax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756022AbZJMHaw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:30:52 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44386 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZJMHaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:30:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mxbpn-0000Hh-Ab; Tue, 13 Oct 2009 09:30:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 34DAD9614; Tue, 13 Oct 2009 09:30:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1255400715-10508-13-git-send-email-spearce@spearce.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130139>

Shawn O. Pearce schrieb:
> diff --git a/http-backend.c b/http-backend.c
> index 39cfd25..adb3256 100644
> --- a/http-backend.c
> +++ b/http-backend.c

#include "run-command.h" is missing here because you added it already in
patch 10/16 unnecessarily.

> +	if (start_command(&cld))
> +		die_errno("Cannot start %s", argv[0]);
> ...
> +	if (finish_command(&cld))
> +		die("%s terminated with error", argv[0]);

start_command and finish_command already write an error message for you
that includes argv[0] and errno. You can just exit(1) here.

-- Hannes
