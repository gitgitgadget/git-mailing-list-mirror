From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/index-pack.c: Fix crash on MinGW caused by
 uninitialised mutex
Date: Fri, 09 Mar 2012 12:30:25 -0800
Message-ID: <7v1up15xge.fsf@alter.siamese.dyndns.org>
References: <4F5A4F94.1060309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 09 21:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S66SS-0000ck-8S
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 21:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227Ab2CIUa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 15:30:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964781Ab2CIUa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 15:30:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 638427A28;
	Fri,  9 Mar 2012 15:30:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Bm7i+Eq4Vt7P8UfgZLG1G5T5Ck=; b=aM8MTU
	bhwfte8eefg0nujUbsIbTFpKme0C7vAMekwNJ9AK2o91trMRUsynhWWiLBo68bkU
	WljnRIQYdQRUrIfpoyrWbwDreKxs65+BnvAaWJ/zAFjGU6JHnUfXb2UMQk+eP18r
	ADbNH+lI1jq8U9ZAP4ugFu8SzvftQiZQGbkjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=APROxBXV657X+1V3rCQmh1v8A1XecDVZ
	J++jFDzsbTYoS1WYRGUD7x9pV9C3U7iKWtJQ6Sm/PUKqoX6C87HH1C5UKNsfRBFD
	THWMwmDBGqqeyl2TYawJ2g2wyxxeQOWn4LWHbqPA7MNlyyMABy1TFxDiAEyrUz8y
	AwJUV6hAMiA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B28E7A27;
	Fri,  9 Mar 2012 15:30:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF4127A26; Fri,  9 Mar 2012
 15:30:26 -0500 (EST)
In-Reply-To: <4F5A4F94.1060309@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Fri, 09 Mar 2012 18:44:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B49C0414-6A26-11E1-8D41-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192740>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Hi Nguyen,
>
> This patch, on top of my earlier one, fixes the problem on MinGW.
> I am assuming that the tests t5300-pack-object.sh, t5302-pack-index.sh,
> t5510-fetch.sh and t6050-replace.sh are sufficient to test the new
> threaded version of git-index-pack. In any event, I have tested this
> on MinGW, cygwin and Linux and all of the above tests pass.

I'd drop what is in 'pu' which is a few iterations old already and
will not hit 'master' until the next cycle begins when I'd expect a
re-rolled series.

Thanks both for working on this one.  
