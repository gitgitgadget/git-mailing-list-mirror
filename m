From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Git GUI vs interactive post-commit hooks
Date: Mon, 19 May 2008 14:48:14 +0400
Message-ID: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 12:49:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy2vT-00015o-2F
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 12:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbYESKsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 06:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755518AbYESKsQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 06:48:16 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:2972 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbYESKsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 06:48:15 -0400
Received: by py-out-1112.google.com with SMTP id u52so1807527pyb.10
        for <git@vger.kernel.org>; Mon, 19 May 2008 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=TnqrVQwc/vJsEW3DVMtM9ZTi0P9i/fASVUdDXzBz3C4=;
        b=hQUT6pdvy4thUH9fScNUNIGIXgry1fEGNbRR0dzAepI4JKUOtEih/SpFmaNOeCAvnqMFLblOLU4xrghCqFr0fVuDKKLkhYVSHmnpmJ7GspNqlGfg1C1FWU3WWbg4RcmrdLAtlHQEQ+tpsFWKDebgYVLsqk5NvY3o+xBDJ2VTlpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MNXnq1XRSpug3OLKBIC9b487C+xDGqwYysUdqBzF04pDWaielBP0yCNqFICMTWJ7+ppbnLoXd43Yn6XlaoLOAP+KPm836nxLQRSE6WAlXyQqTz/5P/eQ5ANMVmGYeAOWomRmy4pK9TqiUIPH+H/eF24myeZ7pK4L022NlqHnTIs=
Received: by 10.114.182.1 with SMTP id e1mr7309253waf.154.1211194094383;
        Mon, 19 May 2008 03:48:14 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Mon, 19 May 2008 03:48:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82424>

Hi, list!

$ git --version
git version 1.5.5.1

I have a post-commit hook which does backups for me:

  username=agladysh
  for name in `git branch | cut -b3-`
  do
    remote=$username-$name
    echo pushing $name as $remote
    git push backup +$name:refs/heads/$remote
  done

The backup repo is behind ssh. Recently I have put password on my ssh
key and post-commit hook ask me for password once for each branch.
This makes unhappy commit process from Git GUI -- after I shut it
down, there are multiple ssh key password prompts in the shell from
where I launched it, and it does not display any input I enter.

Any advice? I do want to input password for my key each time I use it.

Thanks in advance,
Alexander.
