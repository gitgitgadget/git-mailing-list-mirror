From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 1/2] Report exec errors from run-command
Date: Fri, 25 Dec 2009 19:15:05 +0200
Message-ID: <20091225171505.GA11830@Knoppix>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <200912251539.35201.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 25 18:15:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NODl1-0003In-RP
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 18:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579AbZLYRPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 12:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbZLYRPN
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 12:15:13 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:45988 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541AbZLYRPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 12:15:11 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 2179618D03C;
	Fri, 25 Dec 2009 19:15:09 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02A22EBCDC; Fri, 25 Dec 2009 19:15:08 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 0800227D8C;
	Fri, 25 Dec 2009 19:15:07 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <200912251539.35201.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135681>

On Fri, Dec 25, 2009 at 03:39:34PM +0100, Johannes Sixt wrote:
> 
> The only really *important* errno of a failed exec is ENOENT. For this case, 
> wouldn't it be easier to do the PATH lookup manually in the parent (before 
> the fork()), and use execv() in the forked child rather than execvp()?

In fact there is API for getting all valid commands on $PATH for given command
prefix. That would take care of ENOENT and most of EACCESS.

But OTOH, its nice to be able to report any error.

-Ilari
