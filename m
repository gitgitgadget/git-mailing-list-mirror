From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] commit.c: use skip_prefix() instead of starts_with()
Date: Tue, 04 Mar 2014 14:11:15 -0800
Message-ID: <xmqqvbvtiph8.fsf@gitster.dls.corp.google.com>
References: <1393967190-3181-1-git-send-email-tanayabh@gmail.com>
	<xmqqzjl5iro0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, max@quendi.de
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:11:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKxYd-0003Yb-0e
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 23:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771AbaCDWLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 17:11:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756713AbaCDWLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 17:11:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3689714F1;
	Tue,  4 Mar 2014 17:11:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vhA59BFNcedPpZcEe/6JBMT1Oh0=; b=FMSNH0
	wPTA9SAMNzR4EeBcoFwfr/6b3ffw6kUEyDzJNPVBfkc3A/uwvtTSNJ4L16WKt9MJ
	HLUJHq2ZAzeEUwWtet7vqiDeuAHLayP4NC7GgdPV9ajL1lCD3EpVbk/b3QLg5Cix
	dE0d8SE373ZSlctK0zf2rFvjBPFiWOJcVOkQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gbkeLuuOHw1cWyNb6YXxcZZYQhzw9zeK
	P9qcWcIRuz3Ff+22qcIhGNe3Ap1QW8PF4Czmxzzu3kUOvxTleaNK30ln93Yp5TMl
	jvxF9GJIDYasPj4qX65TW4EarxrpHPNNHrbAnkD6Wio2Rx4vZ2D6iAQ5NcjUZ/to
	7WCLIZvmUmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF039714F0;
	Tue,  4 Mar 2014 17:11:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34D64714EE;
	Tue,  4 Mar 2014 17:11:18 -0500 (EST)
In-Reply-To: <xmqqzjl5iro0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Mar 2014 13:23:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E8F4053C-A3E9-11E3-A292-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243396>

Junio C Hamano <gitster@pobox.com> writes:

>> +		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
>> +		if(!found) {

Missing SP between the control keyword and parenthesized expression
the keyword uses.

I've fixed this (and the broken indentation) locally and queued the
result to 'pu', so no need to resend to correct this one.

Thanks.
