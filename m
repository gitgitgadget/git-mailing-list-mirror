From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] De-bashing remote-testgit
Date: Mon, 29 Apr 2013 10:41:52 -0700
Message-ID: <1367257315-12009-1-git-send-email-gitster@pobox.com>
References: <7vehdtjl2n.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 19:42:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWs5T-0003RS-5d
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620Ab3D2Rl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:41:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757311Ab3D2Rl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:41:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 642C71AB9E
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hZBS
	tdNwhDOs6B46+iez+SdtW34=; b=CR9ItpD9BrLnphVIqHru6wY+v0EhxnuJj1ri
	1v2d8qC4X7vOcvHW76x/nADy8/fttxPlwLLWywxvXoGuFBtrj8KRSJZ5o+uugixx
	SoEwPbT44RVEVSk721WeFAgPd6m3FBdIlbeU8hDQE7tu6swmPXa0rzwqDYnbppVi
	ct/Vssc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=m3Q09U
	krkrV/vMVX8u3gcFswGFJefReyReUkYo2nZPc4jeqbSXE2BD56FNRmlLnMMqv9p3
	TRfJsfaVS+QhV1BmuRcWdHaemPAtcOSk1MElSnccAGMBDeoSWxPCVZpXtFS2nVub
	EodL38moraIWdzhOM6Y9EvhEdxYxlH6Hs6nSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 581E71AB9D
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:41:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCD971AB9A
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:41:56 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-rc0-121-gda9b90f
In-Reply-To: <7vehdtjl2n.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 1660933A-B0F4-11E2-B71A-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222823>

The two from J6t are what were discussed on the list.  The last one
is to teach git-remote-testgit to honor SHELL_PATH like all the
other shell scripts.

Johannes Sixt (2):
  git-remote-testgit: avoid process substitution
  git-remote-testgit: further remove some bashisms

Junio C Hamano (1):
  git-remote-testgit: build it to run under $SHELL_PATH

 .gitignore                                  |  1 +
 Makefile                                    |  1 +
 git-remote-testgit => git-remote-testgit.sh | 26 ++++++++++++++++----------
 t/t5801-remote-helpers.sh                   |  5 -----
 4 files changed, 18 insertions(+), 15 deletions(-)
 rename git-remote-testgit => git-remote-testgit.sh (77%)

-- 
1.8.3-rc0-121-gda9b90f
