From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Tue, 12 Nov 2013 14:20:21 -0800
Message-ID: <xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>
	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 12 23:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgMJy-0004rS-Al
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 23:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863Ab3KLWU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 17:20:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613Ab3KLWUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 17:20:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62F752098;
	Tue, 12 Nov 2013 17:20:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fEGlfnW6YNaIX38NPSNeL+sNMO8=; b=cghAns
	caBkCciNEVHolEFQoXzoajqMcxpa+kBo1mFTCVCWfJwWEx0ttRRjjzl7NBe4Tozi
	mD+LRWUQEBfW8cbjiaxWHMWlkKGf9bjzNw5rzPXszFrjbZ16Z6bR6jTXUKykGj9y
	IHzznO738QbB33Kye3ZoE5Zoy4InD7vlE88AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PPg904Xwf4LWe/UOgaiPWsJ2nRBWLzxb
	N2C+zcXMYJopPyc3Skyk2eiEQYgMkrL09BZjQpfh37XXTheDhyK6SGzGyoRd7sF1
	4QuMHp5iReljH5KbsVTUCie6wUawkQP9euLCxgZvWvpld75nIFhzH/jwyVDwW/f9
	jZAUErYozrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A66D752097;
	Tue, 12 Nov 2013 17:20:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1040052096;
	Tue, 12 Nov 2013 17:20:23 -0500 (EST)
In-Reply-To: <5282A90A.4030900@web.de> (Jens Lehmann's message of "Tue, 12 Nov
	2013 23:17:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A00A2C38-4BE8-11E3-9259-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237762>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 12.11.2013 08:46, schrieb Johannes Sixt:
>> Am 11.11.2013 22:29, schrieb Jens Lehmann:
>>> The diff below fixes the problem you describe for me. (But I do not
>>> consider it a worthwhile fix in its current form because a line
>>> starting with "Submodule " might appear in a perfectly normal commit
>>> message, while "diff --git " most probably won't).
>> 
>> And on top of that, "Submodule " originates from a translatable string,
>> doesn't it?
>
> This would also be true for the marker line that Peff proposed:
>
>   # Everything below this line is a diff that will be removed.
>
> But I suspect that would be ok if the marker would be both added
> and searched for in its translated form. Or is it possible that
> the locale changes between those two steps?

If we were introducing a divider line for machine consumption, I do
not think it is wise to let that line even translated...
