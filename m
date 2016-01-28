From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an empty override
Date: Thu, 28 Jan 2016 14:06:57 -0800
Message-ID: <xmqqvb6dl5oe.fsf@gitster.mtv.corp.google.com>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
	<xmqqr3h6bgbe.fsf@gitster.mtv.corp.google.com>
	<AB5433EB-2C86-4A71-9E9F-057AC3CC150A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 23:07:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOuiX-0005u0-6O
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 23:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbcA1WHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 17:07:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751010AbcA1WG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 17:06:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 129FE3F6C1;
	Thu, 28 Jan 2016 17:06:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DWcV3nYH2Dv0Cf2RVAe2O2AZFg=; b=dSAmV8
	Lp7K/r6kYkO5D522HCs98DWf9ahY6NzONNWwSRXTx3QzetYTHJxfgi6rC3my9E+4
	EavL17/Ew07gMz51NwpUbLU74A/Y5dN/YnHTOgVqxjrva9ODIG3kTRMbJ2SXmHV7
	C/gSfAdL/SBIc7PoEtch1sGC3Ylz7QM0OpeoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WnEp1mj5y4kMvjOnlnHgVSzUSIhGvT+k
	pTDM17/gwiFkrddigWwxKhs2AtA7gDlLzHaLSx9NksrD/6S4YHcizVUwSGHKDdTV
	w92YTtarTlPlvhJPFz8G1t9JBbJZhUCO+RVfggk3dEDAePYY/LrPw8Z3gHc/WwCk
	Jr2paEHuYDQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A9C43F6C0;
	Thu, 28 Jan 2016 17:06:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7AFED3F6BE;
	Thu, 28 Jan 2016 17:06:58 -0500 (EST)
In-Reply-To: <AB5433EB-2C86-4A71-9E9F-057AC3CC150A@gmail.com> (Lars
	Schneider's message of "Thu, 28 Jan 2016 10:27:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 733FA620-C60B-11E5-892C-B4986AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285038>

Lars Schneider <larsxschneider@gmail.com> writes:

> If the clean/smudge command of a Git filter driver (filter.<driver>.smudge and
> filter.<driver>.clean) is set to an empty string ("") and the filter driver is
> not required (filter.<driver>.required=false) then Git will run successfully.
> However, Git will print an error for every file that is affected by the filter.
>
> Teach Git to consider an empty clean/smudge filter as legitimately disabled
> and do not print an error message if the filter is not required.

That makes more sense to me.
