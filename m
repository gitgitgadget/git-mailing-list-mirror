From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo
 root  directory?
Date: Thu, 26 Feb 2009 09:04:41 -0800
Message-ID: <7v1vtluo2e.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
 <slrngq7e6c.iti.sitaramc@sitaramc.homelinux.net>
 <7vzlgbhh95.fsf@gitster.siamese.dyndns.org>
 <slrngq9es5.ik0.sitaramc@sitaramc.homelinux.net>
 <7vab8aap6t.fsf@gitster.siamese.dyndns.org>
 <slrngqaa5n.mp1.sitaramc@sitaramc.homelinux.net>
 <7vvdqyyzsr.fsf@gitster.siamese.dyndns.org>
 <slrngqbrpd.t1k.sitaramc@sitaramc.homelinux.net>
 <slrngqc47n.t1k.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 18:07:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcjhO-0008Ji-Sw
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 18:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbZBZREu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 12:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756029AbZBZREt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 12:04:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074AbZBZREs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 12:04:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 95DC49DB2F;
	Thu, 26 Feb 2009 12:04:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 241539DB2C; Thu,
 26 Feb 2009 12:04:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91E8D126-0427-11DE-A079-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111580>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> How about this:
>
> ----8<----
>
>     - an optional leading ! symbol meaning "unignore paths
>       that match this pattern, instead of ignoring them"
>
>     - an optional trailing / symbol meaning "this pattern
>       matches only with a directory (i.e., files and
>       symlinks won't match)"
>
>     - the above two symbols (if present) are then removed.
>       What remains is treated as a normal shell glob
>       pattern, with the additional restriction that if the
>       pattern still contains a slash, it matches only at the
>       current directory and not in its subdirectories

Sure, but then you are not stripping the leading / from the pattern but
you do not use it for the purpose of matching, right?

I think your original before I wondered about the ambiguity is the best
rewrite so far.
