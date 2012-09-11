From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clear_child_for_cleanup must correctly manage
 children_to_clean
Date: Tue, 11 Sep 2012 10:32:11 -0700
Message-ID: <7vpq5sh3dw.fsf@alter.siamese.dyndns.org>
References: <1347373967-29248-1-git-send-email-david@optimisefitness.com>
 <20120911152041.GA11994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Gould <david@optimisefitness.com>, git@vger.kernel.org,
	kusmabite@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 19:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBUJz-0001D4-1K
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 19:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab2IKRcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 13:32:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805Ab2IKRcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 13:32:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6238889;
	Tue, 11 Sep 2012 13:32:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+c7kDW/yUu2O7FYqncb2aYbyM+g=; b=itoOrN
	2PkEgn4kUWQsM6sRQXEljgYYdVtZeIFQXf5gZ1ZhO95jLbYYUYZ1geA88TIXb4j7
	9XsLKFelhiDddvAtQJrRKXZo1ZqKigqtcOdoG8AbjutGLchkLfvYWRoVdyk9hALa
	tPumecvPQ+cJLDB6Mz3eS7CVCnPAfIzofxtZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kmPdMtUIYbgMzcY51KlTG1xcnfRMPTew
	BbjNXwZtByqNrMY8uINyPcnGBhEYcig188WYhRqVdHT2wKBLUf6P/aS86BY4sE1B
	+wx0q43Ir/8fbPQd5ZcGvVARExANzsjDTqhVrN1x1mxK1Qrbxnx902WcbqpDwVBr
	3P7MTjnEHTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA01C8888;
	Tue, 11 Sep 2012 13:32:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4549C8887; Tue, 11 Sep 2012
 13:32:13 -0400 (EDT)
In-Reply-To: <20120911152041.GA11994@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 11 Sep 2012 11:20:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F8AA416-FC36-11E1-B90E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205255>

Jeff King <peff@peff.net> writes:

> Thanks for the patch. Overall it looks good, but let me nit-pick your
> commit message a little (not because it is that horrible, but because
> you are so close to perfect that I want to fix the minor things and then
> encourage you to submit more patches :) ).
> ...
>
> Acked-by: Jeff King <peff@peff.net>

Thanks, both.  I'd have to ask for a Sign-off, though.
