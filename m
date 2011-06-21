From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/13] revert: Introduce struct to keep command-line
 options
Date: Tue, 21 Jun 2011 12:28:15 -0700
Message-ID: <7vaadb7zn4.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-8-git-send-email-artagnon@gmail.com>
 <20110621165854.GL15461@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 21:28:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ6ca-0003J2-BW
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 21:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449Ab1FUT2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 15:28:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338Ab1FUT2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 15:28:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 130AF486F;
	Tue, 21 Jun 2011 15:30:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+xMRKfDzM76U1UdYtEfD+mRiWvE=; b=Ma1Juo
	pdR/syla2qTYO7pF7cuNT9upRkEXlFbJcKWNfDyrK8ZjZWrusvYF/QPj4+zsgvEh
	99AT0icnsbXrjPSc98X97nGbmEKerLpwjw0op3YkcSTMpgyyioN+NWtHPEGwjgT1
	0diFRa3L9i+tERZ7r60tInnaFQeNJua2Yd4oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=faUfJt+oJE+YjBbmnbLtd4Z+0HYyYoKD
	dJ6tHqrIc/lOvn3dUBq+dcURLndWKIaKfYznW/ACTWuP0m5hBlnIKq8I7AACasIm
	jNidFv0Bt5xGrbribnnxY73w5X09O9FepvaO1UiFbfYplnfRZHnwYXzmslj5vpPU
	DU8N26ZBTJY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04CC5486D;
	Tue, 21 Jun 2011 15:30:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4E539486A; Tue, 21 Jun 2011
 15:30:29 -0400 (EDT)
In-Reply-To: <20110621165854.GL15461@elie> (Jonathan Nieder's message of
 "Tue, 21 Jun 2011 11:58:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC1178A6-9C3C-11E0-9AD7-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176186>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
> ...
> The struct leaves out the variable "me".  A person might wonder why
> the above rationale applies to the other variables but not that one. :)

Good point.

>> Unfortunately, parsing strategy-option violates a C89 rule:
>> Initializers cannot refer to variables whose address is not known at
>> compile time.
>
> Reading this, one is led to wonder:
> ...
>  - is this a regression?

Let me add one.

 - how does this patch work around that issue?
