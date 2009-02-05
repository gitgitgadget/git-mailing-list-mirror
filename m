From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 026fa0d5ad Breaks installs with absolue $(gitexecdir) and 
 $(template_dir) variables using older GNU makes
Date: Wed, 04 Feb 2009 23:53:50 -0800
Message-ID: <7vvdrpgvzl.fsf@gitster.siamese.dyndns.org>
References: <4985E8E1.90303@gmail.com>
 <7v63jpibe8.fsf@gitster.siamese.dyndns.org>
 <a2633edd0902042338n25dc7be4vbb202d011eb4ad78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, Steffen Prohaska <prohaska@zib.de>,
	git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:55:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUz54-00071T-9n
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbZBEHyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbZBEHyA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:54:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbZBEHx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:53:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EAB496C62;
	Thu,  5 Feb 2009 02:53:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1BEEA96C61; Thu,
  5 Feb 2009 02:53:52 -0500 (EST)
In-Reply-To: <a2633edd0902042338n25dc7be4vbb202d011eb4ad78@mail.gmail.com>
 (Pascal Obry's message of "Thu, 5 Feb 2009 08:38:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 251CEDDA-F35A-11DD-A0F6-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108517>

Pascal Obry <pascal@obry.net> writes:

> I have just proposed a patch to fix this in another thread.

Does your patch address the lack of $(abspath) in older GNU make?

I do not know if mine that used firstword did for that matter, either,
though.

Regardless, I think your patch to config.mak is independently good,
because the way Makefile defines these directories is without the trailing
slash, and it would be better to be consistent.
