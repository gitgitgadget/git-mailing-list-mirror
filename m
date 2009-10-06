From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Teach 'rebase -i' the command "reword"
Date: Tue, 06 Oct 2009 09:23:41 +0200
Message-ID: <4ACAF07D.2030604@viscovery.net>
References: <4ACA1BD1.6050905@gmail.com> <4ACAACAB.3020707@gmail.com> <4ACAEBBA.9000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 09:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv4QY-0007Jd-4E
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 09:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbZJFHYi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2009 03:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755454AbZJFHYi
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 03:24:38 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44128 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbZJFHYi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2009 03:24:38 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mv4Ob-00045M-Lf; Tue, 06 Oct 2009 09:23:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5B1E24E4; Tue,  6 Oct 2009 09:23:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4ACAEBBA.9000806@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129608>

Bj=F6rn Gustavsson schrieb:
> @@ -368,17 +368,17 @@ By replacing the command "pick" with the comman=
d "edit", you can tell
>  the files and/or the commit message, amend the commit, and continue
>  rebasing.
> =20
> -If you just want to edit the commit message for a commit, you can re=
place
> -the command "pick" with the command "reword".
> +If you just want to edit the commit message for a commit, replace th=
e
> +command "pick" with the command "reword".
> =20
>  If you want to fold two or more commits into one, replace the comman=
d
>  "pick" with "squash" for the second and subsequent commit.  If the
>  commits had different authors, it will attribute the squashed commit=
 to
>  the author of the first commit.
> =20
> -In both cases, or when a "pick" does not succeed (because of merge
> -errors), the loop will stop to let you fix things, and you can conti=
nue
> -the loop with `git rebase --continue`.
> +When "pick" has been replaced with "edit" or when a "pick" does not
> +succeed (because of merge errors), the loop will stop to let you fix
> +things, and you can continue the loop with `git rebase --continue`.

Since "reword" is "pick" + editor, it can fail due to conflicts as well=
=2E
Perhaps:

'git-rebase' will stop after an edit command or when a command failed
(due to merge errors). When you are done with your edits or with resolv=
ing
merge conflicts, continue with `git rebase --continue`.

(I'm unsure about the mark-up.)

-- Hannes
