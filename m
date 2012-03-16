From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on
 objects from new pack
Date: Thu, 15 Mar 2012 20:42:02 -0700
Message-ID: <7v4ntpi54l.fsf@alter.siamese.dyndns.org>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
 <1331736055-21019-1-git-send-email-pclouds@gmail.com>
 <7vy5r1inax.fsf@alter.siamese.dyndns.org>
 <7vsjh9il3l.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5UNd5b=Dpt75Qrc96u6wRLffB7eGSsKqM3qQ37p4cOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 04:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8O43-0003uy-8Y
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 04:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031404Ab2CPDmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 23:42:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031385Ab2CPDmF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 23:42:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E09D87D57;
	Thu, 15 Mar 2012 23:42:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4QCk0JT6ZXmxb13fMyoFoTg/YlM=; b=A7AbzI
	cjbA+aad+Vdb7wHBALoldGBmAOkmbk7rktxdBb87N3r73yeokqYWmXF/UNTfgwrl
	Xr1+InlW8o5pw47R4+QwhX2BkhaDG3N5ubO0VlP5abYeOXm72Qxw0lorrbAOyaLL
	euK0I8nXSVMSqiwH/dw6e4fwZ8hnKABbMq6rA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpDY6Uk/qtdYSmQyaiwqLmwav15wIgzQ
	dSwRMNBaKV1XzwQ04AY07WI+HrQXfOH3Ei9N5+8InP0Pkc939FiAd9715nN9WTqw
	mKswlVC2dE8zvlEUP1JydXImvJKTnQVVwFQPIzvKYBXCHNZiqsox8Z5dQsLQB/m2
	B0BkaBwFD+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E047D56;
	Thu, 15 Mar 2012 23:42:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70FA57D55; Thu, 15 Mar 2012
 23:42:04 -0400 (EDT)
In-Reply-To: <CACsJy8D5UNd5b=Dpt75Qrc96u6wRLffB7eGSsKqM3qQ37p4cOw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 16 Mar 2012 09:28:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF3ADA70-6F19-11E1-966B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193240>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> What about push/receive-pack? I think the same thing happens there.

As the patch goes to check_everything_connected(), it is automatically
covered, no?
