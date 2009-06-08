From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] bash: add support for 'git stash pop --index' option
Date: Mon, 08 Jun 2009 11:42:15 -0500
Message-ID: <g-qSjt6xP9cc8knb-2r7SsV783h1R4c8UDJrPsaIHkYcoFwgq_Dt_Q@cipher.nrlssc.navy.mil>
References: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de> <3456b3a568969b2e0451cdc7a9beebfeb5763039.1244475542.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDhvp-0001xE-8j
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 18:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbZFHQmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 12:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbZFHQmU
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 12:42:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40735 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbZFHQmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 12:42:20 -0400
Received: by mail.nrlssc.navy.mil id n58GgFNr024956; Mon, 8 Jun 2009 11:42:15 -0500
In-Reply-To: <3456b3a568969b2e0451cdc7a9beebfeb5763039.1244475542.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 08 Jun 2009 16:42:15.0675 (UTC) FILETIME=[14938CB0:01C9E858]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121086>

SZEDER G=C3=A1bor wrote:
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  contrib/completion/git-completion.bash |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index fa899eb..480d85e 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1887,7 +1887,10 @@ _git_stash ()
>  		apply,--*)
>  			__gitcomp "--index"
>  			;;
> -		show,--*|drop,--*|pop,--*|branch,--*)
> +		pop,--*)
> +			__gitcomp "--index"
> +			;;
> +		show,--*|drop,--*|branch,--*)
>  			COMPREPLY=3D()
>  			;;
>  		show,*|apply,*|drop,*|pop,*|branch,*)

pop takes the same options as apply, so you may want to have just one
case statement for the two options.  Like:

    apply,--*|pop,--*)

-brandon
