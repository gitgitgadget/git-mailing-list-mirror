From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] "log --author-date-order" follow-up
Date: Fri, 21 Jun 2013 11:49:34 -0700
Message-ID: <1371840579-20161-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 20:49:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6P4-0002Es-UR
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423701Ab3FUStm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:49:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423388Ab3FUStl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:49:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A5A52A0A6;
	Fri, 21 Jun 2013 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=/exH78j7vOrsoFkrKJHADMCoFcQ
	=; b=dlOvX5Cnu6IobuUSauKEMWnZnTvkAuHyfdPJzAnGHNcX/bHbO9rzjv+GcJo
	4gS/xjaBMw/wL9G0qsl62Ue0LM1LBM9uD8dVKa5Qkhige7l4VedJg0aDFiP1LZFs
	2i7e87gUMQsD06sKGRI4Q7zOpAAJyB8qqb8tynMtwwXr2yTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=AjSsSQgj/fne9O5BlfPEM
	bTD/L73zemT4YCKlINXQkxQy6snz+3wMY7maJEDYP1OqoSU9eFW0OZE8TiMekRZy
	zdBmpsZzlDUf7CRtV8kNdQqhEssZp9sMntLImppVuC0WUrl4SmAI9jBASOQAnles
	VeSz9X1L7k2udFSL0heO6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71CB82A0A5;
	Fri, 21 Jun 2013 18:49:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8BB02A0A4;
	Fri, 21 Jun 2013 18:49:40 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-691-gcbc83f4
X-Pobox-Relay-ID: 54AC2036-DAA3-11E2-A54C-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228645>

Complete the series to teach "--author-date-order" to the commands
in the log family by adding some tests.

We did not have explicit tests for --date-order, so the third patch
in this series adds one while at it.

Junio C Hamano (5):
  t/lib-t6000: style fixes
  topology tests: teach a helper to take abbreviated timestamps
  t6003: add --date-order test
  topology tests: teach a helper to set author dates as well
  t6003: add --author-date-order test

 t/lib-t6000.sh                 | 104 ++++++++++++++++++++++-------------------
 t/t6002-rev-list-bisect.sh     |  84 ++++++++++++++++-----------------
 t/t6003-rev-list-topo-order.sh | 101 +++++++++++++++++++++++++++------------
 3 files changed, 169 insertions(+), 120 deletions(-)

-- 
1.8.3.1-682-g924db96
