From: Junio C Hamano <gitster@pobox.com>
Subject: Re: repo.or.cz being not well???
Date: Mon, 01 Jul 2013 15:21:39 -0700
Message-ID: <7va9m5apl8.fsf@alter.siamese.dyndns.org>
References: <7vli5q9ba2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 00:21:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmTi-0004js-1h
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab3GAWVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:21:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720Ab3GAWVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:21:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F08E12D835;
	Mon,  1 Jul 2013 22:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xsPITVPO6y9JHraN1MLLaRzNOX4=; b=L3DMlf
	rRrl9w3aWclotMrfvOT7onR8hE8S0jigKj6BXAbuIrOOCoL/xBG0QFAd0XQOIhqi
	XzA6DE2wnG8ncY8ErRBL0N+83towpgQrIKwXHdxworHqq7zWnQVYRtG8785gDsGr
	ARXQoKS5khE4ozI2pnvGooqIUFbQ6Gq4pbxpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U4cg5xpOFy/mUkQlItyw6dh0xBGnRIzL
	nSKpBgZv9fOzMpUaUcutJCQRXaPg/IHExejfEGaj6QV9q7zUJtufVB0LbNJvWfa9
	yHv2+Ez4qojMmOCjkZvxVkD0PlpqCLxJp7PgbDe+ehntxa66g/GwrYFOc7903sQt
	tVwnxixkJvw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E65422D834;
	Mon,  1 Jul 2013 22:21:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 699EF2D833;
	Mon,  1 Jul 2013 22:21:40 +0000 (UTC)
In-Reply-To: <7vli5q9ba2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 01 Jul 2013 15:16:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A34698C-E29C-11E2-A7BA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229342>

Junio C Hamano <gitster@pobox.com> writes:

> Has something changed recently at repo.or.cz, accepting pushes over
> ssh, in the past few days?  I am getting this:
>
>     $ git push -n -v repo.or.cz:srv/git/alt-git.git/
>     403 forbidden
>     fatal: Could not read from remote repository.
>
>     Please make sure you have the correct access rights
>     and the repository exists.

Nevermind, I figured it out.

	$ git push repo.or.cz:/srv/git/alt-git.git

seems to be the new way to spell the scp style push.

Two points to note, just in case it would help other users, are

 (1) The repository hierarchy is no longer under your initial
     directory and you have to explicitly ask for /srv/$path; and

 (2) You used to be able to, but no longer are allowed, to have a
     trailing slash in your repository URL.
