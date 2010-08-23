From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix for normalization of foreign idents
Date: Mon, 23 Aug 2010 16:46:55 -0700
Message-ID: <7vd3t8zyc0.fsf@alter.siamese.dyndns.org>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
 <20100823213531.GD2120@burratino> <yf97hjhrol5.fsf@chiyo.mc.pp.se>
 <20100823223321.GE1308@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Comstedt <marcus@mc.pp.se>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 01:47:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OngjY-0008UT-K2
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 01:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab0HWXrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 19:47:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab0HWXrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 19:47:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B862ACF70B;
	Mon, 23 Aug 2010 19:47:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+7a6mY7xEdGfSeJoINblK1qUx68=; b=Zj453f
	iEDUl+yetQ/quYi92nKJSvT3VbxC9OQbtuU5Y2Bna/X1knzesFLYJvj0o4hchROy
	rjsDVmhMOQExkEiGULGf+CTtnmrKUqy+Br+p74iQHxDXPqblsgfCVlBqcIAyZrEf
	xRXarFa0qFv3bLg1woP3BEC2q87onr73g+MVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mZaF1nL8OJq6apL1Lm0eA27w5392bDTp
	/bCnA2MoSnPWUuNkXyvO0PCqNZ1yhqg3QjNzv60/OSY+T35YTzBphT68US/MqVhL
	j8CAQxLn8mgTgAv8sH0KRHNhu3hMSsfZ2qmQiXQV/WjnOQuKz07CIxeImbyWRs+t
	Mi2VqLNUQSo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84C50CF70A;
	Mon, 23 Aug 2010 19:47:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9E8DCF705; Mon, 23 Aug
 2010 19:46:57 -0400 (EDT)
In-Reply-To: <20100823223321.GE1308@burratino> (Jonathan Nieder's message of
 "Mon\, 23 Aug 2010 17\:33\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9BC2A5A-AF10-11DF-B23B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154273>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Marcus Comstedt wrote:
>
>> it sounds like much more of a
>> hassle to actually use.  Do you have a use case in mind where you have
>> the ident attribute on a file but do _not_ want a new ident each time
>> you commit a change to the file?
>
> No, I don't use the $Id$ feature at all and if I inherited a codebase
> with a bunch of foreign $Id$ tags, I don't know what I'd do.

Heh, I know what I would do---the first commit will be to remove them.
