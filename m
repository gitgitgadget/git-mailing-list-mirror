From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] rebase: learn to rebase root commit
Date: Fri, 02 Jan 2009 15:06:05 -0800
Message-ID: <7vljttb95u.fsf@gitster.siamese.dyndns.org>
References: <200901022320.14055.trast@student.ethz.ch>
 <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch> <7c74d8be216b4667f470e34644c4aa26dcfe0cfb.1230935095.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bss@iguanasuicide.net
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 03 00:07:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIt79-0001lw-JZ
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 00:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654AbZABXGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZABXGO
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 18:06:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbZABXGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 18:06:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 608B38DB3C;
	Fri,  2 Jan 2009 18:06:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 98B378DB3B; Fri,
  2 Jan 2009 18:06:07 -0500 (EST)
In-Reply-To: <7c74d8be216b4667f470e34644c4aa26dcfe0cfb.1230935095.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri, 2 Jan 2009 23:28:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F255B000-D921-11DD-97FF-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104444>


>  # If a hook exists, give it a chance to interrupt
> -run_pre_rebase_hook ${1+"$@"}
> +run_pre_rebase_hook $root_flag $upstream_name "$@"

You'd have to quote the $upstream_name properly here, because the original
command line could well have been:

	$ git rebase 'master@{3 days ago}'
