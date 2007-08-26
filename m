From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Sat, 25 Aug 2007 19:59:26 -0700
Message-ID: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 05:00:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP8MN-0003uj-F2
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 05:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933980AbXHZC7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 22:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933724AbXHZC7p
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 22:59:45 -0400
Received: from ag-out-0708.google.com ([72.14.246.244]:53932 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321AbXHZC7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 22:59:44 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2219002aga
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 19:59:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=ON9nvyzVsoco8DsegeVQKYrr1y9wbXAKrHm7bn8/hu7cjTonp5VvVFBSRdAvt7tt8hPQ35Pbd1ZGohIsdtuy/cwcljvSecD3i1pKmkpjTAIl+XTEu7D8+aHVgGQrBYVLRx4HXE0nVyK+33KezEdtcV814ouR9c6T7V6XATVVDo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=pHf9vleDGfNZGBxX9J0wy38KmcEjQUFkDqrkV4EI7yVzyAbDr1CDI+xkA+EXpMUXAPdsVKnsHZVNsTPMonctmg0irTi2X+bsrzaeCNJw/Q8PJF5QFc4OL06Zzp/tUw4h7kTaop8BfroPToJcg3U2bk2UKv8kUZQyVgo/wbq7iQU=
Received: by 10.115.109.1 with SMTP id l1mr1438262wam.1188097183470;
        Sat, 25 Aug 2007 19:59:43 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id v25sm5101003wah.2007.08.25.19.59.42
        (version=SSLv3 cipher=OTHER);
        Sat, 25 Aug 2007 19:59:43 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56667>

Git is using more and more .git* files to store metadata.
I have two comments on this:
1. It may be better to combine all these files into one (.gitmeta) with different sections
2. Storing metadata in regular source-controlled files feels wrong to me. I cannot be very specific why (call it intuition), but 
something inside me screams "bad design" :-). We've already seen some chicken-and-the-egg problems with crlf and .gitattributes. So, 
may be it would be better to keep this metadata only in repository (and index). One option would be to associate such a META object 
with every TREE (an make it optional). Then allow editing this object with something like 'git meta'.

- Dmitry 
