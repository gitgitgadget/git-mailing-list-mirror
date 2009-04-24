From: Scott Chacon <schacon@gmail.com>
Subject: Extra metadata in the commit?
Date: Fri, 24 Apr 2009 15:47:55 -0700
Message-ID: <d411cc4a0904241547p64c0af2bycae20cd4b26e43f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:49:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUD4-0000dT-CN
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbZDXWr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbZDXWr4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:47:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:40703 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbZDXWr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:47:56 -0400
Received: by yw-out-2324.google.com with SMTP id 5so815958ywb.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/bokU13nN9Icv0uP9Xj1gfCBycrQwkFfa699I6sU5T0=;
        b=DHtfyv6CtvXBzrx3Ufqr6i+UF0ta/bLejxYTQABa6TBCJwbqbmREXGjpqFc2Xe1SoJ
         9pPM8FNKRV/hZL8a4ooo3hip3+RlSnLYQpvRiCzkyF1wJd2eAfKtLWX3rte8tJJBZ6Fo
         Ua3DCj2L6Sd0W0eY/k+Koy5+T4fPl0Bi52i0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dN+SojLatsO7Stk3sqdpgu9J88xVvNcaLAR6myi47Vx1uUJymFBaXBlcW+USXcTk0c
         FUhbXk4JYJzlcwojS97zPmK3M1PNWho525n03ic5xRlXx795GUfzhuYe+mcw4GOOHME8
         mb0FNt9iUT3oxULYC8y+2IQLLc3zC6moND1LY=
Received: by 10.90.65.5 with SMTP id n5mr3226415aga.111.1240613275222; Fri, 24 
	Apr 2009 15:47:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117508>

Hey all,

I'm working on a hg<->git bidirectional tool using Git as the
communication protocol, so there is a bunch of Hg metadata that I need
to keep in Git to ensure I can convert commits created in Hg back into
the exact same objects after they upload to the Git db and then come
back down.  This means storing explicit rename info, branch names, etc
somewhere without messing up Git clients that want to work on the same
repo.  So, I can keep this data in the commit message, but I thought
it would be cleaner to keep it as extra fields in the commit object
before the "\n\n" separator.  Before I go too far down this road, is
there anything horrible that might happen in any of the core Git tools
if extra data is there?

Thanks,
Scott
