From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 00/12] Introduction to Decreasing send-email Entropy
Date: Sat, 18 Apr 2009 12:01:56 -0500
Message-ID: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDxV-00064y-Vo
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbZDRRCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbZDRRCa
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:02:30 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:55720 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbZDRRC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:02:29 -0400
Received: by qyk32 with SMTP id 32so632485qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=EknL4S1dxGrI2gGo9xcDxUASHicVMbuO6inMFc3/fAk=;
        b=sxkriy1VUhtcVoZ+aOec8P3v95Q8tNBePRsjDYoWWg8cbszyrQ/alawaQCZKloG5UJ
         LispZvZuI6obFS79zT7WtrB6Vjr2HPiQzKYXYllMnt/n1MxzJCKD8WsNPV1pJ1vkhekG
         AZSIaOU0Ph9R9YtsCPx5eVUtuzGeuefLXMM1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=SdbihuTrVa7kTU/e/NCgLqlUUc8NrR6oL7wrZee8BRT/3cO6C8TgkGD2Igypbq+kw2
         4g3RIGejML+5LgcrHi96fL9NjXTd6ACa68RjZ3DpRXzNbfN5GppmvdMJDQ6Aw5Qr0632
         m2CKQhJwSORyBAPEv8MjdGHPktr/5FQaBuW+o=
Received: by 10.220.85.149 with SMTP id o21mr4252418vcl.106.1240074146669;
        Sat, 18 Apr 2009 10:02:26 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.02.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:02:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116843>

This patch series introduces some very basic refactorizations and
improvements to send-email. My goal was to keep each patch relatively
small, but it may be better to look at the results of the following
patches:

	[PATCH RFC3.5 06/12] send-email: Cleanup and streamline the SMTP code in send_message
	[PATCH RFC3.5 07/12] send-email: Cleanup send_message 'log' code
	[PATCH RFC3.5 09/12] Docs: send-email: Reorganize the CONFIGURATION section

The overall diffstat:

	Documentation/git-send-email.txt |  201 ++++++++++++++++++++----
	git-send-email.perl              |  317 +++++++++++++++++++++++++-------------
	2 files changed, 376 insertions(+), 142 deletions(-)

The over all patch series:

	[PATCH RFC3.5 01/12] send-email: Cleanup the usage text and docs a bit
	[PATCH RFC3.5 02/12] send-email: No longer repeatedly test if $smtp_server is a command
	[PATCH RFC3.5 03/12] send-email: Interpret --smtp-server "" as "use a default".
	[PATCH RFC3.5 04/12] send-email: Verification for --smtp-server and --smpt-server-port
	[PATCH RFC3.5 05/12] send-email: Improve redability and error-handling in send_message's sendmail code
	[PATCH RFC3.5 06/12] send-email: Cleanup and streamline the SMTP code in send_message
	[PATCH RFC3.5 07/12] send-email: Cleanup send_message 'log' code
	[PATCH RFC3.5 08/12] send-email: Move Subject sanitization from --compose code to send_message
	[PATCH RFC3.5 09/12] Docs: send-email: Reorganize the CONFIGURATION section
	[PATCH RFC3.5 10/12] Docs: Embolden the CONFIGURATION references
	[PATCH RFC3.5 11/12] Docs: send-email: Clarification of sendemail.<identity>
	[PATCH RFC3.5 12/12] Docs: send-email: git send-email -> 'send-email'

Sincerely,
Michael Witten
