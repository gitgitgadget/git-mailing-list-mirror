From: Jon Seymour <jon.seymour@gmail.com>
Subject: RFD: should git rev-parse exit with non-zero status if ref@{n} is not valid?
Date: Wed, 18 Aug 2010 21:36:11 +1000
Message-ID: <AANLkTi=Ktz=ARx0qUqB0844aYuq8BbqYUM8g726r9o5t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 18 13:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olgwc-0002EV-2z
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 13:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab0HRLgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 07:36:14 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50653 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0HRLgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 07:36:13 -0400
Received: by qwh6 with SMTP id 6so389378qwh.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=7Q6nT7LiuQSSxGrDVeAFUcKumN2khO6xhdoBQ53WZ38=;
        b=FRYWOT+D8U3Nyn5krebpx19pyfxkOL4FMP1TP/cmUVLkWUatmGFrEAeuDHTx+wqOy/
         pDUcwa850BApAVtPgLYufQ80t3bl6vVMnrhyYdFLRLQPh2JGmlaG3dg8+ZZhR8K8t2VU
         Q+AX5WWPpDxHEzaM2MsttK1H+7l0sia+G6Fgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tLOzVW5lAvvwhWuAEmx1LbfieFm44jutEglNXu2tD61Liv3+4LtOqIQPk+1UdL1ZzY
         g+FsBZ19CkYlrRmR6t5oPWeHTu047GeNZkSUgGuMnQ5SOZMtTlUs5mCdvrUOId6yssGK
         tEJ4w6V+VQ5Vv8so7W+AUg7xXRZOWLDHyJsuY=
Received: by 10.224.6.145 with SMTP id 17mr5309595qaz.130.1282131371739; Wed,
 18 Aug 2010 04:36:11 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Wed, 18 Aug 2010 04:36:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153830>

While reworking my detached-stash topic, I noticed that git rev-parse
ref@{n} will exit with a warning message on stderr, the SHA1 of ref
and a non-zero exit code if ref exists, but ref@{n} does not.

I understand why ref@{time-spec} might behave this way, but I reckon
that if you ask for ref@{n} for n > N-1, where N is the length of the
reflog, then you should either get empty output and a non-zero status
(preferred) or a ref@{N-1} on the output with a status code of zero
and a warning message (less optimal, IMHO).

What say the list?

jon.
