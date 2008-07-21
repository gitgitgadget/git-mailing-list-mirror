From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about
 prefixing pathspec
Date: Mon, 21 Jul 2008 01:00:57 -0700
Message-ID: <7v1w1nvf7q.fsf@gitster.siamese.dyndns.org>
References: <20080720233956.GH10151@machine.or.cz>
 <20080721075618.14163.45309.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 10:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKqLQ-0002hq-L5
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 10:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbYGUIBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 04:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbYGUIBG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 04:01:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbYGUIBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 04:01:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 315F136FEE;
	Mon, 21 Jul 2008 04:01:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8E0BA36FEA; Mon, 21 Jul 2008 04:00:59 -0400 (EDT)
In-Reply-To: <20080721075618.14163.45309.stgit@localhost> (Petr Baudis's
 message of "Mon, 21 Jul 2008 09:56:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29F83568-56FB-11DD-99F1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89319>

Petr Baudis <pasky@suse.cz> writes:

> +Note that within a subdirectory of the working copy, 'git ls-tree'
> +will automatically prepend the subdirectory prefix to the specified
> +paths and assume just the prefix was specified in case no paths were
> +given --- no matter what the tree object is!

Don't be negative upfront.  Explain why this is a good thing first.

	... were given.  This is useful when you are deep in a
	subdirectory and want to inspect the list of files in an arbitrary
	commit.  E.g.

		$ cd some/deep/path
		$ git ls-tree --name-only -r HEAD~20

	will list the files in some/deep/path (i.e. where you are) 20
	commits ago, just like running "/bin/ls" there will give you the
	list of files you have right now.

> +Thus, within a subdirectory, 'git ls-tree' behaves as expected
> +only when run on a root tree object (e.g. with a 'HEAD' tree-ish,
> +but not anymore when passed 'HEAD:Documentation' instead).
> +
> +
>  OPTIONS
>  -------
>  <tree-ish>::
