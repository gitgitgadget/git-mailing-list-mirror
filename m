From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Use $(git rev-parse --show-toplevel) in
 cd_to_toplevel()
Date: Sun, 10 Jan 2010 23:46:15 -0800
Message-ID: <7viqb9w0c8.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1001102016380.2560@vqena.qenxr.bet.am>
 <alpine.LNX.2.00.1001112022190.8842@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Mon Jan 11 08:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUEyr-0003OH-IM
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 08:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab0AKHqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 02:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545Ab0AKHqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 02:46:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0AKHqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 02:46:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6EA8FB17;
	Mon, 11 Jan 2010 02:46:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ik6Oe2qs0C2h+anxLTYbCNSvQyI=; b=KzzSQh
	6oIke3bLt/aDgHFN8J/y2IImvSPx4LUHZ9e5YNIlyY2bTW/fkOlQffS7ecrwi3TG
	F9lPjl5BiqNWLoqANVCDmjLTxy5HucvZpypBGBHF3rYYm4ZryzRV41Sn8Gv+QDNf
	qzWmfVdFNiy/GyDHSjcHuA1fvimb/EIB6VIh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uLekPR9DskxlvpB2XeEWDlufzpbOJkTv
	13kJubj+Q6hIZI7LXj5yrKbnAk0Xw27TFHFMqmCy3fLuaQTfXfqxm8ckrAqiiQhr
	UWb0ZEQKEFUtXqziuTwmSo8fsExAdIFACIllEc2Ns4a4bXmrdvnhsEgdhat9NLg2
	JF+jUO4NjSQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6BBA8FB16;
	Mon, 11 Jan 2010 02:46:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECDAD8FB13; Mon, 11 Jan
 2010 02:46:16 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1001112022190.8842@vqena.qenxr.bet.am> (Steven
 Drake's message of "Mon\, 11 Jan 2010 20\:23\:20 +1300 \(NZDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67FE144E-FE85-11DE-AA77-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136613>

Steven Drake <sdrake@xnet.co.nz> writes:

>  as it gives the absolute (aka "physical") path of the toplevel directory
>  and 'cd -P' is not supported by all shell implementations.
>
> See NetBSD PR/42168.
> http://www.netbsd.org/cgi-bin/query-pr-single.pl?number=42168
> ---
> This is a revision of my original patch after the input from Jonathan.
> ---
>  git-sh-setup.sh |   18 ++++--------------
>  1 files changed, 4 insertions(+), 14 deletions(-)

The patch text may make sense (I haven't thought things through yet) but
please make sure your proposed commit log messages conform to the local
convention.

 (1) We don't chop a sentence in the middle of the subject line and
     continue the same sentence to the first line of the body of the
     message;

 (2) We don't indent the log message by one SP at the beginning of lines;

 (3) Please avoid referring to external resource in the commit log message
     whenever makes sense; the log should be understandable on its own.
     Because the first paragraph of your message describes the issue the
     patch addresses very well already, you don't need "See NetBSD..." and
     URL.  If you want to have them to help the reviewers, place such
     reference after the three-dash line, just like you wrote "This is a
     revision..."  You would help reviewers even more if you added a
     pointer to your earlier patch after that sentence;

 (4) Sign your patch, before the three-dash line.

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index dfcb807..4ecc578 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -120,20 +120,10 @@ is_bare_repository () {
>  }
>  
>  cd_to_toplevel () {
> +	cdup=$(git rev-parse --show-toplevel) && cd "$cdup" || {

Please line-break immediately after &&; it makes it easier to read in
general, and it would make "cd" stand out in this particular case, as it
is the most important part of this particular function.

Thanks.
