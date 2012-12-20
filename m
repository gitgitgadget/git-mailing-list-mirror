From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] Documentation/git-clean: Document --force --force
Date: Thu, 20 Dec 2012 15:37:27 -0800
Message-ID: <335802a0-38b5-4cbc-9e52-92c92083119e@VA3EHSMHS005.ehs.local>
References: <b48ad5f0-25f7-45c3-b2dc-c0c01645a247@CO9EHSMHS031.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:37:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlpgW-0005Sk-Km
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 00:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab2LTXhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 18:37:35 -0500
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:48956
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745Ab2LTXhe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2012 18:37:34 -0500
Received: from mail160-va3-R.bigfish.com (10.7.14.243) by
 VA3EHSOBE005.bigfish.com (10.7.40.25) with Microsoft SMTP Server id
 14.1.225.23; Thu, 20 Dec 2012 23:37:33 +0000
Received: from mail160-va3 (localhost [127.0.0.1])	by
 mail160-va3-R.bigfish.com (Postfix) with ESMTP id 1EAE6A01C6;	Thu, 20 Dec
 2012 23:37:33 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: -1
X-BigFish: VPS-1(zz98dI1432Izz1de0h1202h1e76h1d1ah1d2ahzz17326ah8275bh8275dhz2fh95h668h839h93fhd24hf0ah119dh1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h906i1155h)
Received-SPF: pass (mail160-va3: domain of xilinx.com designates 149.199.60.83 as permitted sender) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail160-va3 (localhost.localdomain [127.0.0.1]) by mail160-va3
 (MessageSwitch) id 1356046650131767_26581; Thu, 20 Dec 2012 23:37:30 +0000
 (UTC)
Received: from VA3EHSMHS005.bigfish.com (unknown [10.7.14.245])	by
 mail160-va3.bigfish.com (Postfix) with ESMTP id 1C520260066;	Thu, 20 Dec 2012
 23:37:30 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by VA3EHSMHS005.bigfish.com
 (10.7.99.15) with Microsoft SMTP Server id 14.1.225.23; Thu, 20 Dec 2012
 23:37:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1Tlpg8-00059B-BR; Thu, 20 Dec 2012 15:37:28
 -0800
Content-Disposition: inline
In-Reply-To: <b48ad5f0-25f7-45c3-b2dc-c0c01645a247@CO9EHSMHS031.ehs.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211937>

Ping?

On Thu, Dec 13, 2012 at 05:46:55PM -0800, Soren Brinkmann wrote:
> This patch documents the behavior of 'git clean' when
> encountering nested git repositories.
> Such repositories are only deleted if '-f' is passed twice
> to 'git clean'.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  Documentation/git-clean.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 9f42c0d..0b31454 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -23,6 +23,9 @@ example, be useful to remove all build products.
>  If any optional `<path>...` arguments are given, only those paths
>  are affected.
>  
> +Nested git repositories are not removed unless the '-f' option is
> +passed to 'git clean' twice.
> +
>  OPTIONS
>  -------
>  -d::
> @@ -35,6 +38,8 @@ OPTIONS
>  --force::
>  	If the git configuration variable clean.requireForce is not set
>  	to false, 'git clean' will refuse to run unless given -f or -n.
> +	Pass this option twice to 'git clean' in order to also remove
> +	nested git repositories.
>  
>  -n::
>  --dry-run::
> -- 
> 1.8.0.2
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
