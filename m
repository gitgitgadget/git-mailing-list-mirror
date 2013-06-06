From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rev-list: add --authorship-order alternative ordering
Date: Thu, 06 Jun 2013 12:29:08 -0700
Message-ID: <7vtxlbxcl7.fsf@alter.siamese.dyndns.org>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<1370369299-20744-2-git-send-email-me@ell.io>
	<7vip1t7koi.fsf@alter.siamese.dyndns.org>
	<7vobbl60aj.fsf@alter.siamese.dyndns.org>
	<CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Elliott Cable <me@ell.io>
X-From: git-owner@vger.kernel.org Thu Jun 06 21:29:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfsE-0004N4-8t
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab3FFT3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 15:29:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272Ab3FFT3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:29:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70AE926ECD;
	Thu,  6 Jun 2013 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7cK9NdCNNMvdBl14uO9bhicKMlU=; b=fI8mHv
	syPGAxDuVct8oOWukiy8VUpfG+UBc8RZRypDIaaFhvev20qTmjWK2Eo93aaf9kmt
	eKGByXumoSuJZRWWUMJd61QDGmJ7xq/1H5VERUhVbsZq0Qsp66dUGgWU/gxbunNz
	lPfU3pT4m88ntuhpOVaQF2MbKwWK4zEM6sNvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pZGZ9ce5xkmus5JFbmKfIBAaSFzd1q2F
	BY+jcC/UM1R+MY+IZkVksfxC/ggEayp5vr1p5AW88YL3/pdGTLFD5ODEAXMRtCJl
	/wF2hPXi+qagCxG6on9O0OEUzKcVpFRuyv4bue48lr18GIsGf7wOjDWIcWZYhlfk
	+2Apg8NNvK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 642C726ECB;
	Thu,  6 Jun 2013 19:29:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F46226EC7;
	Thu,  6 Jun 2013 19:29:13 +0000 (UTC)
In-Reply-To: <CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
	(Elliott Cable's message of "Thu, 6 Jun 2013 15:03:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EAD3E6E-CEDF-11E2-BA64-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226531>

Elliott Cable <me@ell.io> writes:

> On Tue, Jun 4, 2013 at 3:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> elliottcable <me@ell.io> writes:
>>> Thus, I've added an --authorship-order version of --date-order, which relies
>>> upon the AUTHOR_DATE instead of the COMMITTER_DATE; this means that old commits
>>> will continue to show up chronologically in-order despite rebasing.
>>> ---
>>
>> Missing sign-off.  Please see Documentation/SubmittingPatches.
>
> Will-do.
>
> I read that part, and was rather confused. At no point did I get the
> idea that I should sign-off *my own initial commit*. Perhaps that part
> of the documentation needs to be slightly re-written? Would that be a
> welcome change?

I fail to see what more needs to be clarified on top of what we
already have; please re-read "(5) Sign your work" section, paying
with special attention to:

 - "YOU WROTE IT or otherwise have the right to pass it on".

 - "the contribution was created in whole or in part BY ME and I
   HAVE THE RIGHT TO SUBMIT".

But perhaps you meant something else by "*my own initial commit*"???
