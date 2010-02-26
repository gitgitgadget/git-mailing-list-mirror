From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Having keywords without value is not a global error.
Date: Thu, 25 Feb 2010 21:57:15 -0800
Message-ID: <7vljegczes.fsf@alter.siamese.dyndns.org>
References: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz>
 <7vk4u0efxy.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1002261838360.8597@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Fri Feb 26 06:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NktCd-0005zv-T0
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 06:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab0BZF51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 00:57:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab0BZF50 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 00:57:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2595C9D022;
	Fri, 26 Feb 2010 00:57:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TTR8zk4iaWkZ+jtsp3/0OmFbHlQ=; b=c8w73f
	d82ncRgKfV4b8IsNG4qp7xqXBDZy+dnnakGnSiEo1cpvuLyFNgDduVGdSS4bR8fg
	qhPbWa3CNwTl0GD00uyrbq+3P8OvCiBbY8Vzk9T2I4b4urvDrwvev5spGFDVpzd1
	a7L90SKVTMQ/AZlsIekrFINXguKd9ZnPZPpR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qxbIEZk3FUq/zIm5F+UvH/i5hqpMXJYH
	5lk0Yg8UtZzxezEt00X6lZP7nq9rs7MdxbrAN7VJmfEs8k3oUIgH5F5yUKGIyGBl
	pf3PuNY+gmbp2QvibrbhdkaXFzHSIIAqA2p9mAltkOlIEdpjnADBCj0ZvOd3YpVr
	VOgp2wO9yJM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 045BF9D021;
	Fri, 26 Feb 2010 00:57:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FAB89D020; Fri, 26 Feb
 2010 00:57:17 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1002261838360.8597@vqena.qenxr.bet.am> (Steven
 Drake's message of "Fri\, 26 Feb 2010 18\:44\:31 +1300 \(NZDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE3E8222-229B-11DF-B047-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141109>

Steven Drake <sdrake@xnet.co.nz> writes:

>> >  	if (!strcmp(k, "init.templatedir"))
>> >  		return git_config_pathname(&init_db_template_dir, k, v);
>> 
>> But then don't you need to catch init.templatedir does have a string
>> value?
>
> Yes, but the change dose not touch that test,...

Ahh, config_pathname() does its own check for NULLness, Ok, I forgot.

Thanks.
