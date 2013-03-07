From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: Clarify documentation of -A and -u
Date: Thu, 07 Mar 2013 09:52:06 -0800
Message-ID: <7vsj47m721.fsf@alter.siamese.dyndns.org>
References: <20130306072610.GB15534@biohazard-cafe.mit.edu>
 <7vhakoqwri.fsf@alter.siamese.dyndns.org>
 <20130307101314.GP22203@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Mar 07 18:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDezd-0000N5-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 18:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453Ab3CGRwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 12:52:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3CGRwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 12:52:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A995AB811;
	Thu,  7 Mar 2013 12:52:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p734R4Ax1f53WbRS8z6FuRNDilo=; b=g1Fkvb
	a0u95e2kiOLpUQ29eUsavj1zmtq8sdBswJIxrQafYS/KLqqi8MgMCgeydHNG6RB6
	EgW2fp1vez1szuRiw+Bm9t74ZlhYfsmpNxU8rSer5t6g8AQShlBb2O1K3QkXz8jU
	cs7uyQa07A71ITJ7emnQM/29+T5JCJElvjlzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nqcXgvGsS23mJm1EJQ7ijHeSa+lKZ3dO
	p8JT0xOdKDEBmCGfKkPHSLiq18SLRZTN5NxAxx3pcurtIK25W8oRpSJKR8cCpLlH
	26fl6M4Y3+ZIawUuJRBupvT7EmU8FfyrZkKNXmCClud6RozKxmA4EKfEvtY7sPAq
	WzuyKZnYlyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E764B80F;
	Thu,  7 Mar 2013 12:52:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0DE8B80A; Thu,  7 Mar 2013
 12:52:07 -0500 (EST)
In-Reply-To: <20130307101314.GP22203@biohazard-cafe.mit.edu> (Greg Price's
 message of "Thu, 7 Mar 2013 05:13:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAB765B8-874F-11E2-948B-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217603>

Greg Price <price@MIT.EDU> writes:

> On Wed, Mar 06, 2013 at 09:10:57AM -0800, Junio C Hamano wrote:
>> I do not know if mentioning what -A does in the description for -u
>> (and vice versa) makes it easier to understand or more confusing
>> (not rhetorical: I suspect some may find it easier and others not).
>> 
>> But "and the default behaviour will..." here _is_ confusing.  After
>> reading this patch three times, I still cannot tell what "default"
>> you are trying to describe.  Is it "-u" without arguments?  Is it
>> "add" without "-u" nor "-A"?  Is it something else???
>
> I meant the behavior without -A or -u.  This could be fixed directly
> by s/the default behavior will/with neither -A nor -u we/.

When we have bulletted list that enumerates options and describes
what each option does and how each option affects the behaviour, I'd
prefer to see us *not* talking about what happens when you do *not*
give that option, unless it makes it hard to understand that option
without such an extra description.  The overall description of what
the command does without the options should go to the top level.

> Here's a crack at making those distinctions clear.  I've also tried to
> make the descriptions as parallel as possible, as what they're saying
> is very similar.
>
> -u::
> --update::
> 	Update the index just where it already has an entry matching
> 	<pathspec>.

Good; this was the short phrasing I was looking for but couldn't
come up with myself without repeating "the index" over and over.

> Then follow both with the "If no <pathspec>" paragraph.  I just
> noticed that the paragraph actually needs a small modification to fit
> '-A', too.  New patch below.
>
> Greg
>
> From: Greg Price <price@mit.edu>
> Date: Thu, 7 Mar 2013 02:08:21 -0800
> Subject: [PATCH] add: Clarify documentation of -A and -u

(for future reference) Drop the three lines and have "-- >8 --" here.

[patch kept unsnipped for others']

> The documentation of '-A' and '-u' is very confusing for someone who
> doesn't already know what they do.  Describe them with fewer words and
> clearer parallelism to each other and to the behavior of plain 'add'.
>
> Also mention the default <pathspec> for '-A' as well as '-u', because
> it applies to both.
>
> Signed-off-by: Greg Price <price@mit.edu>
> ---
>  Documentation/git-add.txt | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 388a225..b0944e5 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -100,12 +100,9 @@ apply to the index. See EDITING PATCHES below.
>  
>  -u::
>  --update::
> -	Only match <pathspec> against already tracked files in
> -	the index rather than the working tree. That means that it
> -	will never stage new files, but that it will stage modified
> -	new contents of tracked files and that it will remove files
> -	from the index if the corresponding files in the working tree
> -	have been removed.
> +	Update the index just where it already has an entry matching
> +	<pathspec>.  This removes as well as modifies index entries to
> +	match the working tree, but adds no new files.
>  +
>  If no <pathspec> is given, the current version of Git defaults to
>  "."; in other words, update all tracked files in the current directory
> @@ -114,10 +111,15 @@ of Git, hence the form without <pathspec> should not be used.
>  
>  -A::
>  --all::
> -	Like `-u`, but match <pathspec> against files in the
> -	working tree in addition to the index. That means that it
> -	will find new files as well as staging modified content and
> -	removing files that are no longer in the working tree.
> +	Update the index not only where the working tree has a file
> +	matching <pathspec> but also where the index already has an
> +	entry.	This adds, modifies, and removes index entries to
> +	match the working tree.
> ++
> +If no <pathspec> is given, the current version of Git defaults to
> +"."; in other words, update all files in the current directory
> +and its subdirectories. This default will change in a future version
> +of Git, hence the form without <pathspec> should not be used.
>  
>  -N::
>  --intent-to-add::
