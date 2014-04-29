From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document RUN_SETUP_GENTLY
Date: Tue, 29 Apr 2014 11:25:36 -0700
Message-ID: <xmqq1twgkn6n.fsf@gitster.dls.corp.google.com>
References: <CAE+yK_nZ0tVbqvH00vqaAL2mUz4s6CQS5kCfGsayv-40b0yejQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfCiw-0007vD-76
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 20:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933757AbaD2SZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 14:25:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932491AbaD2SZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 14:25:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1BD7FC78;
	Tue, 29 Apr 2014 14:25:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+0Cz0o2XVPRos8zjPm8i+TrDT4Q=; b=wrxX/c
	Nf6prSuq4HEfu01RgpkI4DmpD0QX19+9KCA2JxbO/gk0Z7NFghQAKAHR6sbpkX85
	ls6Q7mFNQDTUgT24i5a8s+5fcOKce+fKAjEQQeU7xTDSYFPbl1rE8Ivs+AozTDHJ
	IRcc20VLNg8XlYFjRteJpS+/9aYZmVLFB60Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ca/S4XCS9GMiPTeo4blbToFycREVtC0e
	DyyVtcijEmIS18UVmjUa/KgZdjmZ8no9/AA4dozrGIOnTK+Hcf/+do/DimGy3Bpf
	fbsViHuUZE1eEHZvT1O672a7lS1nXjDz4w1cWNSd+DCbdJ7lxAnS9hSNHLQj6Umw
	Wdpfuzv2vSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B32C87FC77;
	Tue, 29 Apr 2014 14:25:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A64197FC76;
	Tue, 29 Apr 2014 14:25:37 -0400 (EDT)
In-Reply-To: <CAE+yK_nZ0tVbqvH00vqaAL2mUz4s6CQS5kCfGsayv-40b0yejQ@mail.gmail.com>
	(David Turner's message of "Tue, 29 Apr 2014 01:04:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A94E1F18-CFCB-11E3-96AA-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247599>

David Turner <dturner@twopensource.com> writes:

> Document RUN_SETUP_GENTLY
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  Documentation/technical/api-builtin.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/technical/api-builtin.txt
> b/Documentation/technical/api-builtin.txt
> index e3d6e7a..1bbeda2 100644
> --- a/Documentation/technical/api-builtin.txt
> +++ b/Documentation/technical/api-builtin.txt
> @@ -28,6 +28,11 @@ where options is the bitwise-or of:
>   in a subdirectory.  If there is no work tree, no chdir() is
>   done.
>
> +`RUN_SETUP_GENTLY`::
> +
> + If there is a Git directory, chdir as per RUN_SETUP, otherwise,
> + don't create one and don't chdir.

I can understand "don't chdir" part, but where does "don't create"
come from?  Makes it sound as if non GENTLY version would create one
if there isn't there, but I am guessing that that is not what you
meant to say.

Puzzled.
