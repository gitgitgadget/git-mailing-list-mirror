From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to git checkout a orgin(unstage) version file in another
 directoy?
Date: Thu, 17 Feb 2011 10:33:24 -0800
Message-ID: <7vpqqqcxzf.fsf@alter.siamese.dyndns.org>
References: <loom.20110217T074533-358@post.gmane.org>
 <4D5CDBAD.4050700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chunlin Zhang <zhangchunlin@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 19:33:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq8fd-00069Y-L7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 19:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab1BQSdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 13:33:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab1BQSdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 13:33:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B376237A6;
	Thu, 17 Feb 2011 13:34:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XKil2JqQyzxCf14ru3g3YKizi9c=; b=kK3acA
	rxxtfDw2QwQvpPfbEESXcepn5fZe8Yk2FByZjFL3j7w7EXX0cUDWy3F92WRu+YsN
	og1sLaoQrccjouvESnIpj4obG3Mdj3g4ogldRE7vIJhWBjsIBG+SBxacBgY6bb2y
	UqY6f3ofEzrPPoznC9VBn9QKfLb1eCLkbUHVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWAZF1knbd6pglqvbOiOpvqLl8ljR2xz
	uMpWzEJmFS1pg+wFdQiV6dgL6Ds+mcS+gteoxAXuie2i1u+yF/7eSeiTFnsZ9z4Y
	hDj3yExFuw7veryebsxcqKkXL8R2AX6wnhW1oYLBNFS3B71LJNBcPVn1RC/Uz9WQ
	wqykzWFlJak=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 821B737A5;
	Thu, 17 Feb 2011 13:34:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6FE1437A4; Thu, 17 Feb 2011
 13:34:33 -0500 (EST)
In-Reply-To: <4D5CDBAD.4050700@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu\, 17 Feb 2011 09\:26\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 92F98C1A-3AC4-11E0-AA61-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167099>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I'm not sure what you mean by "origin" version, but if you mean the
> version from the current revision (before making and staging changes),
> you would check out from HEAD instead of from the index:
>
> git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout HEAD
> -- README

Wouldn't that still affect the index in /media/linux/t/kernel/.git/index,
making /media/linux/t/kernel/README and the index entry out-of-sync?
