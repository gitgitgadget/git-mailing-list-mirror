From: "Mike Coleman" <tutufan@gmail.com>
Subject: suggested feature: completely expunge a file (or just a delta) a la rebase
Date: Thu, 26 Apr 2007 00:48:28 -0500
Message-ID: <3c6c07c20704252248q3cd82d4cgcffb9852fa261a70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 07:48:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgwqI-0006vg-KC
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 07:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbXDZFsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 01:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbXDZFsa
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 01:48:30 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:47672 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741AbXDZFs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 01:48:29 -0400
Received: by an-out-0708.google.com with SMTP id b33so114030ana
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 22:48:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U/Ri2BI0qk+XVKVpEhzPKeASqUnHGouq1yGfBks3p0xgasBocKOcIybjEZY5DHNSKJjYkbNFkQBQV1H8wiU8MI5rqx29c1g3AoE41o4sf3jJfd+OtoRErupOvDX60SL6g2F0YUp8kPbRGiLsHQ3JwO3M6S3L8CmfTfkbKScGbtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KV3JiLVLRK/unxIv4R4j5sOSyXY+9JQ+VeLc14sTY9oUN2w93jn1yV7CnH3p2bXxE9HL5nco0sYge/XhrmObCIgbeuto+ARrFDb2sKeS5Bp62EgkR8tkQQdlgkm+k1iyn3hNWtKL7f48XIk2G+Ykovcf8R9HYERKZCRftkyEvLs=
Received: by 10.100.163.12 with SMTP id l12mr824828ane.1177566508372;
        Wed, 25 Apr 2007 22:48:28 -0700 (PDT)
Received: by 10.100.131.10 with HTTP; Wed, 25 Apr 2007 22:48:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45611>

Here's an idea for a git feature.  (Or perhaps this is already
possible and I just don't see it.)

It would be nice to be able to completely expunge a file or delta from
a private part of an archive ("private" meaning not yet published to
others).

Here's my use case.  I have some unit tests for my program, and I
added some input and output for the tests to my git archive.  Now I'm
having second thoughts, as these files can be quite large, and I'm
realizing what this implies with respect to git.  Even the smallish
test cases I checked in are 5-10MB, which is way larger than the
codebase, and I'm not sure it makes sense to drag all of this around
in the git archive.  (Maybe it would be appropriate to put them in a
parallel archive?)

Anyway, I realized that hacking the archive this way isn't very
elegant, but maybe others would find it useful.  It seems like the
basic technique of git-rebase could be applied here.

Even if the archive is already public, I suppose it might occasionally
be useful to be able to (say) split the archive by subtrees, and
simply have everyone cut over.

Mike
