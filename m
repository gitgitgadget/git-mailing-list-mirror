From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fast-export and tags without a tagger
Date: Thu, 18 Dec 2008 11:15:54 -0800
Message-ID: <7vbpv9guqd.fsf@gitster.siamese.dyndns.org>
References: <20081218164614.GS5691@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, scott@canonical.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 20:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDONA-0002hY-AU
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 20:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbYLRTQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 14:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbYLRTQF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 14:16:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbYLRTQD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 14:16:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DA9188EF2;
	Thu, 18 Dec 2008 14:16:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6176088EF1; Thu,
 18 Dec 2008 14:15:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F5367AC-CD38-11DD-B32E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103481>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Tags created with ancient versions of git have no tagger. The udev repo
> has such tags, for example:
>
> $ git cat-file tag 4ea98ca6db3b84f5bc16eac8574e5c209ec823ce
> object face198a5f21027fefe796dc01e19e349a2d36ce
> type commit
> tag 062
>
> fast-export will fail on these repos. From IRC:

Is "fast-export" the only thing that chokes on these tags?

What I am worried about is if we have accidentally/stupidly/by mistake
made other codepaths that check the validity of a tag object too strict,
which would result things like "git show $such_a_tag" to barf.
