From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] "git notes remove" updates
Date: Wed, 18 May 2011 17:14:18 -0700
Message-ID: <1305764061-21303-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 02:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMqso-0008S0-6a
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 02:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab1ESAOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 20:14:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1ESAOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 20:14:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D69E05EA9
	for <git@vger.kernel.org>; Wed, 18 May 2011 20:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=gxGUClwg0RTF1RhpJym3SdMFP4I
	=; b=R1A6tlfZGZWSBINN0OMcP7+kDFIgzjVJMWUKMuBcX+gFnq7qt+j0pIdnK3w
	CbrGuo4m5VeVMI1n2vcMYThCY8CoYykRUchyTobgLCsJPDRlWhxhYFzlZMCL1PEK
	hCixd+brsXrRJDRRPZvWwx5YPIjMqPL2H/VczMQqpX80hv/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=ueENq6QdO0gbDvssLQiR05jSwGfsf
	q0+DOpBrALKHbjbJKQndC5fBBGTda6Cn1CXtB18WEHLCm896ML9YEOJBtEX6CK5R
	7KykbHr9pntSmF9yjbH70W5J8Vpgap+sd8HjhASiC1bnwUpNrsOttwmPlJTUZfR6
	fmvbs0Xw4O5fLs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3B895EA8
	for <git@vger.kernel.org>; Wed, 18 May 2011 20:16:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 654AB5EA6 for
 <git@vger.kernel.org>; Wed, 18 May 2011 20:16:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.414.gb4910
X-Pobox-Relay-ID: 3F9FAA38-81AD-11E0-BECE-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173920>

I wanted to do a bit better than

	for sha1 in ... list of old commit objects
	do
		git notes --ref refs/notes/amlog remove $sha1
	done

to remove old entries in my "where did this commit come from" database.

Junio C Hamano (3):
  notes remove: allow removing more than one
  notes remove: --missing-ok
  notes remove: --stdin reads from the standard input

 Documentation/git-notes.txt |   16 ++++++++--
 builtin/notes.c             |   65 ++++++++++++++++++++++++++-------------
 t/t3301-notes.sh            |   71 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 25 deletions(-)

-- 
1.7.5.1.414.gb4910
