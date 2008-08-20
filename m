From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH v2 0/3] Verbase branch command
Date: Wed, 20 Aug 2008 21:00:38 +1000
Message-ID: <1219230041-7998-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVlRv-0005a6-Qn
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 13:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbYHTLAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 07:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbYHTLAy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 07:00:54 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:50318 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYHTLAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 07:00:53 -0400
Received: by yx-out-2324.google.com with SMTP id 8so181865yxm.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 04:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=Cgk9wjnfeXlsvTRtPcdQFj9uy7TBPn4T2DSdBAPFiWs=;
        b=Xo6u9+yEzoo3gtC2oVAjiax1kxGBbK7/vFyIlU4HKq/JfWrsz3f/oqUiRES9P4ZgKZ
         FVqdrY7MUK8bN1B6zPw77I/tFLaXwb5WyGZtBQygN/d4wChW4r3IkOtt4TIRPTErRqCN
         /0LPFNSXlRA8W3eaNAEzEZXr9c/iYehV+ukLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=agMOE0Y0wTGK4IUXpgsQ9cNK7tRNkQMWdqrIG8DfYYxEJzVQlvzsrNJcl99zVMW9FN
         F4vtHEGev+qP6tma62TpTyS+PvBq0ywx1qiZkX60MaaNBnFaVbjg/+6/URdVll86Yhe1
         vDg26OwvSFb4d0LwVpYrJqaPQTAbx+9gzIB2U=
Received: by 10.114.178.13 with SMTP id a13mr7718928waf.182.1219230052050;
        Wed, 20 Aug 2008 04:00:52 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id n22sm2340253pof.3.2008.08.20.04.00.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 04:00:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.g2ebc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92975>

Verbose branch listing added for the sake of completeness.

This probably doesn't need a cover letter. The only difference with the
previous patch is the '/' fix and to add 'final' where safe to do so.
That is to say I only added final for lines modified by this patch.

Charles O'Farrell (3):
  Extract RefComparator to sort collection of Refs
  Cleanup of Branch command ready for verbose mode
  Verbose branch command

 .../src/org/spearce/jgit/pgm/Branch.java           |   61 +++++++++++++----
 .../src/org/spearce/jgit/lib/RefComparator.java    |   72 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefWriter.java        |   14 +----
 3 files changed, 121 insertions(+), 26 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java
