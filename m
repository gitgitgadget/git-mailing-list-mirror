From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Wed, 16 Feb 2011 15:52:13 +0100
Message-ID: <4D5BE49D.1040402@viscovery.net>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 15:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppik0-0008TT-3L
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 15:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054Ab1BPOwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 09:52:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37223 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750921Ab1BPOwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 09:52:22 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ppijo-00055H-7F; Wed, 16 Feb 2011 15:52:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DD9111660F;
	Wed, 16 Feb 2011 15:52:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166968>

There's one annoying regression with this series: It does not accept
abbreviated options anymore. In particular, 'git rebase --cont' is now an
error. I use this a lot since I don't have command completion. This used
to work (only) with interactive rebase.

And a side note: the error message is -- during a rebase that stopped at
an 'edit' instruction:

$ git rebase --cont
Usage: git rebase [--interactive | -i] [-v] [--force-rebase | -f]
[--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]

It nowhere mentions --continue, --skip, --abort etc. That's perhaps worth
fixing.

-- Hannes
