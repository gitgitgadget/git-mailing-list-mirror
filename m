From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] docs/git-clone: clarify use of --no-hardlinks option
Date: Mon, 10 Feb 2014 16:20:23 -0800
Message-ID: <xmqqmwhyqz3s.fsf@gitster.dls.corp.google.com>
References: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
	<1391892097-16169-3-git-send-email-alash3@bloomberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Albert L. Lash\, IV" <alash3@bloomberg.net>
To: "Albert L. Lash\, IV" <albert.lash@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 01:20:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WD15X-0002HS-82
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 01:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbaBKAU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 19:20:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbaBKAU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 19:20:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DC356BE64;
	Mon, 10 Feb 2014 19:20:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0/YaARNXZijo+q3gkOMALdmR3Fw=; b=gqgkSk
	PpAWkkkr2QTyi5D4ljmdY1xedZVDs7xvN5+5+WfU7gdmCMDQLDqP7/lRHxTQ5fp5
	TY6Z/E0P2ZIjRBNkyas5cvlkDlqW5/LFV/9fW5nOsFdghntn4lZQfMOGxHpJLw5d
	coCQkFA/ntxSWwcunhjxSk01/9BFpd9fUJ5P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FGHsTcyl4M7V23f3I1Zxor7sZCvHXAIz
	S9w4bzU9ZqQXHrimtWbZkY+jBGCd6MpTs7QrkPUGIBFik/xSp9CjDlwlGdKftWud
	6mYQ61HMMavyuEk6MQn0ugeSfwzRqL8zyBLcpmmxoydYM9Z3qOvPllyiGm3//Xs2
	5virhRJdJUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 348BA6BE62;
	Mon, 10 Feb 2014 19:20:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C78DC6BE60;
	Mon, 10 Feb 2014 19:20:25 -0500 (EST)
In-Reply-To: <1391892097-16169-3-git-send-email-alash3@bloomberg.net> (Albert
	L. Lash, IV's message of "Sat, 8 Feb 2014 15:41:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4DCC5142-92B2-11E3-B3DF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241935>

"Albert L. Lash, IV" <albert.lash@gmail.com> writes:

> Current text claims optimization, implying the use of
> hardlinks, when this option ratchets down the level of
> efficiency. This change explains the difference made by
> using this option, namely copying instead of hardlinking,
> and why it may be useful.
>
> Signed-off-by: Albert L. Lash, IV <alash3@bloomberg.net>
> ---
>  Documentation/git-clone.txt | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index bf3dac0..0363d00 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -55,15 +55,12 @@ repository is specified as a URL, then this flag is ignored (and we
>  never use the local optimizations).  Specifying `--no-local` will
>  override the default when `/path/to/repo` is given, using the regular
>  Git transport instead.
> -+
> -To force copying instead of hardlinking (which may be desirable if you
> -are trying to make a back-up of your repository), but still avoid the
> -usual "Git aware" transport mechanism, `--no-hardlinks` can be used.
>  
>  --no-hardlinks::
> -	Optimize the cloning process from a repository on a
> -	local filesystem by copying files under `.git/objects`
> -	directory.
> +	Force the cloning process from a repository on a local
> +	filesystem to copy the files under the `.git/objects`
> +	directory instead of using hardlinks. This may be desirable
> +	if you are trying to make a back-up of your repository.

Makes sense, and it is kind of embarrassing (I have to suspect that
this was originally the description of "--hardlinks" option).

[PATCH {1,2}/4] looked trivially correct, too.

Thanks.
