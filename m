From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git am and the wrong chunk of ---
Date: Thu, 09 Aug 2012 18:26:21 -0700
Message-ID: <7v393vmtaa.fsf@alter.siamese.dyndns.org>
References: <5024523F.3050208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 03:27:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sze0J-0005aj-LC
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 03:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab2HJB0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 21:26:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440Ab2HJB0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 21:26:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D74829FAC;
	Thu,  9 Aug 2012 21:26:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wDof9VozJHb5Np0rTby/Rh8uegg=; b=rgDGun
	VRMvuwHYl39KRDE9OWyKrl/kltEZ5iEPLDZRIZ5n4rLG/iTpBQPJbKpPHnEk4OWz
	74VdS2OJSrymfpEYm0KUj7gKH/+LXHa1HKVcFFPf9Ln7KLkuOo4IP+6zPskin0+F
	Um1mWfvCTpfYG/pkTXnVfeTdh9vVwIRw3nFC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yVYAx63yu3elHQ6eWjybAtgk1a2Jzp9s
	ss35HdQU0uRHmA+YrCQcnRvXkAM1wuzpmRZ+sENJRGcqZzAQOK0m574CHswFUpr2
	WuoFIoeykF4WSdfEeKCr0HK2y7wIODAVQdn9+SvekXAb8BGhCsoeV85QeXWzSFBr
	UTUBrZFT+Qw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4FDD9FAB;
	Thu,  9 Aug 2012 21:26:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D02B9FAA; Thu,  9 Aug 2012
 21:26:23 -0400 (EDT)
In-Reply-To: <5024523F.3050208@zytor.com> (H. Peter Anvin's message of "Thu,
 09 Aug 2012 17:13:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65691648-E28A-11E1-9BD0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203198>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Hello,
>
> I have some contributors who consistently put their commentary
> *before* the "---" line rather than *after* it, presumably with the
> notion that it is some kind of "cover text".  This messes with "git
> am", and so I end up having to edit those posts manually.
>
> I have tried git am --scissors and it doesn't seem to solve the problem.
>
> Is there any other option which can be used to automatically process
> such a patch?

I hate to be the one who is telling you this, but if the submitter
cannot be trained to write supporting material after "---" as the
convention across git using projects suggest him to do, it is likely
that he didn't write supporting material before the scissors, or did
not resist the temptation to deviate from the accepted shape of the
scissors (e.g. "-- >8 --") just to be creative.  For that matter, I
would be mildly surprised if the material in the middle is usable as
is as an acceptable log message from such a submitter X-<.

So in short, no, --scissors (or -c in short) is not any more magical
than the traditional "---".
