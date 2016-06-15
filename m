From: Brian Lalor <blalor@bravo5.org>
Subject: bug: compactionheuristic config var case issue
Date: Wed, 15 Jun 2016 06:39:32 -0400
Message-ID: <8C006106-EED2-48B5-B9A5-6FCEB64597C1@bravo5.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 12:39:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD8EV-00009e-JD
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 12:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbcFOKjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 06:39:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60571 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753203AbcFOKje convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 06:39:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A122120DA5
	for <git@vger.kernel.org>; Wed, 15 Jun 2016 06:39:33 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 15 Jun 2016 06:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=PHFwHDAx5HmxGNHhOVIbGsXS+xI=; b=cP9Dk
	ju2aXClDEboPz1mJDuX+C03J8A9AFFAKtqWEqFDFMz5P/jkpb7tcb4B0dHfeFZrC
	4J5LSajiflaZkwLBLhiuBaBOHCPVTjfqP9aTsmIJGBvDx/AQ7Y2GD32Uz1fT/hlF
	G809l7ZsT14gLaT1i2DfNk2Tqsx7+hxaVg5L+g=
X-Sasl-enc: 9rF0StY2RujUFx983B/GbE22j5NzbXE9gWb9l8Wwfstt 1465987173
Received: from [192.168.1.209] (pool-74-110-148-216.rcmdva.fios.verizon.net [74.110.148.216])
	by mail.messagingengine.com (Postfix) with ESMTPA id 56B1BCCDAB
	for <git@vger.kernel.org>; Wed, 15 Jun 2016 06:39:33 -0400 (EDT)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297364>

I=E2=80=99m very happy to see the new compaction heuristic option; it=E2=
=80=99s the way I always thought diffs should read! =20

The config option in the documentation references =E2=80=9Cdiff.compact=
ionHeuristic=E2=80=9D, but diff.c does a case-sensitive comparison on =E2=
=80=9Cdiff.compactionheuristic=E2=80=9D (note the case of the =E2=80=9C=
h=E2=80=9D in =E2=80=9Cheuristic=E2=80=9D) and `git diff` does not hono=
r the config.  Confusingly, `git config diff.compactionheuristic` retur=
ns true when diff.compactionHeuristic is set in ~/.gitconfig.  When dif=
f.compactionheuristic is set to true in ~/.gitconfig, the desired behav=
ior is achieved.

Thank you all for Git: it=E2=80=99s hard to remember the terrible world=
 we lived in before it existed. :-)