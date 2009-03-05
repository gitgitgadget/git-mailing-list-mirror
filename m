From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add an (optional, since expensive) test for >2g
 clones
Date: Thu, 05 Mar 2009 15:08:33 -0800
Message-ID: <7vfxhry3da.fsf@gitster.siamese.dyndns.org>
References: <cover.1236268730u.git.johannes.schindelin@gmx.de>
 <96a26f3a883890b3e56c867e8183618784837d4d.1236268730u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 00:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfMhf-0003I3-UD
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 00:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbZCEXIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 18:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbZCEXIm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 18:08:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbZCEXIm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 18:08:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0712E384A;
	Thu,  5 Mar 2009 18:08:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 048AB3846; Thu, 
 5 Mar 2009 18:08:34 -0500 (EST)
In-Reply-To: <96a26f3a883890b3e56c867e8183618784837d4d.1236268730u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Thu, 5 Mar 2009 17:05:09 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 908A440A-09DA-11DE-9F61-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112357>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +test_expect_success 'setup' '
> +
> +	git config pack.compression 0 &&
> +	git config pack.depth 0 &&
> +	blobsize=$((20*1024*1024))
> +	blobcount=$((2*1024*1024*1024/$blobsize+1))
> +	i=1

What happened to the && chain?
