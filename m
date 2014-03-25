From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/12] t: drop useless sane_unset GIT_* calls
Date: Mon, 24 Mar 2014 21:56:55 -0700
Message-ID: <7v8uryq3jc.fsf@alter.siamese.dyndns.org>
References: <20140320231159.GA7774@sigill.intra.peff.net>
	<20140320231433.GC8479@sigill.intra.peff.net>
	<xmqqy503s0s0.fsf@gitster.dls.corp.google.com>
	<20140324215638.GH13728@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 05:55:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSJOq-00071m-96
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 05:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbaCYEzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 00:55:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbaCYEzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 00:55:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6195B67773;
	Tue, 25 Mar 2014 00:55:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CiNdHNDgzWDJ53GZ8Q4d18frcgU=; b=xxbl5+
	cicT5R/XRSxvPYsL0zV3gSgq/NHSAYABs8+Z8UlpeiZiCzFWbr9v5h7eQ8xBTqYZ
	haK2NAJUAEAiBfgUisInwtVQFocfLsOo6aJGthzKESozJIdAX88tVnd9jBKaJwyk
	jKjueKBzaLsS8QmrIfZ/gegTOq3DJVGEJvtRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ai5TULKIYQI9CFVMHKhlM63JZ2r9g8Lt
	beaIcJ7LDyvrm/EBUuVP6gHQPMntdvq0ix1khuiZK3erDz0LUbZMaUAWlRTYJiMv
	ONuna1wXo4DQpgPMttsTQUQsAoA07uA9xyzjhmj4247SAI9kMPb5FyxviTGyJ5dh
	v7vgV5Km8+w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C02F67772;
	Tue, 25 Mar 2014 00:55:39 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 938C467770;
	Tue, 25 Mar 2014 00:55:38 -0400 (EDT)
In-Reply-To: <20140324215638.GH13728@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Mar 2014 17:56:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: B5883ED4-B3D9-11E3-9937-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244902>

Jeff King <peff@peff.net> writes:

>> Hmph.  I am looking at "git show HEAD^:t/t0001-init.sh" after
>> applying this patch, and it does look consistently done with
>> GIT_CONFIG and GIT_DIR (I am not sure about GIT_WORK_TREE but from a
>> cursory read it is done consistently for tests on non-bare
>> repositories).
>
> I don't understand why we stop bothering with the unsets starting with
> "init with --template". Are those variables not important to the outcome
> of that and later tests, or did the author simply not bother because
> they are noops?

If I had to guess (without running "blame", so it may well turn out
that "the author" may turn out to be me ;-), it is simply the author
not being careful.
