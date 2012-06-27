From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fast-import: allow "merge $null_sha1" command
Date: Wed, 27 Jun 2012 15:30:55 -0700
Message-ID: <7v395g75gg.fsf@alter.siamese.dyndns.org>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
 <1340818825-13754-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 00:31:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk0lM-0008PV-Ee
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 00:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386Ab2F0Wa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 18:30:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709Ab2F0Wa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 18:30:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 468218FF7;
	Wed, 27 Jun 2012 18:30:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8jqr57JE8gQqzCA4wwPh34lBwQk=; b=xbtsm8
	7ZJVoB/SX4Y1LtrlqTLBsV0EC2Elp8+8RzaFhgPHO6MjRezWfwmjBTr6Q68QN0v6
	EfEeMrBuwV0w30GLYvGfixMaEiNwU59Jlqy7ykBAUnPtHxFMZVxiqk/TSciRV++A
	bPbPQol92Pf8YvZzaqQlwvM0DZ7+c1/vm3hYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dB2G78wdJtZgR4ilnb/WxiX5O6rcy4gA
	Hpec2flIDWN6CpXA2iw7h2LEZzO4uv44JlX3Yt/3jhCM7zGAC9uh+uvVYTlZNjCg
	qzkBmPosUuUKJy5f6joNKsPPWlE+nMc1BL3yX6r5EtwROkj/fY/ZMPhg9ghKZpeu
	mG+OpgGkKeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3898FF6;
	Wed, 27 Jun 2012 18:30:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBE898FF4; Wed, 27 Jun 2012
 18:30:57 -0400 (EDT)
In-Reply-To: <1340818825-13754-3-git-send-email-divanorama@gmail.com> (Dmitry
 Ivankov's message of "Wed, 27 Jun 2012 23:40:24 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C403C8EC-C0A7-11E1-A514-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200768>

Dmitry Ivankov <divanorama@gmail.com> writes:

> "from $null_sha1" and "merge $empty_branch" are already allowed so
> allow "merge $null_sha1" command too.

Would accepting such a "merge oops-do-not-do-anything" allow
exporters' job to be simpler?

Without a convincing "it makes sense to treat this nonsense request
as a no-op" argument, I fail to see why this is a change in the
right direction.  If there are two other nonsense request that
silently become no-op, shouldn't they be diagnosed as bugs in the
input stream, or do these two have valid uses?

Very confused.
