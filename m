From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 12:42:39 -0500
Message-ID: <20070716174239.GG19073@lavos.net>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <11846075213759-git-send-email-sithglan@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUb0-00042D-TX
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbXGPRmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbXGPRmw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:42:52 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:6132 "EHLO
	asav04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbXGPRmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 13:42:50 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav04.insightbb.com with ESMTP; 16 Jul 2007 13:42:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqMwAABLm0ZKhvbzRmdsb2JhbACBSIVkiAYBAQE1
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 926FD309F32; Mon, 16 Jul 2007 12:42:39 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <11846075213759-git-send-email-sithglan@stud.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52696>

On Mon, Jul 16, 2007 at 07:38:41PM +0200, Thomas Glanzmann wrote:
>  	const char *slash = path;
> +        struct stat st;

>  		memcpy(buf, path, len);
>  		buf[len] = 0;
> +                if (!stat(buf, &st) && S_ISDIR(st.st_mode))
> +                        continue; /* ok */

You've got some whitespace damage here.  Git's style is to use tabs.

-bcd
