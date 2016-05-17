From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v6 0/9] connect: various cleanups
Date: Tue, 17 May 2016 10:35:45 +0900
Message-ID: <20160517013554.22578-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 03:36:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Tvm-0006uf-JB
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 03:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbcEQBgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 21:36:07 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35488 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932980AbcEQBgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 21:36:03 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b2TvO-0005sz-Oz; Tue, 17 May 2016 10:35:54 +0900
X-Mailer: git-send-email 2.8.2.411.ga570dec.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294828>

The main difference here is patch 2/9 now throwing an error in user's face
when they have a core.gitProxy configuration with a port number. There might
be some bikeshedding to do on the content of the error message.

Mike Hommey (9):
  connect: call get_host_and_port() earlier
  connect: only match the host with core.gitProxy
  connect: fill the host header in the git protocol with the host and
    port variables
  connect: make parse_connect_url() return separated host and port
  connect: group CONNECT_DIAG_URL handling code
  connect: make parse_connect_url() return the user part of the url as a
    separate value
  connect: change the --diag-url output to separate user and host
  connect: actively reject git:// urls with a user part
  connect: move ssh command line preparation to a separate function

 connect.c              | 243 +++++++++++++++++++++++++++++--------------------
 t/t5500-fetch-pack.sh  |  42 ++++++---
 t/t5532-fetch-proxy.sh |   8 +-
 3 files changed, 183 insertions(+), 110 deletions(-)

-- 
2.8.2.411.ga570dec.dirty
