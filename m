From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
 list
Date: Tue, 01 Dec 2009 11:20:12 -0800
Message-ID: <7vaay2zekz.fsf@alter.siamese.dyndns.org>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com> <7viqcrbl22.fsf@alter.siamese.dyndns.org> <36ca99e90911302249r5f77f031o73cc7bb13dc375cf@mail.gmail.com> <7vy6ln2llw.fsf@alter.siamese.dyndns.org> <36ca99e90912010132iee0d42fo933aeb12833ad1ad@mail.gmail.com> <7v8wdm1ui1.fsf@alter.siamese.dyndns.org> <36ca99e90912011014sd7372d0yc234873a26c2ae43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 20:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFYH1-0005ov-5H
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 20:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbZLATUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 14:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbZLATUT
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 14:20:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZLATUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 14:20:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F04C84937;
	Tue,  1 Dec 2009 14:20:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rZbnxmm4Q/G3nxoBV6qmxCMlP7g=; b=RX5b1G
	7Qo5QVFNFmGnaEDD2To+7jsE3mZA9bZqsxX8ce7zwDrADph2r2W2xEfc1twI8KI2
	sTwAXs0oTSChqMOXozECQLRfh7PPPnKFjzawcC/Wnr4yajdPYI6MHTAMtemP/4zz
	2l0M3wkYxmUsvxhZW24obo1JzomF4xG4U88tE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VRMWKzjLXIPYYyZ9HpgMxTZIK/ZHwFZy
	T1y7q6Gv6YQlEDfQYjOe5Cpuhq0SpzMike7wBjd+hEFc4DgjewUOOEHsnIIuW3Vg
	UI6efHfrjmeBCXlnnDP89mvC+rnNBx6QgCUduhiaFB1j5p9Oyi0fn6S6tRKCM3R1
	zmiqj08QuEQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21A1E84935;
	Tue,  1 Dec 2009 14:20:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0F228492E; Tue,  1 Dec
 2009 14:20:13 -0500 (EST)
In-Reply-To: <36ca99e90912011014sd7372d0yc234873a26c2ae43@mail.gmail.com>
 (Bert Wesarg's message of "Tue\, 1 Dec 2009 19\:14\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90B306F2-DEAE-11DE-B9C2-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134250>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> A quick test with my use case does not show errors in the maint
> branch. So it should not be needed (except the memory leak fix of the
> .util member). And valgrind confirms this.

Thanks.
