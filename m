From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Wed, 13 Oct 2010 09:51:10 -0700
Message-ID: <7vbp6yniip.fsf@alter.siamese.dyndns.org>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org>
 <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com>
 <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org>
 <20101013024034.GA26483@burratino>
 <91EEA44C-E519-4375-BD9E-68D5C3D7C4EE@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 18:51:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P64Y6-0007Zz-V3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 18:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab0JMQvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 12:51:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0JMQvY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 12:51:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CFDCDEFDD;
	Wed, 13 Oct 2010 12:51:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lMu+YBBABTaB1hAPH0rJi8Dxawc=; b=dWYgma
	GAxL656AOGLJmLGvOeoOfmbiVPRMlLBEHCwtOh9iCmKnDcrMu8+TIvo0abRU7ZS9
	ckOnJfNBWv4YAStYhFtOprIfs3vvZYky91cAGV7VBqkJPc8soT6M5MpbnrnPVYGf
	IsEFw8ovov2WTZzzob99Uee6I/k7C8OCzk9r4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ac6iiUuySs1iLjFUk5EfaCRzw//ife1P
	OUDv1MoU5K79qg9pWi82f+V1A1d/RBz0zqeD1+VTygj8ZHJJaer8Le6+3vsarA9i
	jmW+PZKjN5EPghaqcC2k2oqepOONcJWxV2GXG/l/na3F8Lh05dyBKuqNO/R7DLcx
	SjZwU5jbdF8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4197CDEFDC;
	Wed, 13 Oct 2010 12:51:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58E9FDEFDB; Wed, 13 Oct
 2010 12:51:12 -0400 (EDT)
In-Reply-To: <91EEA44C-E519-4375-BD9E-68D5C3D7C4EE@sb.org> (Kevin Ballard's
 message of "Tue\, 12 Oct 2010 20\:05\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18DD2DF8-D6EA-11DF-A1F3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158943>

Kevin Ballard <kevin@sb.org> writes:

> Another possibility is using this new behavior for core.excludesfile and
> possibly .git/info/exclude, but not for patterns in .gitignore
> files.

I suspect that that approach is totally unacceptable.  These out-of-tree
exclude pattern files do not have any semantic difference from the in-tree
exclude pattern files (.gitignore); it makes no sense to make them
syntactically different.

More importantly it is much harder to diagnose if you break people's
private configuration without introducing the same breakage to what's
available to wider public guinea pigs.
