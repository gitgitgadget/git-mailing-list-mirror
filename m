From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Mon, 23 Nov 2009 10:27:24 -0800
Message-ID: <7vtywlyu43.fsf@alter.siamese.dyndns.org>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com>
 <7v1vjvebem.fsf@alter.siamese.dyndns.org> <4B095F91.8030305@lsrfire.ath.cx>
 <20091123112221.GA7175@sajinet.com.pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCddm-0005az-CU
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 19:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbZKWS1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 13:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbZKWS1d
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 13:27:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbZKWS1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 13:27:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2A081A5E;
	Mon, 23 Nov 2009 13:27:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=1n0PnlUOadtk6gd4S5EYHIFf4
	SQ=; b=YfdJTy7L+AGcNPIXgr9YsoSbxBQ8DMsFG2HFoLj9LhXDm2kjjdI6FBGJ7
	ENumvWwO4FJ4fOD7w3ksgPB/k8uIZWQlNmDxf2t1ylhkn5zriEufDNxIkKgbECK7
	7KADJxhJWUW26DIk/svj4/CXbdYrUF6Qwy2B3MSXwX7vys3vVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=OKI7SdWO5InUxkSjyYv
	gOm1V9bsJzmYgPpEICQ8JXM6rF6aw7TvEI544th44PTb7S7rCDOwnG2bSxFvSeP3
	5UQCWFS0RNvJS/wKjsn8kI5WnFI31a3Nit42L5KvkD5sjWCKTPbtmE9FwhH/zBBU
	cCQyTalNYGGvRMBTqmGY1eEA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F56081A5C;
	Mon, 23 Nov 2009 13:27:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37CCB81A5A; Mon, 23 Nov
 2009 13:27:26 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DD3BFF80-D85D-11DE-BF3F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133520>

Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:

> why not better to apply the proposed patch from Junio in :
>
>   http://article.gmane.org/gmane.comp.version-control.git/127980/
>
> it would IMHO correct all reported issues and serve as well as a catc=
h
> all from other tools that could be introduced in the future and that
> will be similarly affected by this misfeature.

I think Ren=C3=A9's patch is more sensible than $gmane/127980 because w=
e have
no business mucking with these environment variables when we are runnin=
g
things other than external grep.  You could be using system's "grep" in
your pre-commit hook to find some stuff, and your hook either may rely
on your having a particular set of GREP_OPTIONS in your environment, or
may be designed to work well with GREP_OPTIONS.
