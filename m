From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: use --simplify-merges
Date: Mon, 11 Aug 2008 18:54:55 -0700
Message-ID: <7vljz3t2ts.fsf@gitster.siamese.dyndns.org>
References: <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
 <1218376960-6406-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:56:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSj7K-0000lL-RR
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbYHLBzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYHLBzF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:55:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYHLBzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:55:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C01950755;
	Mon, 11 Aug 2008 21:55:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6466850754; Mon, 11 Aug 2008 21:54:57 -0400 (EDT)
In-Reply-To: <1218376960-6406-1-git-send-email-trast@student.ethz.ch> (Thomas
 Rast's message of "Sun, 10 Aug 2008 16:02:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ADC93F96-6811-11DD-89FD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92059>

Thomas Rast <trast@student.ethz.ch> writes:

> @@ -333,7 +333,8 @@ then
>  	do
>  		sha1=$(git rev-parse "$ref"^0)
>  		test -f "$workdir"/../map/$sha1 && continue
> -		ancestor=$(git rev-list -1 $ref -- "$filter_subdir")
> +		ancestor=$(git rev-list --simplify-merges -1 \
> +				$ref -- "$filter_subdir")
>  		test "$ancestor" && echo $(map $ancestor) >> "$workdir"/../map/$sha1
>  	done < "$tempdir"/heads
>  fi

Hmm, where does this preimage come from?
