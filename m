From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] Documentation: git-init: --separate-git-dir: clarify
Date: Tue, 05 Aug 2014 15:12:21 -0700
Message-ID: <xmqqiom6oabe.fsf@gitster.dls.corp.google.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
	<1407002817-29221-5-git-send-email-linusarver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Arver <linusarver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:12:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEmyA-0005oY-LY
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 00:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbaHEWMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 18:12:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58983 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbaHEWMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 18:12:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 171952EDFE;
	Tue,  5 Aug 2014 18:12:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HOgZDluAaPINq4v6MQfitgf0ZJ8=; b=UeY+X5
	msDkm9AHejELovlEc/Ecp4D7FvZCHw5VBq4niUbIsN0kKTast355sPkpzXfG0PM9
	1gRhswxag8GMCRkaehlao0UT4nDRf10HZoqAKkswIlPAd5Po4CUhxoH53z2DWsdA
	oMp4e3LrGPormX3TwqXvuIomKGNGU1hAgzz+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pN1UMDpZZD5WnU2dMSgZCWjqfZ8gYREp
	jhMAPVrnDt+rOm+vSVtC+Is89I6aNWdp4dtJ75T5BPMSAiqGlhn5LNdcw0qYN3nH
	KwF7opTVJHY9ikp//svSn3MY+MTYTKY7jMkXI6IobUlQKlciINowv8xHKYgxBMiT
	puSS9aGfeCs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0DFE12EDFD;
	Tue,  5 Aug 2014 18:12:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 411922EDF7;
	Tue,  5 Aug 2014 18:12:23 -0400 (EDT)
In-Reply-To: <1407002817-29221-5-git-send-email-linusarver@gmail.com> (Linus
	Arver's message of "Sat, 2 Aug 2014 11:06:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9357780C-1CED-11E4-BF5D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254834>

Linus Arver <linusarver@gmail.com> writes:

> Signed-off-by: Linus Arver <linusarver@gmail.com>
> ---

You would need to work on your justification skills ;-) in the log
message.  What does this change "clarify" and in what way?

>  Documentation/git-init.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index f21b85b..bf0a7ae 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -57,12 +57,12 @@ DIRECTORY" section below.)
>  
>  --separate-git-dir=<git dir>::
>  
> -Instead of initializing the repository where it is supposed to be,
> -place a filesytem-agnostic Git symbolic link there, pointing to the
> -specified path, and initialize a Git repository at the path. The
> -result is Git repository can be separated from working tree. If this
> -is reinitialization, the repository will be moved to the specified
> -path.
> +Separate the Git repository from your working tree.  Instead of initializing the
> +repository as a directory to either `$GIT_DIR` or `./.git/`, create a text file
> +there containing the path to the actual repository.  This file acts as
> +filesystem-agnostic Git symbolic link to the repository.
> ++
> +If this is reinitialization, the repository will be moved to the specified path.
>  
>  --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
