From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 17 Mar 2010 10:58:13 -0700
Message-ID: <7vaau6q18q.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de>
 <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 18:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrxVp-00009b-5G
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 18:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab0CQR61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 13:58:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917Ab0CQR60 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 13:58:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20FCBA2057;
	Wed, 17 Mar 2010 13:58:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pYVe8rZgXCplNiZDF0U83E9SNXc=; b=AIJ0SO
	2AbzYn5qx3ykx9UcCpFAVlgNRXZiVVxernYhD18Zx+PxyCkcGCeYk6wsBzSfiUGw
	sAOu+cE1RBV644ySwZ7IJ0w+gJxfnJLgggX4ExE/aucc/+sh1rm6Y8dNI5jD7sZt
	Xwc1bD48/Ev9De9ziuNd/6ncXfiibUpzuK774=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bqIZUqB4L40FaXxFuOS7bymGzut01WwE
	y6XQ8uZgMFIpiH5SAQEtNWIKpUEloDDwKFFRm6Hy9rhNn2ZgcuJeJ1Ak655A7dqb
	q7sThsDmQmVIF7xYHORlYYRhiseu7R5dhKOsoGJEZPr21VioLY+L+ykfyPqDqxhX
	gGtr2cI9Qn4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B4CA2053;
	Wed, 17 Mar 2010 13:58:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1A62A204F; Wed, 17 Mar
 2010 13:58:14 -0400 (EDT)
In-Reply-To: <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
 (Avery Pennarun's message of "Wed\, 17 Mar 2010 12\:44\:52 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC5E9D9C-31EE-11DF-BFA9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142421>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Wed, Mar 17, 2010 at 12:35 PM, Markus Elfring <Markus.Elfring@web.de> wrote:
>> -When <paths> are not given, this command switches branches by
>> -updating the index, working tree, and HEAD to reflect the specified
>> -branch.
> ...
> The new version spends all the time talking about weird exceptions and
> none of the time actually saying what the basic functionality is
> supposed to be.  How about this:
>
> --
> When <paths> are not given, this command switches from your current
> branch to the given branch.  This is done by updating HEAD to point at
> the given branch, reading the new branch's content into the index, and
> checking out the content into your working tree.  Where possible, any
> files you have modified in your current working tree or index remain
> modified in the newly-checked-out branch.  This cannot be done,
> however, when those modified files differ between the old and new
> branches, in which case the checkout will abort in order to avoid
> losing your changes.  You might want to use 'git stash' in this case.
> --

I like the "First state what it conceptually does and for what purpose it
is used.", but isn't this going down to too low-level details without
saying what these low-level details mean to the visible effects?

When <paths> are not given, this command makes the named branch the
current branch, so that a further work will be committed on that branch.

The index and the working tree are updated to the contents of the new
branch, while carrying the uncommitted changes you made so far along with
you.  If you made changes to paths that are different from the current
branch and the new branch, the command will stop you in order to prevent
you from losing your uncommited changes in potential conflicts between
them and the changes between two branches.  You may want retry the command
after recording the local changes (1) in a temporary commit on the current
branch, or (2) by using "git stash".  Alternatively, see "-m" option.
