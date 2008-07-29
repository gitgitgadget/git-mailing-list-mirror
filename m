From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Fundamental problem with relative system paths] [PATCH 2/2]
 run-command (Windows): Run dashless "git <cmd>"
Date: Mon, 28 Jul 2008 22:29:07 -0700
Message-ID: <7v8wvlmf6k.fsf@gitster.siamese.dyndns.org>
References: <1217224228-31303-1-git-send-email-prohaska@zib.de>
 <1217224228-31303-2-git-send-email-prohaska@zib.de>
 <1217277453.488e2e0db0f41@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhms-0006Iz-F1
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbYG2F3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbYG2F3S
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:29:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbYG2F3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:29:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 84B8941EF4;
	Tue, 29 Jul 2008 01:29:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C1B7841EF3; Tue, 29 Jul 2008 01:29:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4939DB86-5D2F-11DD-9FCC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90576>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Zitat von Steffen Prohaska <prohaska@zib.de>:
> ...
>> The patch below might fix the problem by always calling 'bin/git'
>> for builtin commands.  The computation in system_path() would
>> always start from 'bin' and thus yields predictable results.  I
>> am not sure however if it fully solves the problem because other
>> code paths might run the dashed forms directly.
>
> This paragraph should go into the commit message.

> ...
> Your patches make a lot of sense.

I was almost going to suggest doing this everywhere not just on Windows,
but execv_git_cmd() on the POSIX side already runs "git" wrapper, so this
patch makes them in line, finally.

>> -- 8< --
>> We prefer running the dashless form, so we should use it in
>> MinGW's start_command(), too.
>>
>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>
> Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
>
> -- Hannes
