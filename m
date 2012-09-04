From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Tue, 04 Sep 2012 07:30:34 -0700
Message-ID: <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:30:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8u9N-00051B-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 16:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab2IDOai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 10:30:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757201Ab2IDOai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 10:30:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E64F8F17;
	Tue,  4 Sep 2012 10:30:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fkSfmhov7cbFuC8I4p/Xqthd0cA=; b=L+dohG
	utMQ1AHchWvRJYzRmu5DpjZDfb0FUlc/cSQDKUXY9LbFjKLNHTE1zlXWpAgHASq4
	hsTn9oE+1f0ufeQYwBOWY2jmikXGnCnYcIkazqW1VllFSNpwVL4k9MXifgXMgNYv
	C4LT5yYLc7bVjBt+ySPEFIBE/JuPI4lBjhvY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XpMWP4x9UJCtISKEMXuemijQm2OIknUo
	znrqXQ6WUlHooK/+H7gminhJPCRa1+6DQWyOYUkvqFH/YXkEd6h0w37AZNAt4pke
	//TCTjmbnM2erpyGPwJcrX8ZyvC5fJltMZNgEbrrt4ccjEG/+K/H7Al25CRNdAg4
	+a4ov07EpcQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C66B8F16;
	Tue,  4 Sep 2012 10:30:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D4CC8F15; Tue,  4 Sep 2012
 10:30:36 -0400 (EDT)
In-Reply-To: <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com> (Angelo
 Borsotti's message of "Tue, 4 Sep 2012 09:15:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17970462-F69D-11E1-AA1B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204746>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> $ mkdir gittest
> $ cd gittest
> $ git init
> Initialized empty Git repository in d:/gittest/.git/

At this point, the working tree presumably is empty.

> $ touch f1
> $ git add f1
> $ git commit commit -m "first commit"
> [master (root-commit) e6f935e] first commit
>  0 files changed
>  create mode 100644 f1

Now we have f1 in the working tree in the index, and in the tree of
the commit.

> $ touch f2

Now we have f1 and f2 in the working tree.

> $ git checkout e6f9 -- *

That is the same as "git checkout e6f935e -- f1 f2", as the shell
expanded "*" into "f1" and "f2".

> error: pathspec 'f2' did not match any file(s) known to git.
>
> Note the error.

Yes?

> It is clear that the set of file names that git checkout is taking is
> the union of the ones that
> match the specified path ('*') in the work directory (gittest) with
> the ones that match the
> path in the specified commit (e6f9).

The command tells git to check out "f1" and "f2" out of the tree of
e6f935e, and git found "f1" but did not find "f2" and reported an
error.  I do not see a room or need for "union" to come into the
picture to explain what we see in the above transcript.
