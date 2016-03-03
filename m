From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bypassing hooks while cherry-picking
Date: Thu, 03 Mar 2016 13:30:04 -0800
Message-ID: <xmqqwppj1c83.fsf@gitster.mtv.corp.google.com>
References: <56D576A1.3020202@greg0ire.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: greg0ire <postmaster@greg0ire.fr>
X-From: git-owner@vger.kernel.org Thu Mar 03 22:30:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abapD-0000Da-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 22:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363AbcCCVaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 16:30:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758215AbcCCVaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 16:30:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDA8B4832E;
	Thu,  3 Mar 2016 16:30:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mk+bomcQ5bkg+CGl4kaDUaccLls=; b=uWq7gn
	2WOLyFTs0pqpBdLZXtHEPduJq+XOWU4qPlGlUc3rl/Y5sFyIHqAGb9+Yfd059DI+
	mYDfIR/ZTUeNjSD5tDcqdkmYmqWmo/5RVGkY00+kuJpAzUkIhKB0xgAe2L2r8Mhq
	2Hwhou9O+B7OhHe3WG5sxikeW58GFwcS8rbXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gm0taeVIS3E0Uu0JI0Fc6/FP8L3akV5X
	cB4ixoQIFBSXsm5jkQtpcyvoGUiDHuOZ0ZFAlAFOGIZzXPUk6Yp/2OGi3agCn64f
	PhJjt2TaL3vVo0VDYdAlLzCLxG9Wnu6wTCZaLXBqZZEp9knKJgxT2k4fixoFlhiI
	jNPUP1UNLBw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCA8E4832A;
	Thu,  3 Mar 2016 16:30:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8BDA148329;
	Thu,  3 Mar 2016 16:30:06 -0500 (EST)
In-Reply-To: <56D576A1.3020202@greg0ire.fr> (greg0ire's message of "Tue, 1 Mar
	2016 12:01:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 194B631A-E187-11E5-A06B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288212>

greg0ire <postmaster@greg0ire.fr> writes:

> Steps to reproduce :
>
> 1. create a pre-commit hook
> 2. create a commit that fails the hook, and bypass the hook
> 3. checkout another branch
> 4. might be optional : create a conflicting change with the previously
> created commit
> 5. cherry-pick the commit
> 6. might be optional : solve the conflick and use git cherry-pick --continue

Wouldn't "commit --no-verify" at that last step, instead of
"cherry-pick --continue", just work?
