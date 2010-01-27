From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] work around an obnoxious bash "safety feature" on
 OpenBSD
Date: Tue, 26 Jan 2010 19:01:32 -0800
Message-ID: <7vhbq8w8s3.fsf@alter.siamese.dyndns.org>
References: <7veilcxudx.fsf@alter.siamese.dyndns.org>
 <20100127024148.GA18826@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 04:01:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZyA6-0000Ui-0K
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 04:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab0A0DBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 22:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064Ab0A0DBl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 22:01:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49268 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0A0DBk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 22:01:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6DC94C44;
	Tue, 26 Jan 2010 22:01:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DifngEERsdfiDzBvV9kZZ1O78Ng=; b=Yv0n4/
	JL4WXCdNuerY1oVki/NmclNiqeA0/AfVAGGNLz6wSVJ/XAaCwGAOL6b/t7eB1q8i
	WBWBW5IJFQMwat+cGWSDNoPW2zv8sKp9E5nuS9hz1EHcI1vuDPFo6WLAx4GyVlMi
	HV1X8WbBmFzJACg5gUmnBssxGJFUWvUnF7fp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BYCThfO1vxKIqm0eU4sjrJJsgzo7ST5N
	LN5KpSypx0UCcIEcvZ1FVV/LiYcIrwYBcn5RNTj8cSwAJYFJ+gxeapZogrbIixkO
	tQATWm9/HZh/7HxKBqPe/DLJ3WS+CCWIZqpK7iKcGOfRUlc2doJsU6UzoNYYuCNh
	sDf0g/T8LQ8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCF7294C43;
	Tue, 26 Jan 2010 22:01:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A71794C42; Tue, 26 Jan
 2010 22:01:33 -0500 (EST)
In-Reply-To: <20100127024148.GA18826@unpythonic.net> (Jeff Epler's message of
 "Tue\, 26 Jan 2010 20\:41\:48 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 48FE36BA-0AF0-11DF-A570-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138105>

Jeff Epler <jepler@unpythonic.net> writes:

> On Tue, Jan 26, 2010 at 04:29:30PM -0800, Junio C Hamano wrote:
>>  update_squash_messages () {
>> -	if test -f "$SQUASH_MSG"; then
>> +	if test -f "$SQUASH_MSG"
>> +	then
>
> I don't think this belongs here.
>
> Jeff

Yeah, it is a general improvement in the vicinity.
