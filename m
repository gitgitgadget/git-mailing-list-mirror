From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] config: Disallow multiple variable types.
Date: Mon, 16 Feb 2009 18:24:51 -0800
Message-ID: <7vy6w5ajgs.fsf@gitster.siamese.dyndns.org>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZFfH-0004MS-UF
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbZBQCY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 21:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZBQCY6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:24:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbZBQCY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 21:24:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BA819A034;
	Mon, 16 Feb 2009 21:24:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4061B9A032; Mon,
 16 Feb 2009 21:24:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B64ED0C-FC9A-11DD-AFCD-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110297>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +	if (HAS_MULTI_BITS(types)) {
> +		error("only one type at a time.");
> +		usage_with_options(builtin_config_usage, builtin_config_options);
> +	}

You would be able to catch "config --bool --get-color color.diff.whitespace"
as an error by doing something similar to the "fake actions" for get-color*
as I suggested in my review on [3/8].

I did not find anything objectionable in the remainder of the series.

Thanks.
