From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: GIT over HTTP
Date: Thu, 22 Jul 2010 07:01:56 +0300
Message-ID: <20100722040156.GA7353@LK-Perkele-V2.elisa-laajakaista.fi>
References: <AF1397F5-0394-4CCD-937A-7B11513CC174@iamas.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andreas Schneider <as@gestaltung.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 06:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObmyU-0007hX-9T
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 06:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab0GVEB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 00:01:27 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:49469 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab0GVEB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 00:01:26 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 55496C849D;
	Thu, 22 Jul 2010 07:01:25 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A053FB5277B; Thu, 22 Jul 2010 07:01:25 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 1A84341BE7;
	Thu, 22 Jul 2010 07:01:23 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <AF1397F5-0394-4CCD-937A-7B11513CC174@iamas.ac.jp>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151442>

On Thu, Jul 22, 2010 at 11:03:50AM +0900, Andreas Schneider wrote:
> after lost of research on the www i am still at a loss on how to
> properly do push/pull over HTTP
> 
> it seems to work on the GIT level, however PUSHS to the remote repository do
> NOT show up in the file-structure: adding a file locally, then pushing to the remote repository - the file will not appear in the remote listing, however it became part of the remote repository.

This is normal. Push does not update working copy. You would need a hook for
that.

< snip dav configuration >

And hooks will not work with WebDAV. You MUST push over some smart transport,
like ssh:// or HTTP with http-backend. HTTP/WebDAV does not cut it.

-Ilari
