From: "Peter C." <th3flyboy@gmail.com>
Subject: [GSOC 2012] Some questions regarding a possible project to improve
 big file support
Date: Sun, 25 Mar 2012 16:48:09 -0400
Message-ID: <4F6F8489.20108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 22:48:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBuMM-0006rJ-LY
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 22:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051Ab2CYUsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 16:48:13 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34596 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757027Ab2CYUsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 16:48:13 -0400
Received: by qaeb19 with SMTP id b19so1826499qae.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 13:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=4DkzuagGenfFZpiop9BYvXGY7e3H58agmJ7/bOiH2XI=;
        b=MTWJmJ7iPoC1cHJhSZGCH171SDKi3J8tYhO/yhA6YKXFxq0e2sbWFJKrssJYl8ICZ5
         fEnRvsVqPTG/B4+34LFxS4mH8L445lX5D+xV6jVv30S8iprFe96Fg8Hf5l7hLncGxcUF
         AuboUvNLySmt+dvHuTf5morZZFQNwjLvyiC6PmUnmupePRG3QZ+iqoRZHgDlkDLojRwz
         Cg/WyHiGDSaXnxD3bV2UfpMx3MvBXqdfnunaZGlkaIdWBcOYqEhkoX7VcWh7raabUDMA
         gX97fuF6ROE1OF0K2+vMIGc8wruB/IATR9kpOux1++puaR2cD14pE/Nn2QEAJ1BTfu2G
         f7Pw==
Received: by 10.224.223.76 with SMTP id ij12mr24973736qab.11.1332708492587;
        Sun, 25 Mar 2012 13:48:12 -0700 (PDT)
Received: from [127.0.0.1] (c-71-204-217-209.hsd1.de.comcast.net. [71.204.217.209])
        by mx.google.com with ESMTPS id dw1sm26305251qab.4.2012.03.25.13.48.11
        (version=SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 13:48:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193883>

Hello, I'm considering working on Git for GSOC 2012, specifically in
improving big file support, however I wanted to ask a few questions
first, some about the low level operations of how Git handles diffs
between files, and also a question or two regarding implementation.

My first question is more of a question regarding low level
functionality of how Git diffs files. The question is, in the diff
process, does git just parse the file and see if there are diffs, or
does it use something like hashing to first tell if the file has been
modified at all, and then go to the diff process if the hash is
different. An extension to this question is, in Git's internal database,
does it set any kind of flag to say that a file is a binary if it is one.

My thought process in implementation involves checking the hash, and if
the hash is the same, skip it, if the hash is different, check the MIME
type possibly using libmagic, and if it matches a known binary format,
then just commit the new version, rather than trying to run a whole diff
and load the whole file in the process.

The thing I'm worried about is, would anything involved in this break
existing Git functionality, or backward compatibility. I'd also greatly
appreciate any feedback on my ideas.

Thanks,
Peter
