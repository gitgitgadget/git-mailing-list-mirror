From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v5 0/9] connect: various cleanups
Date: Mon, 16 May 2016 09:07:31 +0900
Message-ID: <20160516000740.19042-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:08:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b264j-00026o-Kn
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbcEPAHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 20:07:48 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34878 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbcEPAHq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 20:07:46 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b264S-0004xy-Hs; Mon, 16 May 2016 09:07:40 +0900
X-Mailer: git-send-email 2.8.2.411.ga331486
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294698>

I removed the two controvertial patches, and applied the various suggestions
from the last cycle.

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

 connect.c             | 222 ++++++++++++++++++++++++++++----------------------
 t/t5500-fetch-pack.sh |  42 +++++++---
 2 files changed, 157 insertions(+), 107 deletions(-)

-- 
2.8.2.411.ga331486
