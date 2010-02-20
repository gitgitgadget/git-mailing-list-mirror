From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] tests: Add tests for automatic use of pager
Date: Sat, 20 Feb 2010 09:33:00 -0800
Message-ID: <7v8wanq0c3.fsf@alter.siamese.dyndns.org>
References: <20100219065010.GA22258@progeny.tock>
 <20100219071857.GF29916@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 19:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NitCq-0002Zi-P4
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 18:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab0BTRdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 12:33:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab0BTRdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 12:33:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 091099BC7B;
	Sat, 20 Feb 2010 12:33:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wCWWljjCxfmYpa2elPEMh6i2z20=; b=Tokv8u
	bx7bBvAj/F/ZvpvxcXwHLBYaMLenkhxJMgvglITrioLIrSiA9/0jAZSC6zbq/vVt
	1K8Se5DZPIZOR43gS3XjAfA+zLI6DXPBRRDMEID0QPzgmeDdU3PT6+SSO3vTERXs
	6DzjXtYKepIxIEi4ZPiId+bkTJAgu6MDKvzmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQNKSIbrxJ5cvb4X38+5hFv7hlsL8ySd
	FApSDhjo92WAShCDNRcnFm0FiMn83OGArIHdVC49waWs5BKm5M2lWPskTqEFgta2
	7B4Co/HPpE5Iby7gv/MAYIUT2imxuWKKTnV19uhctb/ypaX3xRfVZfH+/HharO1r
	Mr6NNWTDaP8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A788B9BC79;
	Sat, 20 Feb 2010 12:33:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B52B99BC73; Sat, 20 Feb
 2010 12:33:01 -0500 (EST)
In-Reply-To: <20100219071857.GF29916@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 19 Feb 2010 01\:18\:58 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 021EBC2E-1E46-11DF-92D4-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140539>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> new file mode 100644
> index 0000000..2e9cb9d
> --- /dev/null
> +++ b/t/t7006-pager.sh
> @@ -0,0 +1,163 @@
> ...
> +rm -f paginated.out
> +git config color.ui auto
> +test_expect_success TTY 'color when writing to a pager' '
> +	TERM=vt100 test_terminal git log &&
> +	colorful paginated.out
> +'

I didn't see test_terminal defined up to this point.  Am I missing
something?
