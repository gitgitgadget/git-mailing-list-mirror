From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/6] Improve test coverage of update-ref error messages
Date: Fri, 10 Jun 2016 10:14:43 +0200
Message-ID: <cover.1465544913.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, David Turner <novalis@novalis.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:15:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHb0-0001QR-7y
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbcFJIPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:15:00 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45850 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888AbcFJIO4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 04:14:56 -0400
X-AuditID: 1207440d-bb3ff7000000090b-37-575a76ff442e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id EA.B5.02315.FF67A575; Fri, 10 Jun 2016 04:14:55 -0400 (EDT)
Received: from michael.fritz.box (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A8EpD2028943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 04:14:53 -0400
X-Mailer: git-send-email 2.8.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqPu/LCrcoPe9hEXXlW4mi4beK8wW
	T+beZba4vWI+s8WSh6+ZLbqnvGW0+NHSw+zA7vH3/Qcmj52z7rJ7PHzVxe7R1X6EzeNZ7x5G
	j4uXlD0+b5ILYI/itklKLCkLzkzP07dL4M6YsZKv4BJXxdv7rSwNjHc4uhg5OSQETCTuzt/K
	0sXIxSEksJVRYuW7vawQzkkmic+3elhAqtgEdCUW9TQzgdgiAmoSE9sOgXUwC3QySZzY8was
	SFjAS+LR9p9sXYwcHCwCqhJz9uaDhHkFzCVWHj7JDLFNTuLy9AdsExi5FjAyrGKUS8wpzdXN
	TczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICRneHYz/18kcYhTgYFTi4WXYERkuxJpYVlyZ
	e4hRkoNJSZR3Z2BUuBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXjGQHG9KYmVValE+TEqag0VJ
	nFdtibqfkEB6YklqdmpqQWoRTFaGg0NJglcNGBtCgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkp
	qUWJpSUZ8aCAji8GhjRIigdobwVIO29xQWIuUBSi9RSjLseR/ffWMgmx5OXnpUqJ8y4qBSoS
	ACnKKM2DWwFLEK8YxYE+FubdAFLFA0wucJNeAS1hAlqy/Eg4yJKSRISUVAOjxWph4Rwv1pPv
	hK+J3knuahVrL7HK/K5ZXOet/b3mYpb5lfv/mzqebTVqzQ2Iz085+DfHvmT+u6DfigZffyvw
	V2uHy11Zu/2VTemmogPfZcu2FGvZB/ef2nJZ9MfE+Fe7e1rnahS2tMgWxm2MepXs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296951>

This is v2 of the patch series. Thanks to Johannes Sixt and Junio for
their comments about v1 [1].

Changes since v1:

* In t1404, don't use non-portable `local`: change function
  test_update_rejected to refer to the global `$prefix` variable
  rather than taking it as a parameter.

* Because that code change has become more involved, split off the
  addition of documentation for the function into a separate patch.

These patches are also available from my GitHub account [2] as branch
update-ref-errors.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/296626
[2] https://github.com/mhagger/git

Michael Haggerty (6):
  t1404: rename file to t1404-update-ref-errors.sh
  t1404: remove "prefix" argument to test_update_rejected
  t1404: document function test_update_rejected
  t1404: add more tests of update-ref error handling
  lock_ref_for_update(): make error handling more uniform
  lock_ref_for_update(): avoid a symref resolution

 refs/files-backend.c               |  77 ++++---
 t/t1404-update-ref-df-conflicts.sh | 181 -----------------
 t/t1404-update-ref-errors.sh       | 407 +++++++++++++++++++++++++++++++++++++
 3 files changed, 452 insertions(+), 213 deletions(-)
 delete mode 100755 t/t1404-update-ref-df-conflicts.sh
 create mode 100755 t/t1404-update-ref-errors.sh

-- 
2.8.1
