From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'diff C^!' show the same diff as 'show C'
Date: Thu, 20 Aug 2009 16:03:09 -0700
Message-ID: <7vws4ynl5e.fsf@alter.siamese.dyndns.org>
References: <86d1201d8adf53c1f48c0f3526d8e81475b18244.1250806019.git.trast@student.ethz.ch> <7vab1up1gz.fsf@alter.siamese.dyndns.org> <200908210042.05802.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 21 01:03:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeGfI-0005HN-Qf
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 01:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbZHTXDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbZHTXDU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 19:03:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbZHTXDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 19:03:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA00C125E3;
	Thu, 20 Aug 2009 19:03:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NwZ6PFlGBk13h5d1H530ydm5QUY=; b=pp4Y/S
	2ZwSY4ejAnixudeyTY6jA/yQmfXWyJzYYLH0Hf9KJ6NlFyoHFyAbxG+h6O/Ttkih
	FI2EqHOsK8TFSozS+9hDJy8/QT1k9rkbfk1DT94w8Cl2nCkRPQfXf55mFV8joudW
	FzI3ZUjdbwS//iQnyPTPaW+f+HtVw7sDJG1AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LgfKZ0ONYON2XRQkt5LTW1EmidNh8k/O
	owivZ+hrgX5dBU73oCHGU7jOwgF9f1nW7lrPe6DgXGXbKO9vKo+Z7BfjtLkkCHgU
	jl9FMyAqF/arinXEdRr5BdOH/4MaN3W4pFJI/L+BfdTf+j2LvDl4Ulfwskwdm3Dy
	rFW7fgP6ww8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71771125E1;
	Thu, 20 Aug 2009 19:03:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 789F6125E0; Thu, 20 Aug
 2009 19:03:11 -0400 (EDT)
In-Reply-To: <200908210042.05802.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri\, 21 Aug 2009 00\:42\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5AA2E0E-8DDD-11DE-91AB-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126658>

Thomas Rast <trast@student.ethz.ch> writes:

>> If that is indeed the case and if it is a common thing to ask, isn't it
>> more productive to teach "show" a way to do so in a simpler way than
>> doing, say,
>> 
>> 	$ git show --pretty=format: HEAD
>
> That still doesn't get rid of the stray newline.

And the reason you don't want that newline, especially when you know there
always is one so if you really wanted to you could easily sed it out,
is...?
