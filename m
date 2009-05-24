From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] http*: add helper methods for fetching objects (loose)
Date: Sun, 24 May 2009 13:44:15 -0700
Message-ID: <7vzld2s02o.fsf@alter.siamese.dyndns.org>
References: <20090524222008.b9de3f45.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 22:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8KYN-0002b3-WB
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 22:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbZEXUoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbZEXUoO
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 16:44:14 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48121 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbZEXUoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 16:44:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204415.YQAK20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 May 2009 16:44:15 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id vYkF1b0014aMwMQ03YkF5U; Sun, 24 May 2009 16:44:15 -0400
X-Authority-Analysis: v=1.0 c=1 a=Mz4lW8oJAIYA:10 a=Tnb7dDIH5bkA:10
 a=pGLkceISAAAA:8 a=HKJwtpWfpazfx1qdNPoA:9 a=v1aqqZHwk6NI1kqLpEQA:7
 a=huD2BYO_OE9NNoJNJ3DSqbqZcJEA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119857>

Tay Ray Chuan <rctay89@gmail.com> writes:

> ...
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

I think you can guess what my suggestion would be for the proposed commit
log message from comments to other patches, so I won't repeat them for
this patch.

You make a couple of variables no longer necessary with this patch; please
squash this in when rerolling.

 http-push.c   |    1 -
 http-walker.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 122cf56..386552c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -524,7 +524,6 @@ static void release_request(struct transfer_request *request)
 
 static void finish_request(struct transfer_request *request)
 {
-	struct stat st;
 	struct http_pack_request *preq;
 	struct http_object_request *obj_req;
 
diff --git a/http-walker.c b/http-walker.c
index 95a1e9b..8a617ae 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -152,7 +152,6 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 	struct object_request *newreq;
 	struct object_request *tail;
 	struct walker_data *data = walker->data;
-	char *filename = sha1_file_name(sha1);
 
 	newreq = xmalloc(sizeof(*newreq));
 	newreq->walker = walker;
