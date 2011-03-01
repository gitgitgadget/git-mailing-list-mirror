From: Rick Bradley <rick@rickbradley.com>
Subject: problem with updating a shallow clone via a branch fetch
Date: Mon, 28 Feb 2011 18:12:21 -0600
Message-ID: <AANLkTinx01bzzLKk=DfyEvfSz8Hun-YqzJfEDpX7gNSS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 01:12:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuDCs-00088Q-Bm
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 01:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab1CAAMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 19:12:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42878 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab1CAAMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 19:12:43 -0500
Received: by fxm17 with SMTP id 17so4323604fxm.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 16:12:41 -0800 (PST)
Received: by 10.223.89.134 with SMTP id e6mr4362668fam.35.1298938361773; Mon,
 28 Feb 2011 16:12:41 -0800 (PST)
Received: by 10.223.72.208 with HTTP; Mon, 28 Feb 2011 16:12:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168168>

So I have a git repo that is shallow cloned:

  % git clone --depth 1 <repo url>

Sometimes (very rarely), when I do a branch fetch to update that
repository I get an error:

 % git fetch origin +refs/head/<branch>:refs/remotes/origin/<branch>

fatal: did not find object for shallow <hash>

There are only 3 mentions of this error on google, none of which are
enlightening.  The error is being emitted by receive_need(void) in
upload-pack.c.  The commit in question exists in the named branch in
the upstream repository, and I'm not aware that anything sketchy
(forced pushes, etc.) has gone on.  I'm going to continue to research
the history of the repo and the deployment, but I can't seem to get
any insight on what the error actually means (i.e., what conditions
would cause this error to be triggered).

Any help is appreciated,
Rick
