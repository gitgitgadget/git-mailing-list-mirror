From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Integration branching
Date: Mon, 07 Apr 2008 10:41:20 -0700
Message-ID: <7vod8lpnpb.fsf@gitster.siamese.dyndns.org>
References: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kai Hendry" <hendry@aplixcorp.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 19:42:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JivMJ-0003np-UT
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 19:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbYDGRle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 13:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbYDGRle
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 13:41:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbYDGRle (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 13:41:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B7B6CDA7;
	Mon,  7 Apr 2008 13:41:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A84F7CDA4; Mon,  7 Apr 2008 13:41:29 -0400 (EDT)
In-Reply-To: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com>
 (Kai Hendry's message of "Mon, 7 Apr 2008 14:02:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78980>

"Kai Hendry" <hendry@aplixcorp.com> writes:

> So I expected it to work like so:
>
> git clone git://git.webkit.org/WebKit.git
> git checkout -b test
>
> <Make a few small changes and commit>
>
> git-config remote.upload.url ssh://git.webvm.net/srv/git/webkit-test

A set of big questions is how that git.webvm.net/srv/git/webkit-test
repository was prepared, what its history look like and how it relates to
the history your repository has.  I presume that that is different from
the repository you are pushing from (which is "x61:aplix/test/WebKit"
repository), but other than that you did not give any details to guess
further.

> x61:~/aplix/test/WebKit% git push --thin -v upload test

By the way, that --thin is an implementation detail and not meant for the
end user consumption.  I do not think it would matter in this case,
though.

> Pushing to ssh://git.webvm.net/srv/git/webkit-test
> Counting objects: 371612, done.
> Compressing objects: 100% (67851/67851), done.
> Writing objects:  11% (43886/371612), 25.32 MiB | 88 KiB/
>
> However when uploading the branch it seems to upload _everything_
> which is far too big and impractical. Couldn't it just somehow
> reference the remote branch and just publish the patch of the "small
> changes"?

What you described is exactly what is supposed to be doing, but again as
we do not know how that git.webvm.net:/srv/gi/webkit-test/ repository was
prepared, we cannot tell.

But I have a theory:

    http://thread.gmane.org/gmane.comp.version-control.git/77643

and the latest code is still parked in 'pu' branch.
