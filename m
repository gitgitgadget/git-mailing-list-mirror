From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/fetch.c: Fix a sparse warning
Date: Wed, 28 Aug 2013 19:56:17 +0100
Message-ID: <521E47D1.9060106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 20:56:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEkvA-0004XX-VW
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 20:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577Ab3H1S4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 14:56:45 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:48694 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754410Ab3H1S4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 14:56:44 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 99E0AAC42B6;
	Wed, 28 Aug 2013 19:56:42 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 690B4AC42CC;
	Wed, 28 Aug 2013 19:56:42 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Wed, 28 Aug 2013 19:56:42 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233193>


Sparse issues an "'prepare_transport' was not declared. Should it
be static?" warning. In order to suppress the warning, since this
symbol only requires file scope, we simply add the static modifier
to it's declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

When you re-build the next branch, could you please squash this into
commit db5723c6 ("fetch: refactor code that prepares a transport",
07-08-2013). [from the 'jc/transport-do-not-use-connect-twice-in-fetch'
branch]

Thanks!

ATB,
Ramsay Jones


 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e880116..9e654ef 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -747,7 +747,7 @@ static void set_option(struct transport *transport, const char *name, const char
 			name, transport->url);
 }
 
-struct transport *prepare_transport(struct remote *remote)
+static struct transport *prepare_transport(struct remote *remote)
 {
 	struct transport *transport;
 	transport = transport_get(remote, NULL);
-- 
1.8.4
