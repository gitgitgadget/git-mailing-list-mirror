From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: clarify notes for clean.requireForce
Date: Tue, 27 Aug 2013 09:31:53 -0700
Message-ID: <xmqqd2ozdrie.fsf@gitster.dls.corp.google.com>
References: <07b4019b473c2e6d46e75b5ae5ce3f431e4e74d0.1377612590.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 18:32:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEMBV-0007Bi-Cf
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 18:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab3H0Qb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 12:31:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310Ab3H0Qb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 12:31:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 326843C5F7;
	Tue, 27 Aug 2013 16:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zbdBDCWXQFiOCZhXFhmmKcf9/lg=; b=KDM0iD
	VUTliETOyshokeYOA52nxtVOMnhgynZtu+h6W4hkt2+2zBMIBZsJwibUkjvEGAcg
	fnMacLHMP/fXb6g3PEKWcz6GcInSzsNSEydb97k14PC8LZPJ2kOOSECwAeObTBxn
	ur+9lUMeZT/7ynr/7bko235a/I+fhmbixkg1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j4Uev89egIbMYbfNkcQs/aBAYN+vc/KP
	fLh0ghKD4huNkpoXxN99Swu6qf4wVUu67DkuBU8ptB48D2xmyr1Kg5sDo9Fwx5kt
	/pL/Y3XSCnFxLZkRArHInMQociIRg3yjit4NYwYwcHkoh7l3JSiQbMMSU3ZZ1DDE
	auajrtIBmIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B2B3C5F6;
	Tue, 27 Aug 2013 16:31:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F0F33C5F4;
	Tue, 27 Aug 2013 16:31:55 +0000 (UTC)
In-Reply-To: <07b4019b473c2e6d46e75b5ae5ce3f431e4e74d0.1377612590.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Tue, 27 Aug 2013 22:11:29 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F9C5CF8-0F36-11E3-811D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233111>

Jiang Xin <worldhello.net@gmail.com> writes:

> Add "-i" (interactive clean option) to clarify the documentation for
> "clean.requireForce" config variable. Also replace the example in
> `gitcli.txt` with safer git clean command.

Hmm, the former change may make sense, but I am not sure about the
latter.  The section is about showing examples of concatenating
command line options, and I find it far more appropriate to use
"clean -f", which is a lot more widely known than "clean -i", for
the intended audience, those who are learning how to compose the
command line options.

> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  Documentation/config.txt | 4 ++--
>  Documentation/gitcli.txt | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8361380..547149d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -795,8 +795,8 @@ browser.<tool>.path::
>  	working repository in gitweb (see linkgit:git-instaweb[1]).
>  
>  clean.requireForce::
> -	A boolean to make git-clean do nothing unless given -f
> -	or -n.   Defaults to true.
> +	A boolean to make git-clean do nothing unless given -i,
> +	-f or -n.   Defaults to true.
>  
>  color.branch::
>  	A boolean to enable/disable color in the output of
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 9ac5088..4005a3b 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -135,7 +135,7 @@ Aggregating short options
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
>  Commands that support the enhanced option parser allow you to aggregate short
>  options. This means that you can for example use `git rm -rf` or
> -`git clean -fdx`.
> +`git clean -idx`.
>  
>  
>  Abbreviating long options
