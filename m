From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] ident.c: remove unused variables
Date: Fri, 08 Jan 2010 08:03:43 -0800
Message-ID: <7vfx6geg80.fsf_-_@alter.siamese.dyndns.org>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
 <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org> <xuu28wc9xd42.fsf@nowhere.com>
 <7vskagh9fg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 17:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHJb-0000Nw-Kg
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656Ab0AHQDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753647Ab0AHQDv
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:03:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab0AHQDu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:03:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3431A8F031;
	Fri,  8 Jan 2010 11:03:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrJUnpS5JTW2SK2FHBvu/HXiV1U=; b=tM9QzE
	V/tlo5GpiOAhjw1LPYYbogM1C3PwTSdl4qpxkVm5lyWPoUWjTuZKkGgfZUAeiFpS
	MV66iQJ5/iXtjz63DgrA+ngGfk8uSKZp8OR9RuROSs0rhLtGjREO7D8JsDurY4Pf
	4k6jBV6V4H4sQfnMMYyPox2fWtLIKpZ1WO5Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XJb3CM2G2NhAglFO63h1XxPiwrTt+n0A
	vpeLo/Je5piaDCA9NCoD4p8lRo3fA0KKkkUGC7QhRy1MbGlElYjb9ifW63p++ZDt
	URw2WFCGarRSOowZCtFP2RHb3s6lJNDcDcWs6Ky7FHbGkyfRzvM3H3a8Vll7+Fd7
	glqyfCyC1Uw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10EC18F02F;
	Fri,  8 Jan 2010 11:03:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DF598F02A; Fri,  8 Jan
 2010 11:03:45 -0500 (EST)
In-Reply-To: <7vskagh9fg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 08 Jan 2010 08\:02\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67C7D02C-FC6F-11DE-9D4B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136449>

d5cc2de (ident.c: Trim hint printed when gecos is empty., 2006-11-28)
reworded the message used as printf() format and dropped "%s" from it;
these two variables that hold the names of GIT_{AUTHOR,COMMITTER}_NAME
environment variables haven't been used since then.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is an independent clean-up

 ident.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/ident.c b/ident.c
index 26409b2..e6c1798 100644
--- a/ident.c
+++ b/ident.c
@@ -168,8 +168,6 @@ static int copy(char *buf, size_t size, int offset, const char *src)
 	return offset;
 }
 
-static const char au_env[] = "GIT_AUTHOR_NAME";
-static const char co_env[] = "GIT_COMMITTER_NAME";
 static const char *env_hint =
 "\n"
 "*** Please tell me who you are.\n"
@@ -204,7 +202,7 @@ const char *fmt_ident(const char *name, const char *email,
 
 		if ((warn_on_no_name || error_on_no_name) &&
 		    name == git_default_name && env_hint) {
-			fprintf(stderr, env_hint, au_env, co_env);
+			fprintf(stderr, env_hint);
 			env_hint = NULL; /* warn only once */
 		}
 		if (error_on_no_name)
-- 
1.6.6.209.g52296.dirty
