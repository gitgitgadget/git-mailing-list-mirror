From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] rebase: test ack
Date: Mon, 19 May 2014 14:34:26 -0700
Message-ID: <xmqq4n0lwizh.fsf@gitster.dls.corp.google.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
	<1400447743-18513-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon May 19 23:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmVCe-0003jm-Ko
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 23:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbaESVed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 17:34:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58129 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbaESVec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 17:34:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5F6B19F96;
	Mon, 19 May 2014 17:34:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=MgsnYUMfwB4tPLHwvBNv+kg58Mc=; b=Gihpmv7+Fe+1ZMyJiRAw
	yObpITO0xeMvp24g1SUZhDmDufKOsbszHOjfmESEC3EgWZjnIcR6Gd1YYpPcC29Z
	qOlu3nH5Ey7SXqYz7NPcjscSbQgluS1tra8di2E4AI0X4jq6oBUcCGJJvKak9i4e
	8RC7mp5rOZgQevsO57ZWnpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=plwmrqZ7yaCCBCnPj2wz5gm2Yns7nAOxh3zf/j9Ws1b9g5
	k69j6312l0ebFo0DcxNu71ECHUTTo6vGBdksH8z7HCwlP3I3sE/Gv9chfGTrOkvL
	nmBurgraYllksNshvLa6q9PtnigeaSC3d4ss6/AVBuuxvtPvhqEQSNsPuM9Ik=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CBBC19F95;
	Mon, 19 May 2014 17:34:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A4BDA19F93;
	Mon, 19 May 2014 17:34:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B5B696E-DF9D-11E3-8CC8-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249626>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> test ack! handling
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Will queue with this squashed in.

4/4 seems to have some style issues as well, but I didn't look very
closely.

Thanks.

 t/t3415-rebase-autosquash.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 9d7db13..dcdba6f 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -75,18 +75,18 @@ test_expect_success 'auto squash (option)' '
 '
 
 test_expect_success 'auto ack' '
-	ack="Acked-by: xyz"
-	msg=$(test_write_lines "ack! first commit" "" "$ack")
+	ack="Acked-by: xyz" &&
+	msg=$(test_write_lines "ack! first commit" "" "$ack") &&
 	git reset --hard base &&
 	git commit --allow-empty -m "$msg" -- &&
 	git tag ack &&
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
 	git log --oneline >actual &&
-	git show -s first-commit | grep -v ^commit > expected-msg &&
-	echo "    $ack" >> expected-msg &&
-	git show -s HEAD^ | grep -v ^commit > actual-msg &&
-	diff actual-msg expected-msg
+	git show -s first-commit | grep -v ^commit >expected-msg &&
+	echo "    $ack" >>expected-msg &&
+	git show -s HEAD^ | grep -v ^commit >actual-msg &&
+	test_cmp actual-msg expected-msg
 '
 
 test_expect_success 'auto squash (config)' '
