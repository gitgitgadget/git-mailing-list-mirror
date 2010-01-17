From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH 0/2] Make it easy to use branch --track on existing
 branch
Date: Sun, 17 Jan 2010 16:40:31 +0200
Message-ID: <20100117144031.GA20335@Knoppix>
References: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jan 17 15:41:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWWJJ-0005Hv-L1
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 15:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab0AQOkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 09:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443Ab0AQOky
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 09:40:54 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:56091 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab0AQOkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 09:40:51 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id E25E3C7D0F;
	Sun, 17 Jan 2010 16:40:49 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A010EEDFB52; Sun, 17 Jan 2010 16:40:49 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id B6F894066;
	Sun, 17 Jan 2010 16:40:45 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137300>

On Sun, Jan 17, 2010 at 03:06:50PM +0100, Matthieu Moy wrote:
> 
> The first patch makes it possible to use branch --track on an existing
> branch (checked-out or not, regardless of -f), and the second warns on
> a newly introduced irrelevant case.

Yay. This is one of smaller entries from my todo list (the remaining
entry that's small enough to still make it into 1.7 is command to
set URL remote points to[*]).

But If I read the patch correctly, you can't just arbitrarily set the
tracking branch since the IDs must match. So if somebody screws the
ref creation so that it lacks upstream data, then both local and upstream
change. Push will fail. Pull will fail. And now neither checkout --track
(due to same-hash check) nor push --set-upstream (due to pushed or up to
date) help.

[*] Yes, I know you can edit .git/config, but I would want "official sounding"
(read: git remote subcommand) command to edit it (and no, delete & recreate
doesn't do the right thing).

-Ilari
