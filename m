From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 23 Mar 2008 16:06:25 -0500
Message-ID: <5d46db230803231406x132e748bm306494ec5f8dfd2b@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
	 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
	 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 22:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdXPK-0004Q3-4g
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 22:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbYCWVG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 17:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbYCWVG1
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 17:06:27 -0400
Received: from hs-out-0708.google.com ([64.233.178.240]:35039 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbYCWVG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 17:06:26 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1952290hsl.5
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 14:06:25 -0700 (PDT)
Received: by 10.150.123.16 with SMTP id v16mr2796552ybc.156.1206306385623;
        Sun, 23 Mar 2008 14:06:25 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Sun, 23 Mar 2008 14:06:25 -0700 (PDT)
In-Reply-To: <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 3a0732a57df03d91
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77958>

On Sun, Mar 23, 2008 at 5:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  * gs/pretty-hexval (Fri Mar 21 10:05:06 2008 -0500) 1 commit
>   + pretty.c: add %x00 format specifier.
>
>  Adds a generic "insert any byte value" to --pretty=format:<> specifier.
>
I also sent out the following patch that could be put in instead of or in
addition to this one.  The both solve my problem in different ways.

Thanks,
Govind.

---
From: Govind Salinas <blix@sophiasuchtig.com>
Date: Sun, 23 Mar 2008 16:02:11 -0500
Subject: [PATCH] log-tree.c:  Make log_tree_diff_flush() honor line_termination.

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 log-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 608f697..5f55683 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -338,7 +338,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
 				printf("---");
-			putchar('\n');
+			putchar(opt->diffopt.line_termination);
 		}
 	}
 	diff_flush(&opt->diffopt);
-- 
1.5.4.4.550.g77e21.dirty
