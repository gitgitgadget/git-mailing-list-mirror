From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 0/2] Add in-place editing support to git interpret-trailers
Date: Mon, 11 Jan 2016 14:33:31 +0100
Message-ID: <1452519213-1819-1-git-send-email-tklauser@distanz.ch>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 14:33:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIcbS-0000lV-Jq
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 14:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759593AbcAKNdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 08:33:41 -0500
Received: from mail.zhinst.com ([212.126.164.98]:52495 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759552AbcAKNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 08:33:39 -0500
Received: from ziws06.zhinst.com ([10.42.0.7])
	by mail.zhinst.com (Kerio Connect 9.0.1) with ESMTP;
	Mon, 11 Jan 2016 14:33:33 +0100
X-Mailer: git-send-email 2.7.0.1.g5e091f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283647>

This patch series adds support for in-place editing to git interpret-trailers
akin to sed -i, perl -i.

v1->v2:
 - Split patch to make review easier, as suggested by Matthieu Moy.
 - Rename FILE * function parameters to a more readable name, as suggested by
   Matthieu Moy.
 - Write output to temporary file and rename after successfully written in full
   to avoid losing the original file in case of an error/interrupt. Pointed out
   by Eric Sunshine.

Tobias Klauser (2):
  trailer: use fprintf instead of printf
  interpret-trailers: add option for in-place editing

 Documentation/git-interpret-trailers.txt | 24 +++++++++++-
 builtin/interpret-trailers.c             | 13 +++++--
 t/t7513-interpret-trailers.sh            | 32 ++++++++++++++++
 trailer.c                                | 63 +++++++++++++++++++++++++-------
 trailer.h                                |  3 +-
 5 files changed, 115 insertions(+), 20 deletions(-)

-- 
2.7.0.1.g5e091f5
