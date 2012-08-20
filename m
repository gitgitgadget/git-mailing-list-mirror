From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] further fixes of check_ref_format() users
Date: Mon, 20 Aug 2012 10:39:55 -0700
Message-ID: <1345484397-10958-1-git-send-email-gitster@pobox.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 19:40:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3VxP-00017v-G4
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 19:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab2HTRkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 13:40:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab2HTRj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 13:39:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04D398B37;
	Mon, 20 Aug 2012 13:39:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=X12VclcA11nAG4XJpkvIWBNXJ3w
	=; b=kDHb1eKvDgM7Bz6oIz2Z0tR1uoIorf4aqLfM5nlCQD3MG0ZkKPkFZaBpnh9
	hhoSjZeCvPiiWx37VsxBaPii8q0Tob+UZi7D1WuLifRpln9/z/ex6TiQOjr6kJC/
	z7dXfYmWyZwbVUtc2UfexSrLwxOQKs0+a3t79YEEJEipEOes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=TKbtbH5DCoRaYk1spmfgt
	XUlYj0M7bbPF3GwZsCgZxSEYaE7MA36VeBI3/M9Hoxd8dHeAAUnUy6sDLegfqtu5
	/S4fXKzV2+UMBl2rf8p2iEFJ/ZuKuyMycc+tg94V39E6SCXzEzPNiEzvx+106zgV
	FgXg8gy5VZvt0Mb0O51Gz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E78898B36;
	Mon, 20 Aug 2012 13:39:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68B9E8B34; Mon, 20 Aug 2012
 13:39:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.92.g7963261
X-Pobox-Relay-ID: 0FB367AA-EAEE-11E1-820F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203860>

There were a few overtight "check_ref_format()" that was exposed
with a natural "mirror" refspec "refs/*:refs/*".

Junio C Hamano (2):
  fetch/push: allow refs/*:refs/*
  get_fetch_map(): tighten checks on dest refs

 builtin/fetch-pack.c   |  2 +-
 builtin/receive-pack.c |  2 +-
 connect.c              |  8 ++------
 remote.c               |  6 +++---
 t/t5516-fetch-push.sh  | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 40 insertions(+), 11 deletions(-)

-- 
1.7.12.92.g7963261
