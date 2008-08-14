From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 09:39:46 +0200
Message-ID: <48A3E142.9060606@viscovery.net>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 14 09:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTXS2-0002HY-O4
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 09:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYHNHjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 03:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbYHNHjv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 03:39:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4514 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYHNHju (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 03:39:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KTXQw-0001Dg-Nn; Thu, 14 Aug 2008 09:39:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 640F954D; Thu, 14 Aug 2008 09:39:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1218687684-11671-1-git-send-email-marcus@griep.us>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92331>

Marcus Griep schrieb:
> +void human_readable_size(char *buf, int buf_size, double size /* in bytes */)
> +{
> +	char human_readable_prefixes[10] = "BKMGTPEZY";
> +	if (buf_size < 5)
> +		die("insufficient buffer size");
> +	int i = 0;
> +	for (; i < 8 && size >= 1000 ; ++i, size = size / 1024)
> +		;
> +	if (size >= 1000)
> +		die("size greater than 999Y");

No need to die here. Just make the buffer large enough, and you can have
something that is as large as 18446744073709551615Y.

-- Hannes
