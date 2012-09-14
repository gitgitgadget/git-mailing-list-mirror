From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's the point of saying "HEAD is now at ..."?
Date: Fri, 14 Sep 2012 12:48:49 +0200
Message-ID: <50530B91.1030808@drmicha.warpmail.net>
References: <7vvcfh6v9m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 12:49:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCTSG-0002Ew-VB
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 12:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab2INKsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 06:48:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33959 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750737Ab2INKsv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 06:48:51 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E785A20716;
	Fri, 14 Sep 2012 06:48:50 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 14 Sep 2012 06:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=hBS+Zs6C8sC7Q+rzHraidZ
	IhJdg=; b=JOIlCEKWaxF3wCVDGzPzjMNGpcHz6sqIbxeiuvQhA6pL1u49NrvG1w
	4fu8UmGc2/VOivdHyVPeFM1kZkVHvQC4smwKE/dIOiHUF+AACSwl2mWespoDqfoI
	haDQNlW2fBrOXqThYk7oPr+yaZgHqLQNJDjl75u7evO2WnSVauO/I=
X-Sasl-enc: wME1+KaudZ2U+HFTotqc1wLqMFiWRJ0cJRUi7xElW+7L 1347619730
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6AF054837F6;
	Fri, 14 Sep 2012 06:48:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vvcfh6v9m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205480>

Junio C Hamano venit, vidit, dixit 14.09.2012 07:14:
> I sometimes wonder what value the message is giving us.
> 
> For example, while reviewing a patch in my Emacs session, I may say
> 
>     | git am -s3c <RETURN>
> 
> which runs the command on the contents of the e-mail I am reading,
> to apply the patch.  After that, I would go to a separate terminal
> and do things like "git show -U20", etc.  Once I am done, I reset
> the temporary commit away, and get this:
> 
>     $ git reset --hard HEAD^
>     HEAD is now at ce5cf6f Merge git://github.com/git-l10n/git-po
> 
> or often it is
> 
>     $ git reset --hard ko/master
>     HEAD is now at ce5cf6f Merge git://github.com/git-l10n/git-po
> 
> In either case, I know where I am resetting to, so "HEAD is now at"
> is a less than useful noise.  If it contained "HEAD was at ...", it
> may let me realize that I was still going to use the contents in
> some other way and quickly go back to it with another reset, with
> cut and paste or with HEAD@{1}.  In either case, showing the tip of
> what I just discarded seems to be a lot more useful information than
> what we are currently giving the users.
> 

Unless you use a git aware prompt, it's always good to know where your
HEAD is ;) Just think of:

git reset --hard HEAD^2
HEAD is now at ...

Oh, I meant HEAD~2 aka HEAD^^ ...

In that case, information about HEAD@{1} might be useful but is not
necessary, unless you are leaving behind a detached HEAD.

Cheers,
Michael
