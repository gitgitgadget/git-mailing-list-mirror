From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Tue, 25 Jun 2013 14:33:18 -0700
Message-ID: <7vehbp27vl.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
	<7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
	<8738shi2ht.fsf@linux-k42r.v.cablecom.net>
	<7vwqpshkxj.fsf@alter.siamese.dyndns.org>
	<1372190294-sup-1398@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:33:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urarf-0004mL-P5
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891Ab3FYVdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:33:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab3FYVdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:33:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AA002B148;
	Tue, 25 Jun 2013 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ZUuTbya2XnZ14rQ/cml3KDNIYnM=; b=v0fw2o09e1jOoZNuKt65
	86PxT43Q1PTC+J8+rbJO/hRn93SR4EObukro62gjcW6Lxs8MRZUPh0HJuNxQK0GD
	piquZu1TbQQwxBsyg1lc/ZJmosZ42Tl0EL1WKfivkVn1z2NjGF6YJnsaBlrGrghu
	z0ChZ6Mpl4Np0JX1jcgopXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=D/zf0KrvwKn6djtd3Y2NtbpFmvOQSQ4RaxzXZCLbwfR5Ru
	iGROLAxQYmUIYrQAN7ZcKfQ7+kzXrF0C9JZj8eEDSZpz2Qa8H2rGGbpm9qfKdWKS
	DLKG8TfmUJq4EDB4olAJzrumySAeU52Fzsx6jcp8uHpKejYjb+mvJXSWuQbdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51D4A2B147;
	Tue, 25 Jun 2013 21:33:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AECE12B146;
	Tue, 25 Jun 2013 21:33:19 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAC374D8-DDDE-11E2-95DF-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228993>

Andrew Pimlott <andrew@pimlott.net> writes:

Just reponding for the "procedual" part for now.

> So if I don't want to break the discussion, should I append the unedited
> format-patch output to my message after "scissors", or should I send it
> as a whole new message with --in-reply-to?  Or something else?  I'll try
> the first.

Which is fine, and you are almost there, but you do not want

 (1) "From 99023b..." that is not part of the message (it is a
     delimiter between multiple patches when/in case a file contains
     more than one);

 (2) "From: Andrew..." that is the same as the e-mail header in the
     message I am responding to;

 (3) "Date: ..." which is older than the e-mail header in the
     message I am responding to---the latter is the date people
     actually saw this patch on the mailing list, so it is
     preferrable to use it than the timestamp in your repository.

So in this case, I'd expect to see, after the "-- >8 --" line, only
"Subject: " line, a blank and the log message.

>
> ---8<---
> From 99023bff23f18a341441d6b7c447d9630a11b489 Mon Sep 17 00:00:00 2001
> From: Andrew Pimlott <andrew@pimlott.net>
> Date: Fri, 14 Jun 2013 10:33:16 -0700
> Subject: [PATCH 1/4] rebase -i: handle fixup! fixup! in --autosquash
>
> In rebase -i --autosquash, ignore all "fixup! " or "squash! " after the
