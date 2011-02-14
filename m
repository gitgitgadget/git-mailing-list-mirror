From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] git-tag.txt: list all modes in the description
Date: Mon, 14 Feb 2011 12:03:06 -0800
Message-ID: <7v8vxis7t1.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <496c871d087c0677ddd3374d432e56c891375025.1297695910.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 21:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4dl-0007AV-CG
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 21:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab1BNUDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 15:03:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1BNUDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 15:03:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E483046A6;
	Mon, 14 Feb 2011 15:04:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P7gxZI2WauImEdU6gSjZ5wfaL8M=; b=AGzurF
	TKWhq3KNJNyXC5r97DRjC4YAmJjCd66anBoNfjsHHrMaQXZoE+xM23XXdEWhH+dm
	VJ5vs7LI8OYHGBcXaFURPmKofjffjKbo7EIWZbiIzTQlo+k8lmOmalE1tNqUXLFH
	DxENz+PzNLZIj/RRkaM6MOir2PPP0anKj6mII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u9H15wrv+1nAiw+QpEVGLBYXCiRx77Pd
	AZXZuUEMK1EOGLmF35SuPxso/q+kDNKNNtBKz0veBxTJHkV1ZptfVps08hKBMz/6
	kMCteYv0WpATi0sV7o8fHrRZ4APpBfB7XqMsFS9vyZxolcsCszsdV2Gvn4DenT0F
	ScvE1Wmnjfk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2E4746A5;
	Mon, 14 Feb 2011 15:04:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D3AF846A3; Mon, 14 Feb 2011
 15:04:13 -0500 (EST)
In-Reply-To: <496c871d087c0677ddd3374d432e56c891375025.1297695910.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 14 Feb 2011 16\:10\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9A0709DE-3875-11E0-8345-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166763>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, the description sounds as if it applied always, but most of
> its content is true in "create tag mode" only.
>
> Make this clearer by listing all modes and qualifying the main part.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Thanks for noticing; I agree with the basic idea.

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 8b169e3..c503f60 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -18,7 +18,7 @@ SYNOPSIS
> ...
> -Adds a tag reference in `.git/refs/tags/`.
> +Without `-d/-l/-v`: Adds a tag reference in `.git/refs/tags/`.

But this leaves the reader in suspense what these three exceptions are for
after finishing the first sentence.  How about rewording like this?

    Add a tag reference in `.git/refs/tags/`, unless `-d/-l/-v` is given
    to delete, list or verify.

Then we don't need to repeat these three

    With `-d`: Deletes a tag.

    With `-l`: List tags.

    With `-v`: Verify tags.

that the readers would see in OPTIONS section fairly soon.
