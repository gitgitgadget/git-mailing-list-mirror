From: Mike Stump <mikestump@comcast.net>
Subject: cherry picking and merge
Date: Thu, 31 Jul 2014 17:58:17 -0700
Message-ID: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 02:58:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XD1B2-00061m-QA
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 02:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbaHAA63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2014 20:58:29 -0400
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:60850
	"EHLO qmta15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751344AbaHAA62 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 20:58:28 -0400
Received: from omta23.emeryville.ca.mail.comcast.net ([76.96.30.90])
	by qmta15.emeryville.ca.mail.comcast.net with comcast
	id ZCeT1o0021wfjNsAFCyTJk; Fri, 01 Aug 2014 00:58:27 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta23.emeryville.ca.mail.comcast.net with comcast
	id ZCyS1o00X2ztT3H8jCyTvS; Fri, 01 Aug 2014 00:58:27 +0000
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406854707;
	bh=LsATdoiOKsgP2GzXEl0C2LSG4HIbcsJyrszfKMae1RE=;
	h=Received:Received:From:Content-Type:Subject:Message-Id:Date:To:
	 Mime-Version;
	b=RzjnxaJMHQQMjnhJULpihZM6xo6LZwGuSUzHdr3Z61GfqYAAy53VY7ty1ZbRgvJHn
	 Uk/YsPNlrn+hIWnNvpCkp/HqhoDqDEYFl86c4Lpi179m83JkgpJTR+BMhnA7/H587D
	 elWNZ28zS0YeiYN3mocejsqUigdnorQmLHZSKsjGnFKCSNvQzErSttOk6UAQ4tzXK4
	 4a5px4eiapXSd6BGWGsvBfF6xzUJDUp6SLQ3rmMLo7kUvDu2T7rRnFTP1Yyi8Mxnz7
	 cfQMaHR/0SOWUl5LC2qCCA2VX33/ZWb1iAxsVJc2cs4PoN4jHIG2NQhfZl+G1nnC3V
	 rmKGGPWi5fbsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254617>

Cherry picking doesn=92t work as well as it should.  I was testing on g=
it version 1.7.9.5.

Put in a line in a file, call it:

first version

then cherry pick this into your branch. Then update on master and trans=
form that into:

second version

then, merge that branch back to master.  Death in the form of conflicts=
=2E

In gcc land, I do this sort of thing all the time, and I need a merging=
 subsystem to actually keep track of things.  I can manage this will di=
ff and patch and it works flawlessly.  The point of using something bet=
ter than diff and patch is for it to be better than diff and patch.

I=92d like for merge to merge in the work that has yet to be merged.  N=
ot that, plus blindly try and apply or reapply cherry picked items.