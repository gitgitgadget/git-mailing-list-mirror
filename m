From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git ls-files -m --with-tree does double output
Date: Thu, 13 Nov 2008 14:35:22 -0800
Message-ID: <7vod0jfe51.fsf@gitster.siamese.dyndns.org>
References: <37512.N1gUGH5fRhE=.1226613228.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:37:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0koT-0008IA-R3
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYKMWgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbYKMWgB
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:36:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbYKMWgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:36:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E6C6A7D502;
	Thu, 13 Nov 2008 17:35:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 320927D4FD; Thu,
 13 Nov 2008 17:35:29 -0500 (EST)
In-Reply-To: <37512.N1gUGH5fRhE=.1226613228.squirrel@webmail.hotelhot.dk>
 (Anders Melchiorsen's message of "Thu, 13 Nov 2008 22:53:48 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E654578-B1D3-11DD-BC9D-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100923>

"Anders Melchiorsen" <mail@cup.kalibalik.dk> writes:

> and@dylle:~/repo$ git ls-files -m --with-tree=HEAD
> a
> a
>
>
> Jeff King added:
> ...
> It isn't clear to me which code is _supposed_ to be pulling out such
> duplicates here. That is, is read_tree broken, or is
> overlay_tree_on_cache just calling it wrong?

I had to look up what -m meant in ls-files, as I never considered that
option as part of the plumbing.

What's the use case of using -m together with --with-tree to begin with?
I think the only sensible other option that makes sense with --with-tree
is --error-unmatch.
