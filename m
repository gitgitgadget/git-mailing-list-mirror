From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/14] Remove unused code from imap-send.c
Date: Mon, 14 Jan 2013 06:32:32 +0100
Message-ID: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucgI-00077r-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab3ANFdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:33:23 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:60790 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751956Ab3ANFdW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:33:22 -0500
X-AuditID: 1207440f-b7f276d0000008b2-8a-50f398a2c82d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 68.41.02226.2A893F05; Mon, 14 Jan 2013 00:33:22 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2h026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:20 -0500
X-Mailer: git-send-email 1.8.0.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsUixO6iqLtoxucAg9O/OC26rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGQ/Pb2Uq
	mMlZceYCdwPjNfYuRk4OCQETiUtz/zFC2GISF+6tZ+ti5OIQErjMKPFs6QomCOcsk8SSq83M
	IFVsAroSi3qamUBsEQE1iYlth1hAbGaBFImO591gk4QFrCS+/l/ABmKzCKhKfO6ZCFbDK+Ai
	MWlSGwvENgWJ1zsvsU5g5F7AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQT
	IyQc+Hcwdq2XOcQowMGoxMO7qeRzgBBrYllxZe4hRkkOJiVR3vB+oBBfUn5KZUZicUZ8UWlO
	avEhRgkOZiUR3tA6oBxvSmJlVWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFqEUxWhoNDSYK3
	fzpQo2BRanpqRVpmTglCmomDE0RwgWzgAdpQA1LIW1yQmFucmQ5RdIpRUUqcNxUkIQCSyCjN
	gxsAi9xXjOJA/wjz+oFU8QCjHq77FdBgJqDBZy+8BxlckoiQkmpgLPtd+NTDwnfhnbkmq90K
	I61S/S/evZihLr5ewvn8pOay5XrM9xUrPnnF/D231iV+zSkXnqpd9+cfl7j+YMUsTrvb/nmN
	GbYWq1+Z7nX/w+B4YMWDc8U3Oyub1n18wXPGLCWlSmX2mV2pBcImqzaftt7x565t+7k9XjmH
	phu5mJx8fuH0T5FsEyWW4oxEQy3mouJEAJeziFm3AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213435>

As discussed before [1], imap-send.c was copied from isync, including
a lot of code that is not used within the git project.  This patch
series rips a bunch of it out.

[1] http://comments.gmane.org/gmane.comp.version-control.git/210355

Michael Haggerty (14):
  imap-send.c: remove msg_data::flags, which was always zero
  imap-send.c: remove struct msg_data
  iamp-send.c: remove unused struct imap_store_conf
  imap-send.c: remove struct store_conf
  imap-send.c: remove struct message
  imap-send.c: remove some unused fields from struct store
  imap-send.c: inline imap_parse_list() in imap_list()
  imap-send.c: remove struct imap argument to parse_imap_list_l()
  imap-send.c: remove namespace fields from struct imap
  imap-send.c: remove unused field imap_store::trashnc
  imap-send.c: simplify logic in lf_to_crlf()
  imap-send.c: use struct imap_store instead of struct store
  imap-send.c: remove unused field imap_store::uidvalidity
  imap-send.c: fold struct store into struct imap_store

 imap-send.c | 286 +++++++++---------------------------------------------------
 1 file changed, 39 insertions(+), 247 deletions(-)

-- 
1.8.0.3
