From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: How does format-patch determine the filename of the patch?
Date: Thu, 15 Oct 2009 19:48:47 +0200
Message-ID: <200910151948.48539.trast@student.ethz.ch>
References: <ed82fe3e0910150917u72ef189epc74411e71a9cd2d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 19:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyUTv-0007TE-Lr
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 19:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbZJORuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 13:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbZJORub
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 13:50:31 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:17476 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbZJORub (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 13:50:31 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 15 Oct
 2009 19:49:43 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 15 Oct
 2009 19:49:22 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <ed82fe3e0910150917u72ef189epc74411e71a9cd2d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130407>

Timur Tabi wrote:
> Hi.  I'm not familiar with the git source code, so forgive me if this
> is a dumb question.  I'm trying to determine the algorithm that
> git-format-patch uses to determine the name of the patch file it
> creates (e.g. "0001-this-is-my-patch-without-spaces-and-trunca.patch")
>  I'm looking at the function cmd_format_patch(), and I just don't see
> where it creates any files.  Can someone show me where this code is?

get_patch_filename() in log-tree.c, but the bulk of the work is done
in the call out to format_commit_message() [pretty.c] with the "%f"
format, which is in turn handled by format_sanitized_subject()
[pretty.c].

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
