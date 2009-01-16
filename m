From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: git grep: cannot generate relative filenames containing
 '..'
Date: Thu, 15 Jan 2009 17:52:56 -0800
Message-ID: <7vr634ow3r.fsf@gitster.siamese.dyndns.org>
References: <20090115222905.8157.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 02:54:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNdul-0003J0-Ka
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 02:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbZAPBxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 20:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755432AbZAPBxF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 20:53:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbZAPBxC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 20:53:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 85C879079A;
	Thu, 15 Jan 2009 20:53:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B12EF90792; Thu,
 15 Jan 2009 20:52:58 -0500 (EST)
In-Reply-To: <20090115222905.8157.qmail@science.horizon.com> (George
 Spelvin's message of "Thu, 15 Jan 2009 17:29:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 68386198-E370-11DD-A982-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105903>

"George Spelvin" <linux@horizon.com> writes:

> Could someone fix this some day?

As far as I know you are the first to ask for this, so perhaps people never
considered this was something to "fix"....

> "git grep <pattern> ../include"
> is something I find myself wanting quite frequently, and it's a fresh
> annoyance every time I type it to discover that it still doesn't work.
>
> While you're at it, an option to search the entire git tree rather than
> the current subdirectory would also be useful.  I was thinking about
> a flag like -r (for "root"),...

... but

    $ grep -r foo ..

will look for foo anywhere below one level up from your current directory,
and I think it may be a reasonable enhancement to teach:

    $ git grep foo ..

to do the same.  Patches welcome ;-).

By the way, congratulations for getting a name.  Can we fix one entry in
our .mailmap file?
