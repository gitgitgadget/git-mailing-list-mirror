From: Jon Seymour <jon.seymour@gmail.com>
Subject: A system administration use case for git
Date: Wed, 22 Apr 2009 18:33:12 +1000
Message-ID: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 10:42:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwY04-0006J1-TX
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 10:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbZDVIij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 04:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbZDVIij
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 04:38:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:21820 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZDVIii (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 04:38:38 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1914983ywb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=WqgauOzdgq4K6ObRp/3RDmT51zG2a7SLHEN1M2kgX7k=;
        b=Mcvejji3GGkd2+OUOV1E36nrr5tdTCpOa/hm8WBb5gjvuyesxkWZ3YU96ZJxWx2cKM
         2P2xOBR9EHVZODgPulzr/MLyytd+EDSK9hu/fH1rr1dfnCtNTNi8pao2l73DGA6ppRP1
         T4kcUuPYKwvq/WwcqrPsK2wag5zZwKkG457b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JopkbXGnYN92ZuT7cYmBzS24QuLe9vd7gFQ/Qon+x564juYnnqgBFdGBmut8DyvoZE
         c1bU4RZY39+pN1AeK2PywLu00aCcUswYqQomDriBAUHRv5kkTquV86zSUQVSRP/EsUZg
         FgwfE9qOiIhiWa/eIU9PHQ7vwqDXbJixBaBfI=
Received: by 10.151.15.13 with SMTP id s13mr10186069ybi.156.1240389192210; 
	Wed, 22 Apr 2009 01:33:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117182>

Hello all, it's been quite a while.

And, no, I don't care that you ripped out git-rev-list --merge-order,
it was fun while it lasted and it was still a cool  (if under
appreciated)  algorithm :-)

I've got a system administration use case that I know git does 99.9%
of. I am wondering if the last 0.1%.

It'd be nice to do this on arbitrary (non-git-controlled) file system tree:

* calculate the git hashes of the tree (without making copies of the
files in the tree)
* archive the tree hashes
* rsync the tree hashes to another place
* work out which files aren't available in the other place's git repo
* rsync those files the the other place

Is there a way to easily achieve this with git's existing tool set or
a higher layer?

jon.
