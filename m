From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make sure $PERL_PATH is defined when the test suite is
 run.
Date: Mon, 16 Nov 2009 16:10:13 -0800
Message-ID: <7v1vjym2oq.fsf@alter.siamese.dyndns.org>
References: <20091116234849.GA3608@plop>
 <1258415600-4656-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Philippe Bruhat \(BooK\)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:10:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NABeR-0000Fv-23
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 01:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbZKQAKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 19:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbZKQAKR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 19:10:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbZKQAKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 19:10:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF7AC9F826;
	Mon, 16 Nov 2009 19:10:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yYhCOR60Ekds2JvIFsXGMAJLC1k=; b=MYH8RK
	jY2InvHIldCfQReP7TjEc4kRSAY8i+NOqHoE/eKlRzLnjmkWyEyRbKZgkX7s3F2I
	H7nMuCjwilMShPCnkG9cB72njXkhrVZY9k38ak8Zo0hyFrDhqgUEmsquuI5kBk8U
	i5xRLsYj5EEjt5b7M0hbJrEZg1VWkMPi0Ay20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wr+ax2yC5DT4BD40hiryYrp8NvWCJ4q7
	+OzgJy/JrE0RmDFOf5kByoGcZRpf4YsNOjWGLbbl0/RzVIaPGGdM0O3QrXI+SaJW
	aWU8mMK7oXOZjJNIWcIDpZIV9WKD+1M8NE2msdYlNiIOlNHqwtL1pDaHQ7gdv3J6
	jpGuk8LMUCA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFC959F825;
	Mon, 16 Nov 2009 19:10:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 933D09F824; Mon, 16 Nov 2009
 19:10:14 -0500 (EST)
In-Reply-To: <1258415600-4656-1-git-send-email-book@cpan.org> (Philippe
 Bruhat's message of "Tue\, 17 Nov 2009 00\:53\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 962D634A-D30D-11DE-9004-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133042>

"Philippe Bruhat (BooK)" <book@cpan.org> writes:

> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index 64f947d..dc710f8 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -20,7 +20,7 @@ then
>      say 'skipping git-cvsserver tests, cvs not found'
>      test_done
>  fi
> -perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
> +$PERL_PATH -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
>      say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
>      test_done
>  }

Shouldn't these $PERL_PATH all be quoted inside double-quotes?
