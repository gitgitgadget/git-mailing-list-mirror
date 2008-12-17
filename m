From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 8/5] combine-diff.c: use strbuf_readlink()
Date: Wed, 17 Dec 2008 13:02:42 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171300070.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain> <alpine.LFD.2.00.0812171044110.14014@localhost.localdomain> <7v63lileqh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 22:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD3Z3-0003KC-Lh
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 22:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYLQVC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 16:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbYLQVC7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 16:02:59 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53925 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751411AbYLQVC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 16:02:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHL2hT9002262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 13:02:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHL2hZO016505;
	Wed, 17 Dec 2008 13:02:43 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v63lileqh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103391>



On Wed, 17 Dec 2008, Junio C Hamano wrote:
> -			result[len] = 0;
> +			result_size = buf.len;
> +			result = strbuf_detach(&buf, NULL);

If result_size was made size_t, this would be

	result = strbuf_detach(&buf, &result_size);

But whether it makes any difference, I dunno.

Anyway, Ack on the 6-8 additions.

		Linus
