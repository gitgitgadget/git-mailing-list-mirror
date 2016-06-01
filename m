From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 1/2] completion: create variable for untracked file
 modes
Date: Wed, 01 Jun 2016 13:59:38 +0200
Message-ID: <20160601135938.Horde.2Daxezldve72SBukDSPenPP@webmail.informatik.kit.edu>
References: <20160601040542.GA18978@sigill.intra.peff.net>
 <1464773846.4315.0.camel@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 13:59:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b84oP-0006vp-Qu
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 13:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbcFAL7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 07:59:45 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34209 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750716AbcFAL7p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 07:59:45 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1b84oH-0002JE-N0; Wed, 01 Jun 2016 13:59:42 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1b84oE-0005P0-6w; Wed, 01 Jun 2016 13:59:38 +0200
Received: from x590c39c4.dyn.telefonica.de (x590c39c4.dyn.telefonica.de
 [89.12.57.196]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 01 Jun 2016 13:59:38 +0200
In-Reply-To: <1464773846.4315.0.camel@virtuell-zuhause.de>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1464782382.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296080>


This subject would perhaps read better:

   completion: factor out untracked file modes into a variable


Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  contrib/completion/git-completion.bash | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash  
> b/contrib/completion/git-completion.bash
> index 3402475..addea89 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1098,6 +1098,8 @@ _git_clone ()
>  	esac
>  }
>
> +__git_untracked_file_modes="all no normal"
> +
>  _git_commit ()
>  {
>  	case "$prev" in
> @@ -1119,7 +1121,7 @@ _git_commit ()
>  		return
>  		;;
>  	--untracked-files=*)
> -		__gitcomp "all no normal" "" "${cur##--untracked-files=}"
> +		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
>  		return
>  		;;
>  	--*)
