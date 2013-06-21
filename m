From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [submodule] Remove duplicate call to set_rev_name
Date: Fri, 21 Jun 2013 10:03:44 -0700
Message-ID: <7vy5a3mm4v.fsf@alter.siamese.dyndns.org>
References: <1371462936-9672-1-git-send-email-iveqy@iveqy.com>
	<20130620215812.GA2687@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 19:03:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4kc-0004bN-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 19:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423444Ab3FURDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 13:03:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423399Ab3FURDt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 13:03:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CB5429A4E;
	Fri, 21 Jun 2013 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lDiBLvB8zYjiRo3aOlp3OeBMy8M=; b=HbQyU/
	6ySd0tGM5hNV8KJJwuTLl5jdbU6MiBfeBdqeLZHVnZwyK8t2pUgn3/5Of4SfZC2+
	EdQ12VyulxiaQ/hNYlTq3QTBVUfhpRiuIsPk0cwT+SkRddseTZKC1OCjiPnGVwOx
	hGJWCLCdniQGTe/0sSGAWnsplYqZeyI6gnMP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JU7qkv70HrPhFvjOQPO61hOwLj0Qtp7X
	XyDOPJFTiSl39oJSXcO9zGlR+Q558jW4rB6w2mEOMP2VwnSC5lR2Lb88ls//W1FQ
	dnuQdFQpL/8V8SsYOLLVehe7wodE0Q2U+8VBQV4Fnrg1HpmhgTUJYbqF5b+cbgnw
	ywdyJwgDP7I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DBD229A4C;
	Fri, 21 Jun 2013 17:03:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECB0E29A45;
	Fri, 21 Jun 2013 17:03:45 +0000 (UTC)
In-Reply-To: <20130620215812.GA2687@sandbox-ub> (Heiko Voigt's message of
	"Thu, 20 Jun 2013 23:58:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88E8FD7E-DA94-11E2-BED2-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228632>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Hi,
>
> On Mon, Jun 17, 2013 at 11:55:36AM +0200, Fredrik Gustafsson wrote:
>> set_rev_name is a possible expensive operation. If a submodule has
>> changes in it, set_rev_name was called twice.
>> 
>> Solution is to move set_rev_name so it's only called once, no matter the
>> codepath taken.
>
> Looks good to me.

Thanks.
