From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] send-pack: typofix error message
Date: Wed, 07 Sep 2011 13:56:38 -0700
Message-ID: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 22:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PB4-00034x-R3
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 22:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756925Ab1IGU4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 16:56:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756905Ab1IGU4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 16:56:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 304C53D43;
	Wed,  7 Sep 2011 16:56:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	/9POtO5+K4gJDiaLwAtvUFdERw=; b=jQEornPLcbqwwc8tZS1d7Mz4o2paN4hDW
	uOEplonjT2uj485iW2q9/3lNPqDiR9/614pfFb+ZxrgYag7bdbJN+WGgaX26V5vt
	Ux6CL7hweZ2v742vhYS4IYFntWKdU9sP8rToy7aFihiIepIF9kzDacKDyWufFQel
	5LATYAxglA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=B5f0H9yDOuD13bdDsNus+m0vc6e6leTf2yCBK8LJXgjL+jUBtzyfvxbF
	+4RChhNfLdMze0eLTUQPu9V8bsifZyoSqZ0mEDNPki8+qxzgn0fZbNqXKhA9TMDq
	FB6Tf/dPPy9GywcyfkewDFY2TsfE6diBn+A0F4bZ1iJLd1/KTWU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2816F3D41;
	Wed,  7 Sep 2011 16:56:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3C3F3D40; Wed,  7 Sep 2011
 16:56:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E213902A-D993-11E0-B777-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180905>

The message identifies the process as receive-pack when it cannot fork the
sideband demultiplexer. We are actually a send-pack.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c1f6ddd..87833f4 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -334,7 +334,7 @@ int send_pack(struct send_pack_args *args,
 		demux.data = fd;
 		demux.out = -1;
 		if (start_async(&demux))
-			die("receive-pack: unable to fork off sideband demultiplexer");
+			die("send-pack: unable to fork off sideband demultiplexer");
 		in = demux.out;
 	}
 
-- 
1.7.7.rc0.186.g50963
