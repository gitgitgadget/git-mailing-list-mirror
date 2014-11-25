From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] Rename sort_string_list() to string_list_sort()
Date: Tue, 25 Nov 2014 10:17:01 -0800
Message-ID: <xmqq1tortaaq.fsf@gitster.dls.corp.google.com>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
	<1416902555-10748-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 25 19:17:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtKfn-000591-VD
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 19:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbaKYSRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 13:17:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750967AbaKYSRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 13:17:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B29751F849;
	Tue, 25 Nov 2014 13:17:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VCoWGsODGhJPiW4tVO6E6kcIzZ0=; b=UHnn8M
	yWJiZjStVmFEbnDq6llkf6Yu8v9ZeQw6ONVbQwVsHxHh5WWkXdgc9qm9cBenKGee
	M1/0W8cBc67NzhCoKvbAX+mwGwqHLuoUBEMOyxw0badtJZ7wy83z+hOrfcGyGayy
	3r+Nz/9cfWq5YDzWxZeQ7UBUFAYf464fRMIeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wFzXJFa1fHSzrvNMsZPcM/D4vVN//4nr
	TkxUEpttXOL7/ax9PHQxRnfTMuOH3jyQ8BGI1J4UVlB9aib1QU6AJEqsbg1tnkW9
	GS/0tifjA/BxzWUK9tau9RdWDC6+TpvNMMkXpCdjO3p4lUcGGxxE1FJr3SEtTbcN
	tUoJWg+TaV4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A770D1F848;
	Tue, 25 Nov 2014 13:17:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 165001F847;
	Tue, 25 Nov 2014 13:17:03 -0500 (EST)
In-Reply-To: <1416902555-10748-8-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 25 Nov 2014 09:02:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 415EE24E-74CF-11E4-B678-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260233>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The new name is more consistent with the names of other
> string_list-related functions.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Thanks.  I do not think I deserve a credit, though ;-)

Looking at string-list.h, I think this was one of the bigger wart.
I think we should do the same for filter_string_list(), but let's
worry about it outside this series.

print_string_list() is probably not useful in general use (who uses
it???) in the first place, so I do not care too much about it ;-)
