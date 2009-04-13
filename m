From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 INTRO] I hope this will do it!
Date: Mon, 13 Apr 2009 13:23:44 -0500
Message-ID: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQqt-0007Ny-Bg
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbZDMSYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbZDMSYP
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:24:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:40473 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbZDMSYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:24:14 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1130137wah.21
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=fPCpFX25o4hl1GXPW+tMyhE5iyH4ub3qenRMMCg9kQY=;
        b=r2THiVw/4XBEtji9WkL7he93nBN/FSA4rg98N+YPNbP11tommRTIjPe9t9uxhQaA/K
         5A7D10UeHK+VXbT2Gt7gHjsUnLhG5QrcWZ2Yep23rd4zJvOQdMcf2e9qfJBEzlgVQoYE
         +TdJiWZYp9h+AtQm45qAUXGx7wvQ4ib+7O4ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=GTqXsaf1hxizPauspoGQzyRr2rdKRpvtZdZ8x6ni980A9zJQ9MB6RNnrvYoZN1GiD4
         sZSlG03yFK3efFRt7S7YS+o5Zz+rxJKZpq93uMNBIOcVHPSDzPDNMgSt8SDs5YZ8PC0q
         3EY2OyIK9+j9YCJS4iLWA9VYI8jcTgNkX2Mpk=
Received: by 10.114.153.18 with SMTP id a18mr3278954wae.200.1239647053966;
        Mon, 13 Apr 2009 11:24:13 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.24.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:24:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116461>

Here is the list of notable improvements:

  send-email: --compose takes optional argument to existing file
    * Update docs about what editor is chosen.
    * Better variable name for --compose paths and filehandles.
    * Abort on empty summary.
    * Note (in commit message) that editing the final version no longer is used.

  send-email: Minor cleanup of $smtp_server usage and send_message()
    * Back to localhost.
    * Add note about empty string if it's not already there.

  send-email: Add --sleep for email throttling
    * Put docs in alphabetical order.

  send-email: Remove horrible mix of tabs and spaces
    * Less verbose whitespace comment.

  send-email: References: should only reference what is actually sent
    * s/of/if/ (comment above send_message()).

  send-email: Handle "GIT:" rather than "GIT: " during --compose
    * Undo refactoring of get_patch_subject().

  send-email: --smtp-server-port should take an integer
    * Update documents to suggest that symbolic ports can be used.
    * Put this commit with the docs.

  send-email: Cleanup the usage text and docs a bit
    * Add note about symbolic ports

  Docs: send-email: Remove superfluous information in CONFIGURATION
    * Remove comment block?

  Docs: send-email: Put options back into alphabetical order
    * Remove comment block?

The overall diffstat:

  Documentation/git-send-email.txt |  129 ++++++---
  git-send-email.perl              |  641 +++++++++++++++++++++++++-------------
  2 files changed, 511 insertions(+), 259 deletions(-)

The overall patch series:

    [PATCH RFC3 01/13] Docs: send-email: Put options back into alphabetical order
new [PATCH RFC3 02/13] Docs: send-email: Refer to CONFIGURATION section for sendemail.multiedit
    [PATCH RFC3 03/13] Docs: send-email: Remove superfluous information in CONFIGURATION
    [PATCH RFC3 04/13] Docs: send-email: --smtp-server-port can take symbolic ports
    [PATCH RFC3 05/13] send-email: Cleanup the usage text and docs a bit
    [PATCH RFC3 06/13] send-email: Handle "GIT:" rather than "GIT: " during --compose
    [PATCH RFC3 07/13] send-email: 'References:' should only reference what is sent
new [PATCH RFC3 08/13] send-email: Remove superfluous `my $editor = ...'
    [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and spaces
    [PATCH RFC3 10/13] send-email: Add --sleep for email throttling
    [PATCH RFC3 11/13] send-email: Minor cleanup of $smtp_server usage and send_message()
    [PATCH RFC3 12/13] send-email: --compose takes optional argument to existing file
new [PATCH RFC3 13/13] send-email: --compose always includes a 'GIT: ' prefixed list of patch subjects

Sincerely,
Michael Witten
