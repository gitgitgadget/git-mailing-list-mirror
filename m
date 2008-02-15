From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] test mailinfo rfc3676 support
Date: Fri, 15 Feb 2008 11:01:05 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802151058270.30505@racer.site>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com> <1203042077-11385-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 12:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPyKL-0004Yz-Ut
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 12:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762654AbYBOLBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 06:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759244AbYBOLBL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 06:01:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:50334 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758618AbYBOLBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 06:01:09 -0500
Received: (qmail invoked by alias); 15 Feb 2008 11:01:07 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 15 Feb 2008 12:01:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/m/9t5rnfmP3968Pi9lh++5Utku/CB8c1BuxQm4d
	qkNnNPEm8D1wbL
X-X-Sender: gene099@racer.site
In-Reply-To: <1203042077-11385-2-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73953>

Hi,

On Thu, 14 Feb 2008, Jay Soffian wrote:

> +@@ -20,6 +20,13 @@ static enum  {
> +static enum  {
> +	TYPE_TEXT, TYPE_OTHER,
> +} message_type;
> ++/* RFC 3676 Text/Plain Format and DelSp Parameters */
> ++static enum {
> ++	FORMAT_NONE, FORMAT_FIXED, FORMAT_FLOWED,
> ++} tp_format;
> ++static enum {
> ++	DELSP_NONE, DELSP_YES, DELSP_NO,
> ++} tp_delsp;
> +
> +static char charset[256];
> +static int patch_lines;

Hmm.  Such a corrupt patch (lacking spaces at the beginning of the line) 
would not be accepted by git-apply.  I briefly thought about teaching 
git-apply to grok that, with a flag.  But now I think that mailsplit 
should handle that, no?

Question is: can you "de-corruptify" such a patch? (Note: it would 
probably need a validating step, too, i.e. count the lines it added a 
space to, and match that up with the numbers in the @@ lines)

Ciao,
Dscho
