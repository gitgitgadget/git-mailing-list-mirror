From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH il/rfc-remote-fd-ext] Fix build on Windows
Date: Sat, 14 Aug 2010 20:31:46 +0200
Message-ID: <201008142031.46759.j6t@kdbg.org>
References: <201008140009.19291.j6t@kdbg.org> <20100814093801.GA28522@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Aug 14 20:31:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkLWN-0005D2-V3
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 20:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457Ab0HNSbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 14:31:50 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:38380 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871Ab0HNSbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 14:31:50 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AF80610012;
	Sat, 14 Aug 2010 20:31:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0D83F19F5FD;
	Sat, 14 Aug 2010 20:31:47 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100814093801.GA28522@LK-Perkele-V2.elisa-laajakaista.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153567>

On Samstag, 14. August 2010, Ilari Liusvaara wrote:
> The code doesn't really need POLLNVAL (Its just there for "can't happen"
> case). POLLOUT is needed. I looked at poll emulation code: It returning
> EINVAL causes transfer loop to fail quick.
>
> I think its possible to write the loop in terms of select instead of poll.
> Would this be better for Git on Windows?

No. select does not work with pipes on Windows.

-- Hannes
