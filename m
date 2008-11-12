From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git send-email: interpret unknown files as revision
 lists
Date: Tue, 11 Nov 2008 21:48:12 -0800
Message-ID: <7vd4h1sder.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-2-git-send-email-madcoder@debian.org>
 <1226361242-2516-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 06:50:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L08cA-00069u-Ug
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 06:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbYKLFsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 00:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYKLFsc
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 00:48:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbYKLFsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 00:48:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 085B57CC63;
	Wed, 12 Nov 2008 00:48:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D1CD97CC62; Wed,
 12 Nov 2008 00:48:19 -0500 (EST)
In-Reply-To: <1226361242-2516-3-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Tue, 11 Nov 2008 00:54:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 889AB394-B07D-11DD-91E4-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100715>

Pierre Habouzit <madcoder@debian.org> writes:

> +test_expect_success 'detects ambiguous reference/file conflict' '
> +	echo master > master &&
> +	git add master &&
> +	git commit -m"add master" &&
> +	test_must_fail git send-email --dry-run master > errors &&
> +	grep disambiguate errors
> +'

I've queued the series in 'pu', but with a fix to this test, without which
it did not pass (and I had to rewind and rebuild 'pu').
