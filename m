From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: shared permissions on COMMIT_EDITMSG
Date: Thu, 28 Jan 2010 13:14:25 +0200
Message-ID: <20100128111425.GA29577@Knoppix>
References: <4B61569A.1010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 12:14:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaSKk-0000hG-At
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 12:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab0A1LOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 06:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185Ab0A1LOc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 06:14:32 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:56411 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab0A1LO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 06:14:29 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 1D1CB8C1D1;
	Thu, 28 Jan 2010 13:14:28 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A01B90171F4; Thu, 28 Jan 2010 13:14:28 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 053121C6393;
	Thu, 28 Jan 2010 13:14:26 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <4B61569A.1010808@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138247>

On Wed, Jan 27, 2010 at 11:19:22PM -1000, William Pursell wrote:
> With git-init --shared=0660 and a umask of 022,
> the first commit to the repository creates
> the file COMMIT_EDITMSG with mode 0644
> instead of 0660.  I believe this is incorrect
> behavior.  Simple fix:
 
COMMIT_EDITMSG is related to committing, committing needs
working copy, and shared working copies don't work all too
well (and Git can't do anything about that because all kinds
of stuff edits the files there, not just Git).

Shared repository settings are meant to override umasks
for files in actual repository itself.

-Ilari
