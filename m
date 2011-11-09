From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] commit-tree updates
Date: Wed,  9 Nov 2011 13:01:32 -0800
Message-ID: <1320872495-7545-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 22:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROFHH-0000X7-RR
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 22:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab1KIVBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 16:01:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753104Ab1KIVBi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 16:01:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5870C6593
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=DLd3rltUXxQqsI7GTtf4+YA0Yv4
	=; b=WaVNrxa3EcqOiIVGsLTU6jlKIIgssaDfV9Jt51qCAtns7LJiX3vLGRdEn3s
	OXIWIC3zVGJcPcnfdJPqW3zLSNa/FTTaYeP880GaIi85G46cGlfNMRD+ytGi6Rz5
	h1atQMc2Us3rLFdt1zGnC93yZGxcQVK+DIuVCDsBrh+5Haec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=ew7fqtbS6U0I3RTAfENRQIaZPax66
	EOOEIhxXx+gl0WpO6nBnfJcXex4U+rHlFY07zue/LOZX9hPj9qiPIqCLr1OiEIFS
	GTtPa/UTnIOQBtHVuLRBiNXEze++/H66DCH346GzES5lO21O3jnLsg52boUEEh85
	OJdbcAIqhMIXbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50AE56590
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDCE4658E for
 <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:36 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
X-Pobox-Relay-ID: 033A8372-0B16-11E1-A452-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185168>

Here are a handful of patches to the lowest level plumbing commit-tree to
teach it to record extended headers.  With this series, scripted Porcelain
like rebase--am can propagate the "mergetag" header while rebasing.

Junio C Hamano (3):
  commit-tree: update the command line parsing
  commit-tree: teach -m/-F options to read logs from elsewhere
  commit-tree: teach -x <extra>

 Documentation/git-commit-tree.txt |   17 ++++++-
 builtin/commit-tree.c             |   92 ++++++++++++++++++++++++++++++-------
 2 files changed, 89 insertions(+), 20 deletions(-)

-- 
1.7.8.rc1.82.gde0f9
