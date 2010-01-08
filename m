From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 08 Jan 2010 08:56:38 -0800
Message-ID: <7vaawosfg9.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:57:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTI8w-0002ok-CY
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab0AHQ4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709Ab0AHQ4y
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:56:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab0AHQ4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:56:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3B4C8F794;
	Fri,  8 Jan 2010 11:56:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=y/q8pT8R1yAk+G9B+2BAjp/+Bls=; b=a/ygaDAkPuIxyiuhivfO6RX
	0o2acGTwhCfPthjjAt84tgrA/9RCzBE55A6z37wq4aspjULoIELnFhTGLNfwPg0O
	V/uAurMLzMBbGi9emuqdAVx0U4vGx52fyx8mlIkLyT+56nmzNCd4Fn5YwykUxUaC
	WX8x2kiuWx8tePhsPSOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VfSL1hhO6VoIl9rcixMKlZWEjX+F6KfwLFCtUgH0WwyQlTgGP
	BheGHlL7Ig3+oBpFDVN59D3/ZcEUyMCfAmO3hw3whXCr4Lfbhr1vm/Uxf+YORAu+
	Gtbp48+64Lfceep6kACGPMryuiSdu27mg4dqJgLp4jVzLZLGmuAcL3U0yE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 898578F78F;
	Fri,  8 Jan 2010 11:56:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 953558F78E; Fri,  8 Jan
 2010 11:56:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE4EC498-FC76-11DE-83AC-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136458>

Junio C Hamano <gitster@pobox.com> writes:

> You can see it as a feature that you can use to check what would happen
> if you stopped ignoring the directory from the higher level.  With a patch
> to always cd-up and use pathspec, that will become impossible.

I hate to say this, but I have a feeling that status might be what needs
to be fixed instead.  It isn't hard to imagine a use case where you don't
want to be bothered by crufts in lower level directories when you are
looking at the bigger picture (e.g. at the top of the hierarchy) but when
you go to individual subdirectory you would want to see them.
