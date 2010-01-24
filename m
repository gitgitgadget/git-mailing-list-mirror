From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Windows: avoid static dependency on advapi32.dll
Date: Sun, 24 Jan 2010 20:20:08 +0100
Organization: 
Message-ID: <201001242020.08534.j6t@kdbg.org>
References: <1264359231-4672-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 20:21:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ81W-0008Gm-Hi
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 20:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab0AXTVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 14:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759Ab0AXTVQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 14:21:16 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:58887 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752717Ab0AXTVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 14:21:16 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7AE182C400A;
	Sun, 24 Jan 2010 20:21:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9DDBB19F5EC;
	Sun, 24 Jan 2010 20:20:08 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1264359231-4672-1-git-send-email-michael.lukashov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137913>

On Sonntag, 24. Januar 2010, Michael Lukashov wrote:
> This DLL is used to get default user name. By looking
> up the only function that we need at runtime, we can
> avoid the startup costs of this DLL.

Sorry, no. This doesn't work. Even though git.exe does no longer depend on 
advapi32.dll directly, it does so indirectly (via ws_32.dll). This patch is 
not an improvement, therefore: NAK.

-- Hannes
