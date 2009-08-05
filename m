From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/4] Re: Please make git-am handle \r\n-damaged patches
Date: Tue,  4 Aug 2009 22:31:55 -0500
Message-ID: <r3l_p2g-BpVHWKE-kMWIRzBGUCnzo9_l7hOHzYLG_4X6oEjXrJ4rJdB10yXPT2jmJJ7ppBmr-x8@cipher.nrlssc.navy.mil>
References: <7vmy6fdxst.fsf@alter.siamese.dyndns.org>
Cc: nanako3@lavabit.com, raa.lkml@gmail.com, hpa@zytor.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 05:32:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXFA-0001Tz-Q2
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 05:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933416AbZHEDci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 23:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933382AbZHEDci
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 23:32:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59631 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348AbZHEDch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 23:32:37 -0400
Received: by mail.nrlssc.navy.mil id n753WSkX014958; Tue, 4 Aug 2009 22:32:29 -0500
In-Reply-To: <7vmy6fdxst.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 05 Aug 2009 03:32:28.0678 (UTC) FILETIME=[5BAF2260:01CA157D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124840>

From: Brandon Casey <drafnel@gmail.com>

Convert mailinfo and mailsplit to use strbufs before attempting to address
the CRLF issue for saved emails.

Brandon Casey (3):
  strbuf: add new function strbuf_getwholeline()
  builtin-mailinfo,builtin-mailsplit: use strbufs
  builtin-mailsplit.c: remove read_line_with_nul() since it is no
    longer used

Junio C Hamano (1):
  Allow mailsplit to handle mails with CRLF line-endings

 builtin-mailinfo.c  |    8 +-------
 builtin-mailsplit.c |   44 ++++++++++++++------------------------------
 builtin.h           |    1 -
 git-am.sh           |    8 +++++++-
 strbuf.c            |   15 ++++++++++++---
 strbuf.h            |    1 +
 t/t3400-rebase.sh   |   26 ++++++++++++++++++++++++--
 7 files changed, 59 insertions(+), 44 deletions(-)
