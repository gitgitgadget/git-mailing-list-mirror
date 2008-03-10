From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] launch_editor(): allow spaces in the filename
Date: Mon, 10 Mar 2008 22:32:13 +0100
Message-ID: <200803102232.13727.johannes.sixt@telecom.at>
References: <alpine.LSU.1.00.0803102140280.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Zeng.Shixin@gmail.com, theevancarroll@gmail.com,
	git@vger.kernel.org, gitster@poxbox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:33:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYpcB-0008Bs-14
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 22:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbYCJVcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 17:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755185AbYCJVcR
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 17:32:17 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:44385 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbYCJVcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 17:32:17 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id C2139BEECB;
	Mon, 10 Mar 2008 22:32:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8846860998;
	Mon, 10 Mar 2008 22:32:14 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0803102140280.3975@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76756>

On Monday 10 March 2008 21:42, Johannes Schindelin wrote:
> For some reason, the construct
>
> 	sh -c "$0 \"$@\"" <editor> <file>
>
> does not pick up quotes in <editor> as expected.  So replace $0 with
> <editor>.

No surprise. It must be

	sh -c '"$0" "$@"' <editor> <file>

Note the extra quotes around $0.

>  			args[i++] = "sh";
>  			args[i++] = "-c";
> -			args[i++] = "$0 \"$@\"";
> +			args[i++] = arg0.buf;

IOW:

+			args[i++] = "\"$0\" \"$@\"";

-- Hannes
