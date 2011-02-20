From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Recursively checkout, merge and reset populated
 submodules
Date: Sat, 19 Feb 2011 22:49:05 -0800
Message-ID: <7vd3mnmc9q.fsf@alter.siamese.dyndns.org>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
 <4D5FF6E7.8090104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 20 07:49:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr36j-0001Vx-9V
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 07:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab1BTGtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 01:49:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1BTGtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 01:49:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32AFD4A26;
	Sun, 20 Feb 2011 01:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e150JT61Q3tuQY8zxkaJm26BJGA=; b=j+YvXI
	CxLu5d6XnCS7cTTzhnmuQQ/Wo+1OxVtWaZXZ15he5fX2099FPrTvtX+kvRb/BQsf
	p26tusaWmHe/x+MobyipXFWCGrY+OmntMYjYTBEhmbeMaAT3EmPVPQlt4jDlqiZi
	47aqs7RdjnR8o/8Y4yxKerpdTTju5j+zJX4SY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nP0U1xRsr0wnVQIiAkJ0H8nChy8rsCFr
	X8KXxYfGDjfUT7gelPwrcSaNDPTZnNet04QQMCLXPSwuK7S81yF3r8nkRLMloABv
	c1EMPS4mht8PlPQ5y+iP+jc3HhjnGRaytlN277xkpyfs4XdBAQaYRh6GXcn/LBiN
	R2HdxlYnPQs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C7224A24;
	Sun, 20 Feb 2011 01:50:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0436E4A23; Sun, 20 Feb 2011
 01:50:15 -0500 (EST)
In-Reply-To: <4D5FF6E7.8090104@web.de> (Jens Lehmann's message of "Sat\, 19
 Feb 2011 17\:59\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE2DFD72-3CBD-11E0-860C-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167402>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Risks:
> The commands might run longer, for those users who use submodules
> to gain performance by putting large and/or many files into
> submodules this may be unacceptable.

Nobody would object to make this facility available via config, I think,
but I suspect that it is way too premature to decide which way should
eventually be the default at this point.

My recommendation is to ease this in as an optional feature you can easily
turn on with a config, let people try it for a few release cycles and then
if we reach the concensus that this should be on by the default, start the
usual "warn and tell how to keep the old behavior" one cycle before 1.8.0
(or 1.9.0 if we end up not having enough cycles before 1.8.0).
