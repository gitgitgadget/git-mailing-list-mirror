From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -g bizarre behaviour
Date: Tue, 02 Feb 2016 11:32:53 -0800
Message-ID: <xmqqsi1asyai.fsf@gitster.mtv.corp.google.com>
References: <1454241144.2822.7.camel@kaarsemaker.net>
	<xmqqegcwt32j.fsf@gitster.mtv.corp.google.com>
	<1454401738.32711.7.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 20:33:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQghA-00048w-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 20:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbcBBTc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 14:32:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754752AbcBBTcz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 14:32:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 329D13FBD4;
	Tue,  2 Feb 2016 14:32:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBhSHssLJXy7acONM03IGtucYWs=; b=GFLlnl
	2TOd+Jvuj5cWKpLynioH/mAQ/aB482OMu3JgGB9oWsw2F9dPAH86Cf2OmunKlRh5
	gHHcdNewZuQ22bCkUlcb4E2fa3QHdaWQAQ9pxYdUtKzwoVTVqYRtvkUxMytVyKbB
	Pn7l0ziakgbXXXjMp1NtnWDZ/sypd1VBBrU8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aUVXS+lZcuKXMM3cQ4ZTkHAA3JeWgci/
	uvW2NoSi+9rC6A9NxgojKwz8WyOjwjSIAfrV45nYxEnG5wcZQq53DAqRy0/UrWHr
	RWrQHGLQQbyIcfL4rbgCIGuh46BUwhiFjXeNcMs5p1j9VvYFghdPrcTgRTd4otrU
	dko/cJ2uckg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A95C3FBD3;
	Tue,  2 Feb 2016 14:32:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A13003FBD1;
	Tue,  2 Feb 2016 14:32:54 -0500 (EST)
In-Reply-To: <1454401738.32711.7.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Tue, 02 Feb 2016 09:28:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C18DF4C2-C9E3-11E5-9CC5-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285300>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On ma, 2016-02-01 at 15:37 -0800, Junio C Hamano wrote:
>
>> Do you mean
>> 
>> 	$ git checkout -b testing
>>         $ rm -f .git/logs/refs/heads/testing
>>         $ git log -g testing
>> 
>> will be changed from a silent no-op to an abort with error?
>> 
>> I do not see a need for such a change--does that count as an
>> objection?
>
> No, I'd like to change:
>
> $ ls .git/logs/refs/tags/v2.7.0
> ls: cannot access .git/logs/refs/tags/v2.7.0: No such file or directory
> $ git (log -g|reflog) v2.7.0
> From the bizarre behaviour above to a silent noop.

When there is nothing to show, we do not show anything, and that is
just like "git log v2.7.0..v2.7.0" is silent.

I do not find the silence bizarre at all.
