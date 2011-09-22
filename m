From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] unpack-trees: print "Aborting" to stderr
Date: Thu, 22 Sep 2011 07:58:37 +0200
Message-ID: <4E7ACE8D.8070001@drmicha.warpmail.net>
References: <4E7996AA.4040909@drmicha.warpmail.net> <8b522de3711f339eea264dd7d8e44682af6c4865.1316590874.git.git@drmicha.warpmail.net> <7v7h511rl9.fsf@alter.siamese.dyndns.org> <7v39fp1pvd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 07:58:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6cJ7-0006CP-An
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 07:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab1IVF6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 01:58:41 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47329 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751650Ab1IVF6k (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2011 01:58:40 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F16D328ABE;
	Thu, 22 Sep 2011 01:58:39 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 22 Sep 2011 01:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=yloMaNr57TrMEUmMQRZe+x
	7r210=; b=pmMrUlFPjGFL1SM132alriIk+9MigFMnj5kWfuFVKUulJfY9BRR1Ok
	urm/47atic0mSlKdMEaDAAdkO0W6VrskQg1uLdfH7u0LK6sMh9Ebn/L1PcGI545I
	mppDRY8JDQjOLTOSsP/QCs37UASAzJbmOhcdS7Qaa5/YzGsiJD4J4=
X-Sasl-enc: OhBcAkh52/YGjmyZVirNhNtSkhBDWc4LH3JhibutGz8s 1316671119
Received: from localhost.localdomain (p54859566.dip0.t-ipconnect.de [84.133.149.102])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 39975980174;
	Thu, 22 Sep 2011 01:58:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <7v39fp1pvd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181886>

Junio C Hamano venit, vidit, dixit 22.09.2011 00:40:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Forgot to update a test or two that this breaks?
> 
> In the meantime I've squashed this in.

Yikes. Sorry and thanks!

> 
>  t/t7607-merge-overwrite.sh     |    1 +
>  t/t7609-merge-co-error-msgs.sh |    5 +++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
> index 72a8731..aa74184 100755
> --- a/t/t7607-merge-overwrite.sh
> +++ b/t/t7607-merge-overwrite.sh
> @@ -107,6 +107,7 @@ error: The following untracked working tree files would be overwritten by merge:
>  	sub
>  	sub2
>  Please move or remove them before you can merge.
> +Aborting
>  EOF
>  
>  test_expect_success 'will not overwrite untracked file in leading path' '
> diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
> index c994836..0e4a682 100755
> --- a/t/t7609-merge-co-error-msgs.sh
> +++ b/t/t7609-merge-co-error-msgs.sh
> @@ -32,6 +32,7 @@ error: The following untracked working tree files would be overwritten by merge:
>  	three
>  	two
>  Please move or remove them before you can merge.
> +Aborting
>  EOF
>  
>  test_expect_success 'untracked files overwritten by merge (fast and non-fast forward)' '
> @@ -56,6 +57,7 @@ Please, commit your changes or stash them before you can merge.
>  error: The following untracked working tree files would be overwritten by merge:
>  	five
>  Please move or remove them before you can merge.
> +Aborting
>  EOF
>  
>  test_expect_success 'untracked files or local changes ovewritten by merge' '
> @@ -71,6 +73,7 @@ error: Your local changes to the following files would be overwritten by checkou
>  	rep/one
>  	rep/two
>  Please, commit your changes or stash them before you can switch branches.
> +Aborting
>  EOF
>  
>  test_expect_success 'cannot switch branches because of local changes' '
> @@ -92,6 +95,7 @@ error: Your local changes to the following files would be overwritten by checkou
>  	rep/one
>  	rep/two
>  Please, commit your changes or stash them before you can switch branches.
> +Aborting
>  EOF
>  
>  test_expect_success 'not uptodate file porcelain checkout error' '
> @@ -105,6 +109,7 @@ error: Updating the following directories would lose untracked files in it:
>  	rep
>  	rep2
>  
> +Aborting
>  EOF
>  
>  test_expect_success 'not_uptodate_dir porcelain checkout error' '
