From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merging confusion and question
Date: Tue, 07 Aug 2012 18:43:06 -0700
Message-ID: <7v393yupjp.fsf@alter.siamese.dyndns.org>
References: <5021B20D.2030702@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 03:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyvIt-0004cS-1P
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 03:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab2HHBnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 21:43:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512Ab2HHBnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 21:43:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB7D4463C;
	Tue,  7 Aug 2012 21:43:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nwDuK/ZquC3FbO8uzDxmwj0X1ow=; b=IPgPdt
	bO9KAJavVwKj1XgB2u5Z5vfdG9Fty8pOy7cvDoPN9L3oeeATuOp7olAGIsNW1qjF
	F31JFCYMk+0cucRm4NGamXPaYN8sbPhClW0mPQprGHoA6lO4kuvkI12pdKt0KYC2
	1985a3df+hAYuL8yIGoC2xXZPsg5uuwZzW7As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n3qHNyXkefy1hAdEfSUO7kZywUpPejCP
	PBF4YXYdKiwiOGCQBYjlmE/Dz3RnYZ9rGYR1sZU7Gj770euylYnxm3YBJT9igzB5
	iV/g92KK99Ocr7i3pMAWtv77i/18iGLNoOraZGkY13mWq5OEPhCSEbN2UlP+AxcM
	a200D1fN+Wg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D836E4632;
	Tue,  7 Aug 2012 21:43:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ACC24631; Tue,  7 Aug 2012
 21:43:07 -0400 (EDT)
In-Reply-To: <5021B20D.2030702@palm.com> (Rich Pixley's message of "Tue, 07
 Aug 2012 17:25:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6786F88C-E0FA-11E1-A964-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203060>

Rich Pixley <rich.pixley@palm.com> writes:

> I'm confused.
>
> What is the intended work flow here?  Ie, aside from trashing my
> repository and starting over, what does one do to recover?
>
> rich@cobra> git clone /home/rich/repos/webos webos
> Cloning into 'webos'...
> done.
> rich@cobra> cd webos
> rich@cobra> git remote add central git@github.com:openwebos/webos.git
> rich@cobra> git co master
> Already on 'master'
> rich@cobra> git pull central master
> X11 forwarding request failed on channel 0
> remote: Counting objects: 22, done.
> remote: Compressing objects: 100% (19/19), done.
> remote: Total 21 (delta 12), reused 11 (delta 2)
> Unpacking objects: 100% (21/21), done.
> From github.com:openwebos/webos
>  * branch            master     -> FETCH_HEAD
> warning: Failed to merge submodule meta-webos (not checked out)
> Auto-merging meta-webos
> CONFLICT (submodule): Merge conflict in meta-webos
> Auto-merging README.md
> Automatic merge failed; fix conflicts and then commit the result.
> rich@cobra> git commit -a

Why isn't there any "fix conflicts and then" step between this line
and the friendly insn message on the previous line?

> error: unable to index file meta-webos
> fatal: updating files failed
> rich@cobra> git add meta-webos
> error: unable to index file meta-webos
> fatal: updating files failed
> rich@cobra> git rm meta-webos
> meta-webos: needs merge
> rm 'meta-webos'
> fatal: git rm: 'meta-webos': Is a directory
> rich@cobra> git merge meta-webos
> error: 'merge' is not possible because you have unmerged files.
> hint: Fix them up in the work tree,
> hint: and then use 'git add/rm <file>' as
> hint: appropriate to mark resolution and make a commit,
> hint: or use 'git commit -a'.
> fatal: Exiting because of an unresolved conflict.

If you are not interested in mucking with meta-webos with this
merge, you would resolve meta-webos by taking either your (i.e. the
one that came from /home/rich/repos/webos) version or their
(i.e. the one that came from openwebos/webos.git) version.  Go back
to the state before "git pull central master" with "reset --hard",
init and update webos submodule, try the "pull" again and then "git
add webos" to resolve to your version, perhaps?
