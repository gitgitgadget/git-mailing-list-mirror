From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Trim ending whitespaces in exclude file if needed.
Date: Mon, 18 Oct 2010 14:54:01 -0700
Message-ID: <7v39s3416u.fsf@alter.siamese.dyndns.org>
References: <AANLkTinUHQzuLJhZnVMKngEO75W=+5sES0WZFAFw5bDw@mail.gmail.com>
 <20101017024133.GF26656@burratino>
 <AANLkTimrgGYXDtN_ukWuCpjGTibrMNLQvfpq8fe=VxS_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: "Vasyl'" <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 23:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7xet-0001ab-QA
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 23:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab0JRVyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 17:54:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab0JRVyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 17:54:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9018E0748;
	Mon, 18 Oct 2010 17:54:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=34DrZeg1ZDAmaoEKPvVAPUleSNM=; b=SnreYHlTTjIMyDHjAE4jVwh
	jGS4uAIaSArZP5ElO27w9MDo5bih6I2stY5vOPojMirL6iIAgGDzTkhCrREWHWl2
	HSV59ytPTgWn0rRlokKeHk/8UCVbmjxEkbTlV6tPBh8jsSe/apiuf+jULz6NN+uk
	ALcAcG48Z4M4WYcHze0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=itn7qV5IdvfHEjrnl409uxG2V6qPavBluGkvd1AbtdqsBKXHZ
	KbnjzgLqmavuqaULlyaJgpOu9eYKllUXyodR3Z4e57eqc8xSKZ0G9oucEMj0+TFZ
	R7TLRpDF0U/TUmu2MuAYHBEI9zj8bSu2xc0X1+rFwSxFOahNZi55HX5y+8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 635B1E0747;
	Mon, 18 Oct 2010 17:54:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88471E0743; Mon, 18 Oct
 2010 17:54:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BC820CC-DB02-11DF-AAAF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159291>

"Vasyl'" <vvavrychuk@gmail.com> writes:

>> It sounds like there's a story behind this one.  Could you tell it?
>> That would help future readers of this code to easily determine
>> why they shouldn't break it.
>>
> I modify either .git/info/exclude or .gitignore by copy-pasting `git
> status`. But unfortunetly this adds spacing to ends of lines and ignoring
> does not work...

That makes it sound as if you would need a patch to fix your editor or
whatever you are using for copy/paste, rather than git, no?

I do not personally have need to ignore paths whose names end with
whitespaces, and I do not think anybody with such a need is sane, so in
that sense your patch would be less harmful than the purist in me finds
issues in it ;-)

But it changes the documented behaviour that requires documentation
updates, yes?
