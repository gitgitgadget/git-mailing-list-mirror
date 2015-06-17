From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 0/2] redo fix for test-lib.sh color support
Date: Wed, 17 Jun 2015 17:11:19 -0400
Message-ID: <1434575481-24604-1-git-send-email-rhansen@bbn.com>
References: <xmqqvbem5bx9.fsf@gitster.dls.corp.google.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Wed Jun 17 23:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Kcd-0001dK-ND
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 23:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbbFQVLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 17:11:44 -0400
Received: from smtp.bbn.com ([128.33.0.80]:50498 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbbFQVLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 17:11:36 -0400
Received: from socket.bbn.com ([192.1.120.102]:34578)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Z5KcL-000532-C0; Wed, 17 Jun 2015 17:11:29 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 1397B3FFC4
X-Mailer: git-send-email 2.4.3
In-Reply-To: <xmqqvbem5bx9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271914>

Changes from v1:
  * Eliminate the case statement and assume the user passed a sane
    value for $1.
  * Use the same test as the non-colorized version of say_color() when
    determining whether to suppress the output:  assume that a message
    can only be suppresed if $1 is the empty string.  This avoids the
    need to test whether the variable say_color_$1 is set.
  * Rename say_color_sgr0 to say_color_reset.
  * Add a new variable say_color_ (set to the empty string) as a way
    of documenting that $1 is expected to be the empty string for
    normal text.

Richard Hansen (2):
  Revert "test-lib.sh: do tests for color support after changing HOME"
  test-lib.sh: fix color support when tput needs ~/.terminfo

 t/test-lib.sh | 99 ++++++++++++++++++++++++++++-------------------------------
 1 file changed, 47 insertions(+), 52 deletions(-)

-- 
2.4.3
