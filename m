From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 2/2] submodule: port init from shell to C
Date: Fri, 22 Jan 2016 14:30:00 -0800
Message-ID: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
References: <1453260274-31005-1-git-send-email-sbeller@google.com>
	<1453418323-29587-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:30:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkDh-00010i-Dq
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbcAVWaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:30:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755233AbcAVWaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:30:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E56393F70A;
	Fri, 22 Jan 2016 17:30:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9mRIEwJq/JejOtHke85SokohqcA=; b=nNOWRx
	lUWrBe1Xf2jiVktj6gY0+69On4/GEaje72zIP3mTIDN962wrtpoUbsn11mWQ6A1N
	XIJ5z913z/JmaBpAeiz83MRZkfg7CGw9S6lyLXVxCwy477ZN04Nkate45zvhrZbD
	wmyr19wKnYIRMMWw6uCGGGREhZvmPDcpFzoPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKAHE+nIgQmMTelLroCnXgO0p4yY6xiE
	wJ8m1PWlGjyL02OV2REkQUlWUmyCCfYu/KunJeOtW+g4JKAg7fUelLgl4ubx799+
	GVngCea3zchhdYUBx1MYf911yzfE1fqdkk+zraa7J7ngr4OzGVgaB4NLAJIFsBuC
	F569KNpYhJM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 803383F6FF;
	Fri, 22 Jan 2016 17:30:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C7F8D3F6FC;
	Fri, 22 Jan 2016 17:30:01 -0500 (EST)
In-Reply-To: <1453418323-29587-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 21 Jan 2016 15:18:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD4B03FE-C157-11E5-B857-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284597>

Stefan Beller <sbeller@google.com> writes:

> By having the `init` functionality in C, we can reference it easier
> from other parts in the code.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Hi Junio,
>
> please replace the top-most patch of sb/submodule-init with this patch.

Will do, but it seems that you'd have to be replacing 1/2 as well,
so perhaps send both when that happens?
