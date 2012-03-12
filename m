From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] remove #!interpreter line from shell libraries
Date: Mon, 12 Mar 2012 12:50:15 -0700
Message-ID: <7vy5r5r43s.fsf@alter.siamese.dyndns.org>
References: <20120308121403.GA16493@burratino> <20120309075820.GA15985@ecki>
 <4F5E4618.10102@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:50:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7BGE-000506-5B
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 20:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808Ab2CLTuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 15:50:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756426Ab2CLTuS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 15:50:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72F0061B0;
	Mon, 12 Mar 2012 15:50:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SLgJV3XhhShSU+fugnrRG+zyqxU=; b=pSSzz+
	2+5rb9ukqzwWzVDsfqqsTb/xKR6rlNAdYFnt7Li0ZbQkfSIEYka7hzdqQ431P0DR
	BZzgeD/ks/4vxX3VSuCVO4y/5Uw9koH1zdf2Tm/qSGh617T//DLSU44EmEbuWORc
	jXQucyGozHchVbB9WtX8bL9D3fppggIRfBLgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h83SAt1j4RalkzHg7ED0CIAjG3t85haU
	OvQ5IMLhpVFUBb84Z3IRIobc4wdntjBnYxpeksFqHhBBTBv7+GfEh8O+vERsOjGO
	RUXJWTTIXbd2UukWW1L4tI+jWBpFjyX53jZ/W7aKmdj5KQzXYXJFsJ7NUQU373Vt
	DrAkrAumXjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6967D61AF;
	Mon, 12 Mar 2012 15:50:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E04C561AE; Mon, 12 Mar 2012
 15:50:16 -0400 (EDT)
In-Reply-To: <4F5E4618.10102@xiplink.com> (Marc Branchaud's message of "Mon,
 12 Mar 2012 14:53:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97626EC6-6C7C-11E1-8E80-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192933>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 12-03-09 02:58 AM, Clemens Buchacher wrote:
>> Hi Jonathan,
>> 
>> On Thu, Mar 08, 2012 at 06:14:04AM -0600, Jonathan Nieder wrote:
>>>
>>> --- a/git-mergetool--lib.sh
>>> +++ b/git-mergetool--lib.sh
>>> @@ -1,5 +1,4 @@
>>> -#!/bin/sh
>>> -# git-mergetool--lib is a library for common merge tool functions
>>> +# git-mergetool--lib is a shell library for common merge tool functions
>> 
>> This breaks vim's filetype detection. It can still guess the file type
>> from the .sh extension, but we strip the extension during the build.

Then that _is_ a feature to make it more obvious that the file is
not something you should be editing, no?

> How about a modeline ...
> (Now I'll wince and duck as people "calmly" discuss the merits of putting
> editor-specific modelines in the source code, and especially which editors
> deserve such treatment...)

Please, no "Local Variables:" or "# vim:".  Just don't impose
personal taste in editor settings to others.
