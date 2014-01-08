From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] Generate scanf_fmts more simply
Date: Wed,  8 Jan 2014 15:43:37 +0100
Message-ID: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 15:44:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0uMm-0005C6-M7
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 15:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbaAHOoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 09:44:17 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43232 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755850AbaAHOoP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 09:44:15 -0500
X-AuditID: 12074412-b7fc96d0000023d5-80-52cd643efaec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.BF.09173.E346DC25; Wed,  8 Jan 2014 09:44:14 -0500 (EST)
Received: from michael.fritz.box (p4FDD47EC.dip0.t-ipconnect.de [79.221.71.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s08EhhdG022001
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jan 2014 09:44:13 -0500
X-Mailer: git-send-email 1.8.5.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsUixO6iqGuXcjbIYN1pFYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M549ncfe8E35ooV0y4wNzDO
	Ze5i5OSQEDCRaP7wmwnCFpO4cG89WxcjF4eQwGVGibMPZzBBOMeZJD6//cAKUsUmoCuxqKcZ
	rENEQE1iYtshFhCbWcBBYvPnRkYQWxhoasf2q2BxFgFVicWzZoD18gq4SGw69RiolwNom4LE
	6utCExi5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdPLzSzRS00p3cQI8b3QDsb1J+UO
	MQpwMCrx8N5QOxMkxJpYVlyZe4hRkoNJSZRXP/pskBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3ktxQDnelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZGQ4OJQnesmSgRsGi1PTU
	irTMnBKENBMHJ4jgAtnAA7ShA6SQt7ggMbc4Mx2i6BSjopQ4bx9IQgAkkVGaBzcAFqWvGMWB
	/hHmnQNSxQOMcLjuV0CDmYAGh8adAhlckoiQkmpgtLjRO1EjbZ1bSubnyQEzwrWXbAtfF+DN
	ZLnnnX7st3s163+nbPepfVOeyBL9b1lYaml3749ORWmVgqDJvM+6Djy33Pz6arB7mltQxvKF
	7Gv9O452c+ZHLq/+cD567v0pj6PVG/YXHCwOv8/lW9uylOPKaXmZ/Yyb3F1YXs6eeeRqfNSW
	I0dllFiKMxINtZiLihMB9PXXNK0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240214>

This is just a fun little thing that I noticed while poking around the
code: the function gen_scanf_fmt() can be replaced with a simple call
to snprintf().

Michael Haggerty (3):
  shorten_unambiguous_ref(): introduce a new local variable
  gen_scanf_fmt(): delete function and use snprintf() instead
  shorten_unambiguous_ref(): tighten up pointer arithmetic

 refs.c | 47 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

-- 
1.8.5.2
