From: John Tapsell <johnflux@gmail.com>
Subject: More git bisect modes
Date: Thu, 5 Mar 2009 09:49:26 +0000
Message-ID: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAED-0001Ds-AW
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbZCEJt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 04:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZCEJt3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:49:29 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:21875 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZCEJt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:49:28 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4454013wfa.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Z/Y0Jlg4iXYvoodFXkYW5cLVKzblPmp2WaAH2YMM0iE=;
        b=JIRmTs1L9RpKHom8AjWRP5YauYH1Or1hlafDNI8Bka5IDbDdlQ1d7i8obOaJGq+s0B
         cke36O2f64KGjACQL7ZZBoSdDOC5enOWspSIbUYExYxLQGmgRQ5TAGSuCnNVxH34JvKs
         FfTBFHE5ceK6qpDpFqg5BLSVQahEcnUquUAFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Dc/eMontW1+VYOISbGg7+LQV5HMopynB1QvfVxWCF7qC7lHLib1WBE396fkYnQ7qLB
         wxEXZZI0m7SEQ0ufY6DBTjdUxMeajvQgr5x+TytxmTYCLSeH/h9vZX4g0jvedW4q7aQn
         zvUyCU9Ekh/AGHmku9u6/a6ArVG7iGDR8sWYs=
Received: by 10.143.31.11 with SMTP id i11mr438741wfj.289.1236246566139; Thu, 
	05 Mar 2009 01:49:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112280>

Hi,

  Although "git bisect" is called, well, bisect, it would be nice to
have other modes.

* A completely linear version - check every version.  Particularly
useful after rebasing to make sure all the commits still compile.
* An allow-for-mistakes-bisect.  This would use a bisection technique
that would allow for a minimum of 1 mistake when marking a commit good
or bad.  This point isn't particularly to help those with fat fingers,
but for bugs that are subtle and for bugs that are caused by multiple
commits.  (I can go into the details of how to do such a bisect
later).
* An exponential back-off.  Typically I know that HEAD is broken, and
I don't know when it used to work.  It would be nice to exponentially
go back through the commits to find the first working commit, then
bisect from there.


  Before I start working on the code for any of these, do people like
this?  Would this fit into the 'git bisect' command?

John
