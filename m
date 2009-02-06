From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git notes show: test empty notes
Date: Fri, 6 Feb 2009 16:36:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902061635560.7377@intel-tinevez-2-302>
References: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net> <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSmT-0000A2-1Z
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbZBFPgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbZBFPgS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:36:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:42237 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752721AbZBFPgS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:36:18 -0500
Received: (qmail invoked by alias); 06 Feb 2009 15:36:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp053) with SMTP; 06 Feb 2009 16:36:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BqUQ72oxBpTi6mGYnyWPygIaAj6bBX+lTnTfHea
	GuAO9XtirAGoPM
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1233933543-28407-2-git-send-email-git@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108736>

Hi,

On Fri, 6 Feb 2009, Michael J Gruber wrote:

> Add a test for the handling of empty notes by "git notes show".
> ---
>  t/t3301-notes.sh |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 9393a25..4900dca 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -35,6 +35,11 @@ test_expect_success 'need valid notes ref' '
>  	! MSG=2 GIT_NOTES_REF='/' git notes show
>  '
>  
> +# 1 indicates caught gracefully by die, 128 means git-show barfed
> +test_expect_failure 'handle empty notes gracefully' '
> +	git notes show || test 1 = $?
> +'

That test would succeed if the exit status is 0.

Ciao,
Dscho
