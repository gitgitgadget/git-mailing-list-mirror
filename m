From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/9] Clarify two uses of remote.*.fetch
Date: Tue,  3 Jun 2014 15:16:23 -0700
Message-ID: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx0j-00055H-FS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965344AbaFCWQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:16:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50960 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965067AbaFCWQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:16:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38A751DD4F;
	Tue,  3 Jun 2014 18:16:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=h4yHSVD0aro92CYfJMvIfjGsPcg
	=; b=p9W56agdQnjYxX91PxV6XyDvUKTe8onC3dil2Z7DAmfszpjekjSDVJeUDyl
	GD+dBfLH2FYqgFpxQGVwKqawwl9CNs4DxhX3RXGWCkJJC6N3v6grZlZt0aeHc0+1
	QimSA4FGjV5F6Pw+hVToJC9gb6ldAkTOWnHYElKbHq02EKN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=AqG9uaOCEBrKqTnJJHX36X9RrUBVF
	q0vWPEIvU1bPs6UJpjg7J1d8d95hcXz6+gtnA4yu7P7Dl+CIEgRonzNkJNZN6W85
	0AWOh2oZGDYIrGqxaa8ufa8sUi5666vIGQ7ddT5UTduBUuO9D9/4U52GgfaByASq
	zdrKObxjpktyPM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 309761DD4E;
	Tue,  3 Jun 2014 18:16:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 743511DD48;
	Tue,  3 Jun 2014 18:16:33 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
X-Pobox-Relay-ID: B873DB6A-EB6C-11E3-A284-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250695>

The early part of this has been sent to the list and this round
contains updates based on review comments.  The new patches at the
end clarifies how remote.*.fetch configuration variables are used in
two conceptually different ways.

We would need a similar update for the "git push" side, which uses
remote.*.push configuration variables in the same two different
ways, but that is for a different week.

Junio C Hamano (8):
  fetch doc: update introductory part for clarity
  fetch doc: update note on '+' in front of the refspec
  fetch doc: remove notes on outdated "mixed layout"
  fetch doc: on pulling multiple refspecs
  fetch doc: update refspec format description
  fetch doc: remove "short-cut" section
  fetch doc: add a section on configured remote-tracking branches
  fetch: allow explicit --refmap to override configuration

Marc Branchaud (1):
  fetch doc: move FETCH_HEAD material lower and add an example

 Documentation/fetch-options.txt    |  8 ++++
 Documentation/git-fetch.txt        | 87 ++++++++++++++++++++++++++++++++------
 Documentation/pull-fetch-param.txt | 58 +++++++++----------------
 builtin/fetch.c                    | 35 +++++++++++++--
 t/t5510-fetch.sh                   | 37 ++++++++++++++++
 5 files changed, 171 insertions(+), 54 deletions(-)

-- 
2.0.0-511-g1433423
