From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Mon, 30 May 2011 06:50:55 +0200
Message-ID: <4DE3222F.6030604@alum.mit.edu>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vpqn2psjv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 06:51:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQuRZ-0003YT-F7
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 06:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1E3EvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 00:51:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50654 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab1E3EvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 00:51:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BECF4D.dip.t-dialin.net [84.190.207.77])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p4U4otGN019134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 May 2011 06:50:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vpqn2psjv.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174719>

On 05/28/2011 08:51 PM, Junio C Hamano wrote:
> "git reset --hard" used to be such a command in simpler times. It removes
> MERGE_HEAD unconditionally, so that a confused user can start from scratch
> without having to worry about what was in progress. As a devil's advocate,
> I am wondering if it is a good idea to simply teach "reset --hard" to also
> remove any and all "sequence" cruft (.git/rebase-apply, .git/rebase-merge,
> CHERRY_PICK_HEAD; we might have others I do not recall offhand) and be
> done with it. It is a large hammer, but it is certainly the easiest to
> explain and the simplest to understand way to get out of any troubles.

If it would be desirable to separate the resetting of the working tree
from the resetting of any in-progress operation, perhaps "git reset
--abort" (by analogy with "git reset --abort" etc) would be a possible
spelling of the latter.  To reset any in-progress operations *and* reset
the working tree, on could use "git reset --hard --abort".

I strongly agree with another poster that it would be useful if "git
status" would print information about in-progress operations.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
