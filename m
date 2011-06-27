From: Stephen Schaeffer <stephenjschaeffer@gmail.com>
Subject: Subversion migration error
Date: Mon, 27 Jun 2011 11:15:57 -0400
Message-ID: <3B75A8BB-D6FF-44C8-ABB7-08117FBAA186@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 17:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbDXm-0004Ul-Oi
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 17:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab1F0PQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 11:16:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39056 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab1F0PQB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2011 11:16:01 -0400
Received: by iwn6 with SMTP id 6so4166534iwn.19
        for <git@vger.kernel.org>; Mon, 27 Jun 2011 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:to:mime-version:x-mailer;
        bh=+7ZMewqSVZ8vYKyZah/+IGNEI6S3eIMTwR0rLvgUanM=;
        b=xxkA09Df6Pnv/5H2NkK8/EqDDIOH8ex5pxTkUl34lERtY05wuhShdvjy6a3yBOxdFX
         /NsBDYf1u2lfugxkU5ALihWVAynBtP7q/hZW6AG6bTMSJ3DKDrTwUoozaY83ULhtRjkG
         qL0oUhQguT+j6ySqPRFPwH3TlHLZ4yGpKwd3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=DWv9iiyYpAFjWGm9wZICGYELQN3Xr1WCqPZwPj5X8SJvawryQMKqUxdbDIGozA9LZz
         QI98sxifQZ/eFpzgNCmDFYBVSGcFcfTOr/VqjU6cjr0ztu3+j8fXTNiV6gVMp1CoOFT2
         Kl2wISW0lyvzKU0pQhoqkUNECGMAyhC1stN1I=
Received: by 10.42.117.68 with SMTP id s4mr76112icq.387.1309187761121;
        Mon, 27 Jun 2011 08:16:01 -0700 (PDT)
Received: from [10.6.115.79] ([63.247.127.60])
        by mx.google.com with ESMTPS id w11sm3107544ibw.7.2011.06.27.08.15.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Jun 2011 08:16:00 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176348>

I am trying to migrate from a subversion repo on to a git one, and I'm having difficulties.

I am using the Mac command line client version 1.7.5.4, and issuing this command:

> /usr/local/git/bin/git svn clone https://[server]/svn -A svn.authorsfile --stdlayout --no-metadata


It downloads happily for 11611 out of ~27000 revisions, then dies with:

> Found possible branch point: https://[server]/svn/trunk => https://[server]/svn/branches/interface-controller-redesign, 11611
> Use of uninitialized value $u in substitution (s///) at /usr/local/git/libexec/git-core/git-svn line 1738.
> Use of uninitialized value $u in concatenation (.) or string at /usr/local/git/libexec/git-core/git-svn line 1738.
> refs/remotes/trunk: 'https://[server]/svn' not found in ''


It seems that I have a branching not covered in the --stdlayout that I wasn't aware of, but it would be nice to have a more graceful failure.
