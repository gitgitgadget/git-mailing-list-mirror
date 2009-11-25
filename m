From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commit --quiet option
Date: Tue, 24 Nov 2009 17:10:35 -0800
Message-ID: <7vtywj76k4.fsf@alter.siamese.dyndns.org>
References: <20091124051622.GB18003@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 02:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND6PG-0007qq-1t
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 02:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933858AbZKYBKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 20:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933823AbZKYBKm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 20:10:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933781AbZKYBKm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 20:10:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8381A1B9A;
	Tue, 24 Nov 2009 20:10:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qloEIcOUTh5U2BRk4MxCCIQf+gY=; b=mUn+G8CDv0OGqzTYScNgIRg
	Q1KpxT7kZasfNkbMdJO72FIVePAKmi/Hc1MfFbIkObZdoJiu4ig3bTFUKJDcF4FU
	LM+3WFeQD7dQEPFeiF6z/9cui29+eVMz21dPj3aNTX3XgmHa8p50KtE1oY21W8eC
	2r/Agpa5hWZL5O7IiBv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Rc68keKbx+3h119BjcO5C+Rj0EeU0Q/l1Hw4X/VYp+mByRqCe
	nzCUalSMDX5BW027gCR/ZFr9ooCwrcBbqNDYqF53+sQ2utgsKMuAomKjJbHA+Rnw
	+Alyev502Dnq62N3JDq7KJJP04KpmztOb7zntaSmJVQcqmvkFmpK/NHG8Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8068A1B99;
	Tue, 24 Nov 2009 20:10:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BBC64A1B98; Tue, 24 Nov 2009
 20:10:41 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B7331A0-D95F-11DE-B3ED-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133602>

bill lam <cbill.lam@gmail.com> writes:

> In git version 1.6.6.rc0.15.g4fa8a0 using the --quiet option it still
> show some output.  Is that intended?  Specifically I would like to
> exclude message about the untracked files when using --quite option.

Given that you are getting "you told me to make a commit without preparing
anything to commit" error message, I think it can be argued in both ways.

    $ git commit -q -uno -m 'meaningless message'

would omit the listing of Untracked files; a better alternative, depending
on what are listed in the section (I take "a123" is an example made-up for
reproduction recipe, and you are probably getting something like 'foo.bak'
in real life), might be to update your .gitignore, though.

> $ git commit -q -m commit
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified:   .git-completion.bash
> #       modified:   bin/mirrorgit
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       a123
> no changes added to commit (use "git add" and/or "git commit -a")
>
> -- 
> regards,
> ====================================================
> GPG key 1024D/4434BAB3 2008-08-24
> gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
