From: Junio C Hamano <gitster@pobox.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 09:40:17 -0800
Message-ID: <7vr5cj49vi.fsf@alter.siamese.dyndns.org>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com> <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com> <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <7vmxnc48yt.fsf@alter.siamese.dyndns.org>
 <20110111053653.GB10094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 18:40:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PciD3-0000yq-1K
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 18:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab1AKRkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 12:40:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1AKRkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 12:40:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5ABED3533;
	Tue, 11 Jan 2011 12:41:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e4r5/9ZsU0K2YMJ0pTwYvF8ntTs=; b=HBYgQh
	G9bvsDBkxpHwoMkuZCN4qd/npyJoDbKobLZVy7gHomcv2VW/U2H5kIpWqXtifzoi
	wfnS193jvchcqIoi9HnNCZf2oMpZiOYFqSa+tEC+i4Pri+kA/VrU6vIyN4FluFTX
	TLAF5iqLgeTqB/IErxsVfk1GccFywDb/jC58U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TsyIqg+O6x7G1fbioWflRqPeu1nh0Yhh
	3n8nLvQMNLqIHt5aa/kxa1MAbdTjncQb02ejATGn+06fWk6P0e9fKQEqA1GMjS+l
	JfSIocPESxpWrsSAq4aEWDNGEbnddyQ+C++jRjucf99clJ5P8YE8jWY5dyiX9glI
	G3Mk6jyoY58=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9EA6352F;
	Tue, 11 Jan 2011 12:41:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36778352C; Tue, 11 Jan 2011
 12:41:01 -0500 (EST)
In-Reply-To: <20110111053653.GB10094@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 11 Jan 2011 00\:36\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F93B1C56-1DA9-11E0-BAE7-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164959>

Jeff King <peff@peff.net> writes:

> Sure, I think that is a sane way for the user to think about it, but do
> we actually support multiple views? I thought replacement objects were
> all or nothing.

It is not implausible for a long running large project to restart their
history from a physical root commit every year, stiching the year-long
segments together at their ends with replacements, to make a default clone
to get a year's worth of the most recent history while allowing people to
get more by asking, no?

Of course, if you trust shallow-clones, you do not have to do that kind of
history surgery ;-).
