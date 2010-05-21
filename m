From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 0/6 v3] Make git log --graph looks better with -p and other diff options
Date: Thu, 20 May 2010 18:52:38 -0700
Message-ID: <1274406764-32278-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 03:53:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFHQ0-00049I-C6
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 03:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0EUBwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 21:52:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33687 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab0EUBwt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 21:52:49 -0400
Received: by pwi5 with SMTP id 5so209656pwi.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 18:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=caDferUi7IfNyhLp3YFVS+LBi0Rtr/s60RdOhji2lC8=;
        b=QhFBZxNhWVAd6/6SWlmbwEjd+LhS2hHST5F+oiaAbSTY+/aVYg51h83rSFdqVIEhVE
         sdlpO2NS5ANWMeGFKNUrJlM3NnyzdL5jnsCClGnBkvekVtoebNinf4It6os8HgiSnKUu
         +vjpV6AhilLsgy3yuwcLJInmDmdfALFoqgMoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MgoeiLdRdiOAz/MkXRKMOGCeO+keA+Krt6/n9Tr+r6IiXjmTAnWjjQwQPgF7htfQpF
         ReQ8vVaxNNvZD8/3WEgL7pDnWpuoKoZ2xJ8TZyJqZLzScMwv9OtFMBdTltfVBIo57m0s
         kpNJYbjDhap7A9rZxVg3va5HKmHTWchSeUNi0=
Received: by 10.140.56.1 with SMTP id e1mr665745rva.136.1274406768735;
        Thu, 20 May 2010 18:52:48 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id o38sm442378rvp.12.2010.05.20.18.52.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 18:52:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147422>

Thanks to Jeff, make --graph work well with --summary.
And change the call parameters of output_prefix function, remove the unused FILE* and replace it with a diff_options.

Bo Yang (6):
  Add a prefix output callback to diff output.
  Output the graph columns at the end of the commit message.
  diff.c: Output the text graph padding before each diff line.
  Emit a whole line once a time.
  Register a callback for graph output.
  Make --color-words work well with --graph.

 color.c    |   21 +++-
 color.h    |    3 +-
 diff.c     |  379 +++++++++++++++++++++++++++++++++++++++++++++---------------
 diff.h     |    5 +
 graph.c    |   19 +++
 log-tree.c |    6 +
 6 files changed, 331 insertions(+), 102 deletions(-)
