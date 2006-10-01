From: "Matt McCutchen" <hashproduct+git@gmail.com>
Subject: Multiple checkouts of the same repository
Date: Sun, 1 Oct 2006 15:03:24 -0400
Message-ID: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 01 21:03:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6bG-0004Ap-Q0
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 21:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWJATD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 15:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWJATD1
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 15:03:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:45672 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932214AbWJATD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 15:03:26 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1354098nfa
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 12:03:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=toe/HEQen3kzUKNgZ69SYjYHpsnQb9bS/B+/CpLdZvihSa876ihm6fTk1xq9mUdVvNhhyE5VaMKMp1i5OT1RvkdX4/7B9e7VGm0GyHERwSxpPTLYVQtseJX2Lq1gD7yw1QxezGVMInuq3BM7s8k+SCGFbXZnw5yPnTY5YfDYJCU=
Received: by 10.82.131.1 with SMTP id e1mr112657bud;
        Sun, 01 Oct 2006 12:03:24 -0700 (PDT)
Received: by 10.82.128.10 with HTTP; Sun, 1 Oct 2006 12:03:24 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Google-Sender-Auth: eac6b07ceb4a7ed0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28190>

Dear git people,

Maybe this is common knowledge, but I thought I should mention it in
case it isn't.  I had a git repository in a directory A and I wanted
to check out a branch of the repository to a different directory B.
So I created B/.git and filled it with symlinks pointing to the files
in A/.git, except for index and HEAD because those need to be
different for each checkout; then I ran git-checkout <branch> to fill
B.  Now I can view and edit each checkout independently, but they are
backed by the same set of objects and refs.  However, I must remember
to commit to each branch only through the checkout whose HEAD is
linked to it, otherwise that checkout won't get updated.

Matt
