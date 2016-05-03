From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4 00/11] connect: various cleanups
Date: Tue,  3 May 2016 17:50:41 +0900
Message-ID: <1462265452-32360-1-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 10:51:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axW35-0004la-6o
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbcECIvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:51:10 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51922 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755803AbcECIu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:50:58 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1axW2e-0008Qn-7O; Tue, 03 May 2016 17:50:52 +0900
X-Mailer: git-send-email 2.8.1.16.gaa70619.dirty
In-Reply-To: <1462082573-17992-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293341>

I went even further this time around. I'm not totally satistifed with
the resulting parse_connect_url function, but at least it feels to me
this series puts us in a better place to actually improve it further.

Mike Hommey (11):
  add fetch-pack --diag-url tests for some corner cases
  connect: call get_host_and_port() earlier
  connect: only match the host with core.gitProxy
  connect: fill the host header in the git protocol with the host and
    port variables
  connect: make parse_connect_url() return separated host and port
  connect: group CONNECT_DIAG_URL handling code
  connect: make parse_connect_url() return the user part of the url as a
    separate value
  connect: change the --diag-url output to separate user and host
  connect: use "-l user" instead of "user@" on ssh command line
  connect: actively reject git:// urls with a user part
  connect: move ssh command line preparation to a separate function

 connect.c             | 223 ++++++++++++++++++++++++++++----------------------
 t/t5500-fetch-pack.sh |  46 ++++++++---
 t/t5601-clone.sh      |  52 ++++++++++--
 3 files changed, 204 insertions(+), 117 deletions(-)

-- 
2.8.1.16.gaa70619.dirty
