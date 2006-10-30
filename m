X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Bash snippet to show branch and patch in bash prompt
Date: Mon, 30 Oct 2006 10:46:32 +0000
Message-ID: <tnxhcxm2i9j.fsf@arm.com>
References: <20061030104225.11875.57076.stgit@lathund.dewire.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 10:50:10 +0000 (UTC)
Cc: Eran Tromer <git2eran@tromer.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030104225.11875.57076.stgit@lathund.dewire.com> (Robin
 Rosenberg's message of "Mon, 30 Oct 2006 11:42:25 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 30 Oct 2006 10:46:34.0482 (UTC) FILETIME=[AAF9ED20:01C6FC10]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30495>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeUhs-0000i7-Et for gcvg-git@gmane.org; Mon, 30 Oct
 2006 11:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965517AbWJ3Kr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 05:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965508AbWJ3KrW
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 05:47:22 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:59895 "EHLO
 cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP id
 S965504AbWJ3Kqn (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006
 05:46:43 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k9UAkYQb010152;
 Mon, 30 Oct 2006 10:46:34 GMT
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Mon, 30 Oct 2006
 10:46:34 +0000
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>
>  contrib/stgbashprompt.sh |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/stgbashprompt.sh b/contrib/stgbashprompt.sh
> new file mode 100755
> index 0000000..792da53
> --- /dev/null
> +++ b/contrib/stgbashprompt.sh
> @@ -0,0 +1,16 @@
> +# include this in your bashrc or copy to /etc/bash_completions.d
> +
> +if [ "$PS1" ]; then
> +    # trap 'PS1="\u@\h [$(stg top)] \w]\$ "' DEBUG
> +    function stgtag
> +    {
> +	br=$(stg branch 2>/dev/null)
> +	top=$(stg top 2>/dev/null)
> +	if [[ -n "$br$top" ]];then
> +	    echo "[$top@$br]"
> +	    return
> +	fi
> +    }
> +    PS1='\u@\h$(stgtag)\w\$ '
> +
> +fi

Isn't this the same patch? "stg refresh" :-)?

-- 
Catalin

P.S. could you please send them to my catalin.marinas@gmail.com
