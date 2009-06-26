From: Gregory Jefferis <jefferis@gmail.com>
Subject: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 11:28:11 +0100
Message-ID: <C66A614B.205E4%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 26 12:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK8fW-00013d-6D
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 12:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZFZK2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 06:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbZFZK2R
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 06:28:17 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:35962 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbZFZK2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 06:28:16 -0400
Received: by ewy6 with SMTP id 6so3181196ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from
         :to:message-id:thread-topic:thread-index:mime-version:content-type
         :content-transfer-encoding;
        bh=MoSvUw6nJzY2bk4w7In1sXG28A0BWyOOXIzaaGszTow=;
        b=DJITygeK13Lm1JBC/8H1Z4euww0t+Ttu3TrOcrgEuwIQoGEH8spxAZ4wgfDGAcvJ/G
         XXsQQEFDg32YRNEZ1JZ8I3g9SWFVcLWWNzupBrtToJygx3/kqCYOHrMQjT4pZbwDQqFU
         nhR15ZMUlFRum6L5Q1xGWnR+HsFeaAQrLJ2SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:message-id:thread-topic
         :thread-index:mime-version:content-type:content-transfer-encoding;
        b=JWiZgwK43hDZ1Ylykj2luaQ1GJM9ayPw18ryiyTQYCr+CWOMafl3rrvBga3uS9DBBv
         wZHgNqyIJqNZtln5ETqRKEeTl/OCpwmFLqQE/EmzHggfgqzYTuH8AJUCb083P14qw+C+
         hiNXfAvYUjsOXFxP2y98StUzL+XnxDPUNQ8LI=
Received: by 10.210.17.14 with SMTP id 14mr4103412ebq.81.1246012099065;
        Fri, 26 Jun 2009 03:28:19 -0700 (PDT)
Received: from ?10.6.0.183? (nat.mrc-lmb.cam.ac.uk [131.111.85.79])
        by mx.google.com with ESMTPS id 7sm1310685eyb.35.2009.06.26.03.28.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 03:28:18 -0700 (PDT)
User-Agent: Microsoft-Entourage/12.13.0.080930
Thread-Topic: Choosing a mergetool according to file type
Thread-Index: Acn2SM3x3kzYSgUiLkuzjOiE5I5p+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122288>

Dear all, 

Is there a way to specify which mergetool is called for different files in a
repository in the same way that one can specify a diff tool using
.gitattributes?  I would like to use a custom mergetool for certain binary
file types (MS Word dare I say it) but stick with my standard tool
(FileMerge.app) for regular files.

I have set up custom mergetool and diff commands in .git/config:

[mergetool "wordmergetool"]
   path = /Users/jefferis/bin/
   cmd = wordgitmerge "$PWD/$REMOTE" "$PWD/$BASE" "$PWD/$LOCAL"
"$PWD/$MERGED"
[diff "wordgitdiff"]
   command = wordgitdiff

# adding the following to gitattributes handles the diff case
*.doc diff=wordgitdiff

# but of course this doesn't alter the mergetool that is called.
*.doc mergetool= wordmergetool

Many thanks for any suggestions,

Greg.

git version 1.6.3.2.202.g26c11
MacOS X 10.5.7

-- 
Gregory Jefferis, PhD
Division of Neurobiology
MRC Laboratory of Molecular Biology,
Hills Road,        
Cambridge, CB2 0QH, UK.

http://www2.mrc-lmb.cam.ac.uk/NB/jefferis_g
http://www.neuroscience.cam.ac.uk/directory/profile.php?gsxej2
http://flybrain.stanford.edu
