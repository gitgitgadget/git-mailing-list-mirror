From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce the config variable pack.packSizeLimit
Date: Fri, 08 Feb 2008 21:31:32 -0800
Message-ID: <7vfxw2g0gb.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802051423530.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torarvid@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 06:32:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNiK3-0003Sd-NZ
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 06:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbYBIFbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 00:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbYBIFbq
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 00:31:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYBIFbp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 00:31:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B059C14B8;
	Sat,  9 Feb 2008 00:31:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BAD614B7;
	Sat,  9 Feb 2008 00:31:34 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802051423530.8543@racer.site> (Johannes
	Schindelin's message of "Tue, 5 Feb 2008 14:25:04 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73192>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> "git pack-objects" has the option --max-pack-size to limit the file
> size of the packs to a certain amount of bytes.  On platforms where
> the pack file size is limited by filesystem constraints, it is easy
> to forget this option, and this option does not exist for "git gc"
> to begin with.
>
> So introduce a config variable to set the default maximum, but make
> this overrideable by the command line.

The intention is good and all makes sense.

> +test_expect_success \
> +    'honor pack.packSizeLimit' \
> +    'git config pack.packSizeLimit 200 &&
> +     packname_4=$(git pack-objects test-4 <obj-list) &&
> +     test 3 = $(ls test-4-*.pack | wc -l)'
> +

Where does "3" come from, and what could break it?
