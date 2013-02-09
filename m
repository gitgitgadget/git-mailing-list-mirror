From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Permission denied on home dir results in fatal error as of
 1.8.1.1
Date: Fri, 08 Feb 2013 16:50:51 -0800
Message-ID: <7v6222xqc4.fsf@alter.siamese.dyndns.org>
References: <CAECnihxpvtE1XejzHDCRBF=GkyBHmb53WDLa16Suiq=4SeYzvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nick Muerdter <stuff@nickm.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3yey-0005Rw-Ti
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274Ab3BIAuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:50:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076Ab3BIAux (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:50:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 126EEB4A3;
	Fri,  8 Feb 2013 19:50:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AAGTMbru1leFhNakw8MJfJ+bipY=; b=BPXRuy
	DlalkfmPYtnaqObTnaurJkNxQspvKGkq+XSu9ztjOK5TqpTd7Rb5tA0QAOFmP/IE
	12HVb1v+TifAOUh/Tux55IVIqAmOtOtb7ibVao+Ttqqbv0byPG3s7FK+U8bezG1E
	bNfnk8ckLCNvLaaRfuJsMnOBWMVB7/wEbiqvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MoWg8cVqZWTBR8oroO2UtPUIM5JjAcGU
	Lxe+qBiM3R9EBYkfH2m36U0pvUFfJyBiwcpQMeiePYdoxWaK7LqW2FVMxtHxyR5X
	lIYmUJS42rLr3ygCebzl4zC3dVgYRLSITsrm7hT/trKKcezFL0DfsAUgradF8vSZ
	oufFT2+cV8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06A55B4A2;
	Fri,  8 Feb 2013 19:50:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F3CBB49F; Fri,  8 Feb 2013
 19:50:52 -0500 (EST)
In-Reply-To: <CAECnihxpvtE1XejzHDCRBF=GkyBHmb53WDLa16Suiq=4SeYzvA@mail.gmail.com> (Nick
 Muerdter's message of "Fri, 8 Feb 2013 17:40:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0FDC564-7252-11E2-9347-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215837>

Nick Muerdter <stuff@nickm.org> writes:

> As of git 1.8.1.1 and above (tested up to 1.8.1.3), if the home
> directory can't be accessed, it results in a fatal error. In git 1.8.1
> and below this same setup just resulted in warnings. Was this an
> intentional change?

I think this was done to not just help diagnosing misconfiguration,
but to prevent an unintended misconfiguration from causing problems
(e.g. the user thinks user.name is set up correctly, but forbids Git
from reading it from the configuration files, and ends up creating
commits under wrong names).

Somebody please correct me if this weren't the case...
