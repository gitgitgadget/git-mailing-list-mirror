From: "=?ISO-8859-1?Q?Eirik_Bj=F8rsn=F8s?=" <eirbjo@gmail.com>
Subject: Efficient retrieval of commit log info
Date: Wed, 12 Dec 2007 15:36:15 +0100
Message-ID: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 15:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ShV-00037Z-TU
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 15:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbXLLOgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 09:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXLLOgR
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 09:36:17 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:64148 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbXLLOgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 09:36:16 -0500
Received: by py-out-1112.google.com with SMTP id u77so667530pyb.16
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 06:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=gaUl+u2EVGlzYONSY99RMbtCesR41bkhsff2uMF6d7s=;
        b=uoR6ZMClfmlVx4n9qfFU855ddDHIqfh45N7wHer9lysGBC2p/Kpti+IxfC6jO8SryW1bLMrKJhKajkGlu8gO/6AZ9avZmNvQnEkP7DQV9I0lrj/l0fIBAEUkcPloO4J+Bx5aE+sBPBDDP42ykmEHdw1Dnkp1hv+2yWUdCLbY4Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DF9KgOFgkPSKOBN8dY4T0mJ8goUZCtUZ89zskvwGReNRUb3IgLBmtPLCM6r0c/YEMJx6CmBAQU0o7RnaX1NTg4LMHele3z6XgqVAZg+7OHUSuYAR7qcg+Xtqh8p4OMyRfH1hLZDglIAZCXhsE1a+0laEZYZVNr3vbLIAfJL+hTk=
Received: by 10.140.177.15 with SMTP id z15mr372396rve.110.1197470175333;
        Wed, 12 Dec 2007 06:36:15 -0800 (PST)
Received: by 10.140.207.1 with HTTP; Wed, 12 Dec 2007 06:36:15 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68040>

Hi,

I'm developing a piece of software that grabs logs from various types
of SCMs and presents (hopefully) useful information about the history.

My current approach with Git is do a "git clone --n" and then parse
the output of "git log". To check for updates I do a "git pull"
followed by a new "git log".

This approach works fine, but cloning the whole repository just to get
the change log seems like a somewhat inefficient use of bandwidth and
storage.

What I would like to do is to fetch just the change log information
from the remote repository.

(Using the "CVS done right" tool I can do this with: "svn log --xml -v
-r<last, HEAD> http://svn.example.com/")

I haven't found a way to do this using the Git command line tools.

Is it at all possible using the git network protocols to fetch just
the commit log info, without transferring the contents?

I'd be happy to hear from anyone who has some insight into this.

Thanks,

Eirik.
