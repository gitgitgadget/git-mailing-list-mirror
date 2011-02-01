From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Tue, 01 Feb 2011 14:09:19 -0800
Message-ID: <7vwrljxv8w.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201101312244.10047.trast@student.ethz.ch>
 <AANLkTi=Y9PBs_jXyCiAL9YLA8Y_jzWwqxw63hKm7fVBO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 23:09:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkOPr-00035e-14
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 23:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab1BAWJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 17:09:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1BAWJa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 17:09:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D63A84AFB;
	Tue,  1 Feb 2011 17:10:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o78IiP9Uwyj/2545Yt2A76Q1OpI=; b=u1hPfn
	UFKbMIVGW/oPPcM6REzcCBGup4Ji3zG3ISgpLEVolfOGMCG9xTymrzi1nI2ORmDr
	sICktmad/XqfIa0msPRCI50gzBYNEc0fwMX0+JRZUOU5M7KvqVNCUup5vy//sU46
	IuObFhZCSs/43EWFOAPeVYwwcL0KbfkVn/eMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=raCEZKRVfFbkziak2Pzj9vLA9oXZQQ0j
	9k7QD7ixagSMtuZFG3+e9KuY7i+xPjSBmDSOQ2DuKCcF28LzSpWurq2zMMazvLHq
	HjUeLtM3ECHLXrfJZfF3fvjm5uLUgI0HTK/UKoTCMIhghctc26naw7KEiPYRpTc1
	gsXfx5eA28s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A658F4AFA;
	Tue,  1 Feb 2011 17:10:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9C3D24AF4; Tue,  1 Feb 2011
 17:10:13 -0500 (EST)
In-Reply-To: <AANLkTi=Y9PBs_jXyCiAL9YLA8Y_jzWwqxw63hKm7fVBO@mail.gmail.com>
 (Jay Soffian's message of "Tue\, 1 Feb 2011 02\:04\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D4B7798-2E50-11E0-989B-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165867>

Jay Soffian <jaysoffian@gmail.com> writes:

> Would it make sense to group the pre-1.8 compatibility switches
> together in some way, if there will be several of them? Maybe
>
> [compat]
>    fetchUpdateRemoteNamespace = false
>    ...

I don't think so.

If these configuration variables are expected to be removed in some
future, such a layout might make sense, but what is proposed is to default
them to a different behaviour from today at 1.8.0 boundary, and we are not
going to remove the ability to invoke the current behaviour with these
variables.  It would make it a lot easier to find and understand if the
variables are grouped by functionality like all the other regular
variables, as these new ones are after all regular ones.

Just thinking aloud, too.
