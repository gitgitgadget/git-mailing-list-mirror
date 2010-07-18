From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Merge commit subjects git.git
Date: Sun, 18 Jul 2010 17:33:59 +0200
Message-ID: <201007181733.59704.trast@student.ethz.ch>
References: <AANLkTikavL0DH8FgFxBw7hbGLtj2tqxnP-BT77zo5FJT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 17:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaVsq-0006QW-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 17:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab0GRPeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 11:34:24 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:40796 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756495Ab0GRPeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 11:34:23 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 18 Jul
 2010 17:34:20 +0200
Received: from thomas.localnet (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 18 Jul
 2010 17:33:59 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.5; x86_64; ; )
In-Reply-To: <AANLkTikavL0DH8FgFxBw7hbGLtj2tqxnP-BT77zo5FJT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151217>

Jay Soffian wrote:
> Color me curious, but why do the merge commit message in git.git
> sometimes look like this:
> 
>   Merge branch 'jn/paginate-fix'
> 
> And other times like this:
> 
>   Merge remote branch 'ko/master' into jc/read-tree-cache-tree-fix
> 
> I don't really see any rhyme or reason about when the "into ..." is
> there and when it's not.

A merge that does not have the 'into <branch>' bit is a merge to
master:

static void do_fmt_merge_msg_title(struct strbuf *out,
	const char *current_branch) {
[...]
	if (!strcmp("master", current_branch))
		strbuf_addch(out, '\n');
	else
		strbuf_addf(out, " into %s\n", current_branch);
}


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
