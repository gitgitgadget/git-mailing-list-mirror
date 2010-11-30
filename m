From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC 04/20] rebase: remove unused rebase state 'prev_head'
Date: Tue, 30 Nov 2010 08:29:05 +0100
Message-ID: <4CF4A7C1.3000202@drmicha.warpmail.net>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com> <1290715083-16919-5-git-send-email-martin.von.zweigbergk@gmail.com> <4CEF67AB.6050700@drmicha.warpmail.net> <7v7hfv262a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 08:31:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNKgP-00028X-F3
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 08:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab0K3HbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 02:31:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37157 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753480Ab0K3HbT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Nov 2010 02:31:19 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8D048525;
	Tue, 30 Nov 2010 02:31:19 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 30 Nov 2010 02:31:19 -0500
X-Sasl-enc: V6gLsnkImtxLe/UC0431PHiNt+OtAuLime80BE5+1LFs 1291102279
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 331604051EC;
	Tue, 30 Nov 2010 02:31:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7v7hfv262a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162471>

Junio C Hamano venit, vidit, dixit 29.11.2010 22:06:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Martin von Zweigbergk venit, vidit, dixit 25.11.2010 20:57:
>>> The rebase state 'prev_head' is not used. Remove it.
>>>
>>> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>>> ---
>>
>> The actual value of prev_head was never used. But the check for its
>> non-nullness made sure that git-rev-parse HEAD^0 succeeded when
>> $merge_dir was created. Have you made sure that we don't need that check?
> 
> I think we are Ok.
> 
> It was a bit sloppy of 9e4bc7d (rebase: cleanup rebasing with --merge,
> 2006-06-24) to use the output from `git-rev-parse HEAD^0`, which would
> give you "HEAD^0" as string when HEAD does not exist.  Even though the
> command itself will exit with non-zero status, the exit status was never
> checked.  After 9e4bc7d (rebase: cleanup rebasing with --merge,
> 2006-06-24), we didn't seem to have any reason to use $prev_head, iow,
> this change was probably way overdue.

Good! I just wanted to make sure that it wasn't used in some opaque way.

Michael
