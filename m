From: Henning Moll <newsScott@gmx.de>
Subject: filter-branch performance
Date: Tue, 09 Dec 2014 19:52:33 +0100
Message-ID: <548744F1.9000902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 19:52:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyPto-0005hn-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbaLISwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:52:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:57155 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbaLISwg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:52:36 -0500
Received: from [192.168.178.27] ([88.217.119.62]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LanoO-1XaOk61bbc-00kQYa for <git@vger.kernel.org>;
 Tue, 09 Dec 2014 19:52:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Provags-ID: V03:K0:2nAPdOkzYV/Sn5nk+mG1dz6wxwZhwOy3043lOUIsOe2xFgWk8/C
 siQpslCr4KCMoewgByOLAMTsPjeFYXXgZ9urpxePsV8TlLLV8JypwUqm7Vp/FDzjPGy01aB
 3XslAKLD+eBctgjGTTnz2wSzsLaJblpavp9VRGfN1mkIOecBkseoqURk7KORiyCNEb8I3L8
 bqilWKyyEmoAU1xPbtFDQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261140>

Hi,

i am runningthis command

git filter-branch --env-filter 'export 
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL" 
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME" 
GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"' --prune-empty --tag-name-filter 
cat -- --all


in a repository which i copied to /dev/shm before. According to "top", 
the git process only consumes about 5 percent of the CPU. The load is 
between 0.70 and 1.00.

I assume that there is a lot of process forking going on. Could that be 
the cause?

Any ideas how to further improve?

Best regards
Henning
