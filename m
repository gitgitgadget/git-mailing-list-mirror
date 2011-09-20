From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2] git-web--browse: avoid the use of eval
Date: Tue, 20 Sep 2011 12:35:37 -0700
Message-ID: <7vvcsn57na.fsf@alter.siamese.dyndns.org>
References: <20110918183846.GA31176@sigill.intra.peff.net>
 <1316424415-11156-1-git-send-email-judge.packham@gmail.com>
 <20110919183408.GB26115@sigill.intra.peff.net> <4E78572E.6030105@gmail.com>
 <20110920184939.GA17322@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:35:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R666a-0004Dk-A4
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948Ab1ITTfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 15:35:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab1ITTfk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 15:35:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 006605C76;
	Tue, 20 Sep 2011 15:35:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j+OnXJ/ZSqDDBSdD601y5ttSMC0=; b=BKgixa
	LmUDcFNOc8UjQU0n3o8G49WcRidVI/cgbs85hDuVvke3mSb+0j3IoTHhxL24AYKn
	OrMmKSXLUrVON9B5/6ZgfBMlT0eYnvsCVixvwfGd8uRxVcE+eGBh/z5cLOtXaTpe
	i1xtxTClBVea0fqGoSav8h0JqmS44LTbwtd18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WHdiXfBeS3DlXhxKpQSJmudmKZOH28++
	aeAtVXnd2HgoVthoB/4XTROSja4r9kCZSAT5piQda1wJ5r1cd9nL9mXUSMdQ8Bu5
	WILPxNZW+CYyQm96FRPd5cBpS5ZJbmymDT0FxuiNo/lOfzKKSxzQziVMldjb+59T
	0avSbOuubuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EADA55C75;
	Tue, 20 Sep 2011 15:35:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E62D5C74; Tue, 20 Sep 2011
 15:35:38 -0400 (EDT)
In-Reply-To: <20110920184939.GA17322@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 20 Sep 2011 14:49:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7EF5794-E3BF-11E0-BCA1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181782>

Jeff King <peff@peff.net> writes:

>> The example in t/README has has a copyright notice which is why I put
>> one in but I don't consider the test (or the fix itself) to actually be
>> copyrightable. If I wasn't creating a new file I wouldn't have bothered
>> putting anything in (other than the testcase).
>
> Yeah, that's why I said I don't know if we have a policy. We clearly
> have a lot of copyright statements, but they are all horribly out of
> date. I was hoping Junio might weigh in.

To be honest, I do not care very much either way. From the licensing point
of view we know everything is covered by the top-level COPYING unless
otherwise noted explicitly in an individual file (which is not the case
for this patch anyway), and even without the copyright notice we can trace
where the files come from with "git log", so these three lines in a small
test file are essentially noise, not very useful but are not irritating
enough to warrant an effort from me to amend it out.

I do have a mild objection to a patch that adds a new copyright notice
line to an existing file when it adds only a few new lines, though. When
the code is refactored and these new lines are made unneeded, it is likely
that nobody would bother removing that copyright notice line that names
the author of the patch that added these lines.
