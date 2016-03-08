From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Also read SQUASH_MSG if a conflict on a merge squash occurred
Date: Tue, 08 Mar 2016 10:51:47 -0800
Message-ID: <xmqq1t7kls58.fsf@gitster.mtv.corp.google.com>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
	<xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
	<56DF1EBD.8050503@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Tue Mar 08 19:52:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adMjc-00019h-N5
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 19:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbcCHSvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 13:51:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750787AbcCHSvw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 13:51:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84E0149F5A;
	Tue,  8 Mar 2016 13:51:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QRadt/Jo4nSvujJqUU+x4PHzmNY=; b=QOgeYm
	et7vOEmkF1BSO+lS/4bRpaTcNAun8nS6UCHRAVZdmjwx6YaYyk6NlGi2XFj37XBy
	OUDtoi/23NpYOa7nK1cr3mcmDVIrrOa8cGzC58VHcHWTjapFN0k9FV+IsS+x3fbM
	tSHyeAoLX4wZL5qEzaVECyj0S3jxSdZfnUikc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vyLfixUCop+IsXdZZhRva27Y1C5CQwJe
	2dF8npcH3T5cTtgumCMxIa5YDEsi7PH9JNvt844WPJ9k5ztAGCgm0eAvIfHStZIy
	sW5HKRdE+/pRmD1G6Dj5KjF1FA469a6Nfv6shuezxDL3gyFvEYOh1egsB2S04eFZ
	JvEzyS9bJFY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B26049F51;
	Tue,  8 Mar 2016 13:51:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E054E49F50;
	Tue,  8 Mar 2016 13:51:48 -0500 (EST)
In-Reply-To: <56DF1EBD.8050503@cs-ware.de> (Sven Strickroth's message of "Tue,
	8 Mar 2016 19:49:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D050BAF8-E55E-11E5-B96D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288449>

Sven Strickroth <sven@cs-ware.de> writes:

> Here hook_arg1 would be always "merge" and never "squash"... Before my
> change it was only "squash" if no conflict occurred.

Oh, that wasn't an intended change.  It was merely an illustration
of a possible restructuring of the flow to avoid having to have
identical read functions in two separate places.
