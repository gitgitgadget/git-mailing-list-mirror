From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] Makefile: honor NO_CURL when setting REMOTE_CURL_*
 variables
Date: Tue, 19 Jan 2010 18:58:58 +0200
Message-ID: <20100119165858.GA24065@Knoppix>
References: <1263915552-32537-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 17:59:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXHQC-0005CB-Ce
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 17:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab0ASQ7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 11:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572Ab0ASQ7M
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 11:59:12 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:40998 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0ASQ7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 11:59:10 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id EE719C7B0A;
	Tue, 19 Jan 2010 18:59:02 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0325AE89FB; Tue, 19 Jan 2010 18:59:02 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 974011C6395;
	Tue, 19 Jan 2010 18:58:58 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <1263915552-32537-1-git-send-email-j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137474>

On Tue, Jan 19, 2010 at 04:39:12PM +0100, Johannes Sixt wrote:
> Previously, these variables were set before there was a chance to set
> NO_CURL.
> 
> This made a difference only during 'make install', because by installing
> $(REMOTE_CURL_ALIASES), the rule  tries to access $(REMOTE_CURL_PRIMARY),
> which was never installed. On Windows, this fails; on Unix, stale symbolic
> links are created.
 
<snip patch>

I didn't even compile-test it, but based on quick look I don't see any
obivous mistakes. There are no references to REMOTE_CURL_* in section
moved over, and the variable values should not differ unless section skipped
sets NO_CURL. So:

Acked-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>

-Ilari
