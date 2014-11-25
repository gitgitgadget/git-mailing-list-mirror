From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] prune_remote(): exit early if there are no stale references
Date: Tue, 25 Nov 2014 10:09:23 -0800
Message-ID: <xmqq61e3tang.fsf@gitster.dls.corp.google.com>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
	<1416902555-10748-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 25 19:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtKYV-0007Xt-QC
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 19:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbaKYSJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 13:09:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751111AbaKYSJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 13:09:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1490A1F681;
	Tue, 25 Nov 2014 13:09:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ustTtZRspivj8WLGAY6L708rjtM=; b=v5Bjw8
	6bsk+g0FlF5XMYzMytqzsd8PG83JeU4ZzlprTItdrZOmIAnEobseMcHSVhttnttl
	GXtFz8o97iY1tdDKkVSChPdgf5WDfe5Wwmh/9w/TU/NrpSpX72n6iOeqgkr0FCur
	ckXqYQkrtYyOqq+z4PbCuE1PNNJOYfUeap9+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lYaM0wSeNnXR7MSKX2ebDspH8XjBArez
	Hfnrwgwcs23jdclm+U9WPNFpp4DGL/ARyUVlWDp0acGOXj48omZzMsqkIkP9BJpL
	Kf/7rA4IDer3XddJKEDOq+Gf5rfEZ20skRQ0V38ERIAjgpUCVM6mNDXwI+7eBRJ3
	14025M0ow88=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A801F680;
	Tue, 25 Nov 2014 13:09:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78EC31F67F;
	Tue, 25 Nov 2014 13:09:25 -0500 (EST)
In-Reply-To: <1416902555-10748-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 25 Nov 2014 09:02:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 309487B2-74CE-11E4-8945-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260231>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Aside from making the logic clearer, this avoids a call to
> warn_dangling_symrefs(), which always does a for_each_rawref()
> iteration.

Makes sense.  Thanks.
