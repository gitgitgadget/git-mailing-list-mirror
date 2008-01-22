From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-clone -s: document problems with git gc --prune
Date: Tue, 22 Jan 2008 15:10:10 -0600
Message-ID: <47965BB2.8080703@nrlssc.navy.mil>
References: <20080122210305.GM4475@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 22:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHQZ0-0006Qw-Nd
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 22:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYAVVVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 16:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbYAVVVK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 16:21:10 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34491 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbYAVVVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 16:21:07 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0MLAApt007178;
	Tue, 22 Jan 2008 15:10:10 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 22 Jan 2008 15:10:10 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080122210305.GM4475@genesis.frugalware.org>
X-OriginalArrivalTime: 22 Jan 2008 21:10:10.0851 (UTC) FILETIME=[2C587F30:01C85D3B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15680001
X-TM-AS-Result: : Yes--9.586600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3My03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwOTU4NC03MDM3ODgtNzA3MTE5LTcwNTQ0MS03?=
	=?us-ascii?B?MDMzODUtNzA1MTAyLTcwNDQxMC0xODgwMTktNzA0OTI3LTcwMDA1?=
	=?us-ascii?B?Ny03MDQ0OTYtNzExOTUzLTE4ODE5OC03MDA4NDktNzAyMzU4LTcw?=
	=?us-ascii?B?MTQ1NS03MTE0MzItNzAyMDIwLTcwNjI0OS0xMDY0MjAtNzA2MTUw?=
	=?us-ascii?B?LTcwNjA0OC0xODgxMjEtMTQ4MDM5LTE0ODA1MS0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71470>

Miklos Vajna wrote:
> There is a scenario when using git clone -s and git gc --prune togother is
> dangerous. Document this.
> 
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> I see people on #git regularly who do not know about this option can cause
> problems, so I think it's important to document this.
> 
>  Documentation/git-clone.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index fdccbd4..5c4d936 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -62,6 +62,12 @@ OPTIONS
>  	.git/objects/info/alternates to share the objects
>  	with the source repository.  The resulting repository
>  	starts out without any object of its own.
> +	*NOTE*: this is a possibly dangerous operation; do *not* use
> +	it unless you understand what it does. If you clone your
> +	repository using this option, you delete branches in the
> +	source repository and you run linkgit:git-gc[1] using the
> +	`--prune` option, then it will remove objects which are
> +	referenced ones in the target repository!

I find that second sentence hard to understand. Maybe:

If you clone your repository using this option, then delete branches in
the source repository and then run linkgit:git-gc[1] using the '--prune'
option in the source repository, it may remove objects which are referenced
by the cloned repository.

-brandon
