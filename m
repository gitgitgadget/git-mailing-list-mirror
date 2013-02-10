From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/15] user-manual: Use 'git config --global user.*'
 for setup
Date: Sun, 10 Feb 2013 14:12:05 -0800
Message-ID: <7vip5zstsa.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <b363f5b410098302a02af2d79b5b68ee79210be2.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:12:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4f8a-0006Cl-78
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab3BJWMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:12:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756603Ab3BJWMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:12:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91955CD2E;
	Sun, 10 Feb 2013 17:12:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kv892mQWMcR1bqosLYsK+9g1lHs=; b=Y8/zoe
	zV/OSMvW2baU1FHYbH0JIYofLtacTmLKsh5fTsWLl5k3B5eB2oyJ6z1wqWfPL/Mr
	skCbnq7TXkjaTrmb32poDrdTrs3zybHBozbhoWOz18q2Uv+evFZefpLJSyvD8lX+
	Z1CHKauymzn0s5vLznipbgFhLEE3uYlqENyRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgyX03GJy/xZ58REiYsUww+Lb984QYMm
	JTURf6iVwK91xq8aQFP2zQrvRfrNE1zXdRQNez1ozsvEdhqats4fHffNRMN3Ecx2
	CXFJ2TwgIJTi2hQHpWmtGRM7LnQvGKbOD+KeLBCuG4OkKstQ93NYwZODsz/jG0hF
	RV5xMyoJT4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 372BFCD24;
	Sun, 10 Feb 2013 17:12:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8179CD0F; Sun, 10 Feb 2013
 17:12:13 -0500 (EST)
In-Reply-To: <b363f5b410098302a02af2d79b5b68ee79210be2.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC7A83F8-73CE-11E2-B01F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215950>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> A simple command line call is easier than spawning an editor,
> especially for folks new to ideas like the "command line" and "text
> editors".  This is also the approach suggested by 'git commit' if you
> try and commit without having configured user.name or user.email.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 8bf37b3..e2e0c86 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -991,9 +991,16 @@ Developing with Git
>  Telling Git your name
>  ---------------------
>  
> -Before creating any commits, you should introduce yourself to Git.  The
> -easiest way to do so is to make sure the following lines appear in a
> -file named `.gitconfig` in your home directory:
> +Before creating any commits, you should introduce yourself to Git.
> +The easiest way to do so is to use linkgit:git-config[1]:
> +
> +------------------------------------------------
> +$ git config --global user.name 'Your Name Comes Here'
> +$ git config --global user.email 'you@yourdomain.example.com'
> +------------------------------------------------
> +
> +Which will add the following stanza to a file named `.gitconfig` in
> +your home directory:

Looks good, even though I do not think we would want/need to confuse
the readers with an unfamiliar word "stanza".

> @@ -1001,8 +1008,9 @@ file named `.gitconfig` in your home directory:
>  	email = you@yourdomain.example.com
>  ------------------------------------------------
>  
> -(See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
> -details on the configuration file.)
> +See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
> +details on the configuration file.  The file is plain text, so you can
> +also edit it with your favorite editor.
>  
>  
>  [[creating-a-new-repository]]
