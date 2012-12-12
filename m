From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Wed, 12 Dec 2012 11:44:13 -0800
Message-ID: <7vehiv3vjm.fsf@alter.siamese.dyndns.org>
References: <50C22B15.1030607@xiplink.com>
 <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com>
 <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com>
 <7vsj7hfw6q.fsf@alter.siamese.dyndns.org> <50C25539.9010206@xiplink.com>
 <7vobi5fu3c.fsf@alter.siamese.dyndns.org> <50C4FD00.4010003@gmail.com>
 <CABURp0oc_g3T3n0A4on=n8443sTFR6SKf1xcgN2EAFcx9eU_Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:44:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TisEM-0007k0-Sd
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab2LLToR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:44:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab2LLToQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:44:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B075AF6D;
	Wed, 12 Dec 2012 14:44:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+MSGi58JazgSDOHP+jcaimDZW3Q=; b=J6wanZ
	WJ8z3KU0XcCKU5Pv8R2PygRLnkadeL3dtBjXjj/Md/PounxBcMihN2h74wnUJXeh
	AqRNoUh3wBnROO5H08K20koEXwy+WYCOja1Wkh88hEqMjEBWXhVCXnmofdRkIaWk
	/payN96hTF0ue+wJe+wQv9LPtPtmfb3BXuBhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AG3r3OSyEcQ42uZ9aZNQFZ4XQfrt7Yii
	3PdJsSK0a7oTBmcVmQlUntVyux35oQQmApJ/1yb+a25OsRhRgM/KYyPln52Z4zpw
	iQopvXuzOQQ3wAIRrecTOuols+MUSAvmA3BeZEW/WpntDWf+fdydgTzyr+i9O0/Y
	VJtsx+65Whc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB7B4AF6C;
	Wed, 12 Dec 2012 14:44:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A89EAF6A; Wed, 12 Dec 2012
 14:44:15 -0500 (EST)
In-Reply-To: <CABURp0oc_g3T3n0A4on=n8443sTFR6SKf1xcgN2EAFcx9eU_Ng@mail.gmail.com> (Phil
 Hord's message of "Wed, 12 Dec 2012 14:10:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F84234C-4494-11E2-A77B-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211388>

Phil Hord <phil.hord@gmail.com> writes:

> Marc Branchaud <marcnarc@xiplink.com> writes:
>> It's FreeBSD 7.2, which I know is an obsolete version but I'm not able to
>> upgrade the machine.  I believe FreeBSD's sh is, or is derived from, dash.
>
> Dash has been the default '/bin/sh' for Ubuntu for quite a long time
> now[1] in spite of repeated reports of compatibility problems[2].

Wasn't the ancestry more like BSD ash (buggy) came before dash and
Marc is running a BSD ash decendant that shared common ancestor
with, not a decendant of, dash?

In any case, I do not think that is relevant; does does not seem to
have this IFS bug.

> [2] https://bugs.launchpad.net/ubuntu/+source/dash/+bug/141481

None of the ones listed seems to me a bug.  Rather, I see it as a
sign that the reporter does not know POSIX shell well and only
learned his/her shell through bash.
