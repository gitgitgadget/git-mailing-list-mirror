From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/5] t5512 (ls-remote): modernize style
Date: Sat, 03 Mar 2012 00:05:05 -0800
Message-ID: <7vipim6rf2.fsf@alter.siamese.dyndns.org>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330740942-25130-3-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 09:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3jxs-0007TX-6u
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 09:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab2CCIFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 03:05:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab2CCIFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 03:05:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8A32376E;
	Sat,  3 Mar 2012 03:05:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=CFNiqPnnabbQ7SwN51IDRhvO8Pw=; b=Lk6ShKoGhvraZfDw1VGV
	rJWUcgwxDJ5dT0WvqimNchtQLz9fw5kvhwLemk5hj14l/jykiJZOuTEcAKSS2YkO
	itddVMtIjwlWiPWiaKy/dOZEGSobalx+Sa6M+f6GMnL1dFYuWKUEH4A6+pEJiAF8
	3vK+y7XWLQSUWpJtrUZdodQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Z2nqim83RHnFx5KRggUq01r/JT2vup9B9vwD3OsSlB9yTd
	MvAg9egV5TA5f2JwqujH+VsJW81sRQan2FLKggOPrzOg3BYh0YwwDZOi34rPGDRY
	RFFGCrLTq3s3jPJusKTp/e/tkjK+PmZKVRAR7atdFD2mfMBpxrCqrH2O7YDGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4FD376D;
	Sat,  3 Mar 2012 03:05:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AF25376C; Sat,  3 Mar 2012
 03:05:06 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96B070EE-6507-11E1-87E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192100>

Tom Grennan <tmgrennan@gmail.com> writes:

>  test_expect_success 'confuses pattern as remote when no remote specified' '
> +	'"
> +	cat >exp <<-EOF
> +		fatal: 'refs*master' does not appear to be a git repository
> +		fatal: The remote end hung up unexpectedly
> +	EOF
> +	"'

Please make it a habit to make your test script a cascade of &&, i.e.

	... remote specified' '
	cat >exp <<-\EOF &&
        fatal: '\''refs*master'\'' does not ...
	...
        EOF

No need to resend; I'll fix it up locally.        

Thanks.
