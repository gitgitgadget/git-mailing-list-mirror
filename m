From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/4] workaround some Solaris sed issues
Date: Wed,  6 May 2009 13:29:13 -0500
Message-ID: <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 20:29:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1lsP-00049q-K3
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758479AbZEFS3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757638AbZEFS3c
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:29:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55568 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbZEFS32 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:29:28 -0400
Received: by mail.nrlssc.navy.mil id n46ITQJA016326; Wed, 6 May 2009 13:29:27 -0500
In-Reply-To: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 May 2009 18:29:26.0045 (UTC) FILETIME=[95BE64D0:01C9CE78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118368>

Here are 4 patches that I have been using to work around the issue that
sed on Solaris exits non-zero if it's input is not newline terminated.

The first two patches are signed-off-on and I think can be applied to
git.git.

The last two are kludges which Junio may not want to apply and maybe
someone has a better work around for.

Brandon Casey (4):
  t4118: add missing '&&'
  t4118: avoid sed invocation on file without terminating newline
  t/annotate-tests.sh: avoid passing a non-newline terminated file to
    sed
  t4200: avoid passing a non-newline terminated file to sed

 t/annotate-tests.sh            |    5 ++++-
 t/t4118-apply-empty-context.sh |    4 ++--
 t/t4200-rerere.sh              |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)
