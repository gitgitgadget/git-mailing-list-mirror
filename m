From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH/RFC] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Sun, 28 Apr 2013 22:32:04 -0700
Message-ID: <7v7gjloqaz.fsf@alter.siamese.dyndns.org>
References: <CAJDSCnN6Ekp3wF9hX9Dbt3+CLNg1_aBz8nPGUuCu0WS9MF8aXA@mail.gmail.com>
	<CACsJy8B6OYC-Qcwc53BsVtUSHw1ag6LWF2rBSP6agO6yTXQo+g@mail.gmail.com>
	<7v7gjxx6w3.fsf@alter.siamese.dyndns.org>
	<CACsJy8CT8r7ebE_q5ET+oicTY0NM4LAt1B61xwqfL8tLKc-4OA@mail.gmail.com>
	<CAJDSCnPt=wgT0UQirahvTyen9w_v4XTn0ABHJVCLeKLmC8BsHQ@mail.gmail.com>
	<CAJDSCnN_Va7r2BMLYSbsSzoUNs6YfYfihatb-u4jJw25w8qvZg@mail.gmail.com>
	<7v7gjmow6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Michael Heemskerk <mheemskerk@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:32:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWghH-0005sq-Hs
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab3D2FcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 01:32:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab3D2FcH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Apr 2013 01:32:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E351113219;
	Mon, 29 Apr 2013 05:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZPe58c2yfMUP
	oE0RqKxMPfV/Hks=; b=CzBiXCEZQhsNMBXnH/vHeRUUlibNrOHXSsjuJu0e6duW
	soLKU7Zl9dFH5kyea1xPwY9snNp7/tca/lmqA39FRTZp/HlM8udtzz4P07+bPAEm
	Nis5szNxYuv+v4xOBbJiBG+nA9aQ6G/zuiWzD+Zt1rujnNHsO1fOSsYJYy6Lfis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Gnp6qg
	crJFE+oM+axOLPIxBJT674TsrlDsbNzx4IA/WlF7NgFrAdMAQyaZnVrqz1QU35jD
	r5OP5EYKxIUcyOUNxz2PFAYcdqnip16nqnXhq1IseDpyQBwAfE0jgK4mYX9w6n8M
	aL1X/qYxCKc9wR9EfrEWZrmuKiYqM4l96Ri/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DACE913218;
	Mon, 29 Apr 2013 05:32:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3793813217;
	Mon, 29 Apr 2013 05:32:06 +0000 (UTC)
In-Reply-To: <7v7gjmow6o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 28 Apr 2013 20:25:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 212396E8-B08E-11E2-8128-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222772>

Junio C Hamano <gitster@pobox.com> writes:

> OK, the change the patch text shows looks sensible to me.  Can you
> resend it in full, with the log message, your sign-off, and Duy's
> "Reviewed-by:", so that it can be applied?

I managed to reassemble what I _think_ is close to the original from
a few messages by dequoting and fixing MUA whitespace breakages in
them.

Here is with a slight tweak to the log message.  Please holler if I
grabbed a wrong version of the patch or made any silly mistakes.

Thanks.

-- >8 --
=46rom: Michael Heemskerk <mheemskerk@atlassian.com>
Subject: [PATCH] upload-pack: ignore 'shallow' lines with unknown obj-i=
ds

When the client sends a 'shallow' line for an object that the server do=
es
not have, the server currently dies with the error: "did not find objec=
t
for shallow <obj-id>".  The client may have truncated the history at
the commit by fetching shallowly from a different server, or the commit
may have been garbage collected by the server. In either case, this
unknown commit is not relevant for calculating the pack that is to be
sent and can be safely ignored, and it is not used when recomputing whe=
re
the updated history of the client is cauterised.

The documentation in technical/pack-protocol.txt has been updated to
remove the restriction that "Clients MUST NOT mention an obj-id which i=
t
does not know exists on the server". This requirement is not realistic
because clients cannot know whether an object has been garbage collecte=
d
by the server.

Signed-off-by: Michael Heemskerk <mheemskerk@atlassian.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt | 3 +--
 upload-pack.c                             | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index f1a51ed..b898e97 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -228,8 +228,7 @@ obtained through ref discovery.
 The client MUST write all obj-ids which it only has shallow copies
 of (meaning that it does not have the parents of a commit) as
 'shallow' lines so that the server is aware of the limitations of
-the client's history. Clients MUST NOT mention an obj-id which
-it does not know exists on the server.
+the client's history.
=20
 The client now sends the maximum commit history depth it wants for
 this transaction, which is the number of commits it wants from the
diff --git a/upload-pack.c b/upload-pack.c
index bfa6279..127e59a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -592,7 +592,7 @@ static void receive_needs(void)
 				die("invalid shallow line: %s", line);
 			object =3D parse_object(sha1);
 			if (!object)
-				die("did not find object for %s", line);
+				continue;
 			if (object->type !=3D OBJ_COMMIT)
 				die("invalid shallow object %s", sha1_to_hex(sha1));
 			if (!(object->flags & CLIENT_SHALLOW)) {
--=20
1.8.3-rc0-117-g5915a95
