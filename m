From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug with git status in 1.7.0
Date: Wed, 17 Feb 2010 11:21:36 -0800
Message-ID: <7vvddvoegv.fsf@alter.siamese.dyndns.org>
References: <loom.20100217T184109-183@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:21:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpT4-0002Dq-FQ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab0BQTVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:21:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab0BQTVo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:21:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE999ACDA;
	Wed, 17 Feb 2010 14:21:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tVk62r2MmusxJbcqj3MklIh2ooc=; b=aYdTvH
	HkU9rXWxpW7PGEUZdDGU+TGVxv0fpzxWOSFs9qtDcA/VwGbhb8fwtcPQrMorlvni
	he9OtQKjrX3F989l/WRT+wGmMQTgbTkLj/Ag2ZE/MSpiwPNg29l2JCDxJOdMd1Rb
	4pXW4dOXmfBCzZYXQ73U9bPv/8BYUsbUKdHPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NAuIHEvb0dmApCB/2bkGrnCfoFxvcINb
	wupa4nCyflfqfOcH+ylp2fXi+ip/p/ice85BLiPbT7kxU8HUK3lmkyb5WcUtiw4m
	zRqtp3hWx2zsFPIzawTRQVI6UPngOfkZRK3AN4SXxG2H3CYQT13eXBiEwz/IAo9J
	l3AvXKN8mXo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 191BA9ACD9;
	Wed, 17 Feb 2010 14:21:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E63A9ACD1; Wed, 17 Feb
 2010 14:21:37 -0500 (EST)
In-Reply-To: <loom.20100217T184109-183@post.gmane.org> (Sergio's message of
 "Wed\, 17 Feb 2010 19\:14\:28 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC965724-1BF9-11DF-8036-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140255>

Sergio <sergio.callegari@gmail.com> writes:

> if you have a submodule and the submodule contains
> untracked files, "git status" in 1.7.0 keeps showing
> the module as modified.
>
> But of of course it is useless to "git add" the module
> or to try to "git  commit -a", since the index entry is ok

Of course it is useless to "git add" in the superproject, and this is
an intended bugfix.

You are getting reminded that you either forgot to "git add" that file in
the submodule, or you forgot to add that file to .gitignore in the
submodule.
