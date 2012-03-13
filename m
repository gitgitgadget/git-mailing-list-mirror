From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Tue, 13 Mar 2012 11:22:10 -0700
Message-ID: <7vipi8wect.fsf@alter.siamese.dyndns.org>
References: <20120312152453.GB12405@1wt.eu>
 <87aa3l4vqq.fsf@thomas.inf.ethz.ch> <20120312165703.GB18791@burratino>
 <7vvcm9snko.fsf@alter.siamese.dyndns.org> <87399dpk48.fsf@thomas.inf.ethz.ch>
 <20120312215607.GB11362@burratino> <874ntto4t8.fsf@thomas.inf.ethz.ch>
 <20120312222227.GC11362@burratino> <87fwdcldqj.fsf@thomas.inf.ethz.ch>
 <7v62e8la9y.fsf@alter.siamese.dyndns.org> <20120313175158.GA6653@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Willy Tarreau <w@1wt.eu>,
	Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 13 19:22:24 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7WMa-00031n-C1
	for glk-linux-kernel-3@plane.gmane.org; Tue, 13 Mar 2012 19:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759403Ab2CMSWO (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 13 Mar 2012 14:22:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758733Ab2CMSWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Mar 2012 14:22:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 587E76815;
	Tue, 13 Mar 2012 14:22:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R95JUFIASNNxjPHxglW7fEt9rAQ=; b=oNADcx
	6rXRV7pFh+B506pi5o/9aE9PzcjG1pqHR0jQFexZdsocA4Y7yLJ3G52ZAxHDDHoN
	qI4W1ZWMNmTgKP0UTYCeuneYHB+c7txE5cP/yoHsndGPD+X+a32lWWOvVLHuk/RX
	ugHk4kc1Z40x0hjWLXJkKB8Rny2uq65A28L1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dCPwn+DNsD2oL/sORcJ0ED4VGuVhEeXc
	pwEDd/QiR/cQKCtSMFZxRi2vIlWHaq+4+0wLRTAchqffA6Pc1HlRfeKkLwdI4RkQ
	VmbcgP/E2GE8uy21EwP8kuVxsNwL0XjB5mF0Ca+igR7iccynY8cEkrVaDi9+hET5
	Um/ftjugYqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F0C96814;
	Tue, 13 Mar 2012 14:22:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D28F66813; Tue, 13 Mar 2012
 14:22:11 -0400 (EDT)
In-Reply-To: <20120313175158.GA6653@burratino> (Jonathan Nieder's message of
 "Tue, 13 Mar 2012 12:51:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73AB9580-6D39-11E1-8F14-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193052>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I really don't think it is a good idea to avoid mentioning 1.6.0, at
>> which we *removed* description of the option in our manual pages and
>> from the "git am -h" help message. How much more active deprecation
>> would a user want?
>
> A warning when the option is used or a mention in the release notes.

Ok, then we should probably instead do these two starting at 1.7.10 ("the
official deprecation date"), and then start erroring out on "-b" three
cycles after that.
