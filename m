From: Dale Rowley <ddrowley@gmail.com>
Subject: rebase --continue confusion
Date: Sat, 29 May 2010 18:59:01 -0600
Message-ID: <4C01B855.7080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 02:59:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIWs4-0004Iu-S1
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 02:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232Ab0E3A7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 20:59:14 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:47963 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160Ab0E3A7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 20:59:14 -0400
Received: by pxi18 with SMTP id 18so1031294pxi.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 17:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=yBuH6hdB6N1o0UFGqYfWxxVpQBv/pQi/KOKDr4F+b3Y=;
        b=otKXktszw8j8sKAICW4OTdZGWk94Y1stsOjJeQ1kadwuEksGOgHntC40x6kvcD8CaJ
         GaNu/XvuRf8r7N4o8PxQ1F6GU88CW5w7Qx6Zu0q72NumY8ZTUcWJiEwp+Ho4qqFPgV5Y
         XG75UdEVMJDLrfkw1vqyi9fmNPCEycIHawHbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Cc2ZBeXY4fnQ8kAjHL1UzvSLIOoGxbtBFp4ifZCwGaJweOPWacCYvDt8bfUrToZZ32
         2PdXDfmlVrJKIs/tb98mpcEt5mOD077+vgGXoXXmMRGDVmXZOSMllBiwKn8xQphUod2L
         g9tOcyv5uJWp2IEL75hHWZG4En5hZd/MOkE8U=
Received: by 10.141.105.12 with SMTP id h12mr1838566rvm.112.1275181153606;
        Sat, 29 May 2010 17:59:13 -0700 (PDT)
Received: from [192.168.2.3] (63-227-2-176.hlrn.qwest.net [63.227.2.176])
        by mx.google.com with ESMTPS id b1sm3262740rvn.14.2010.05.29.17.59.11
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 17:59:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100411 Thunderbird/3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147980>

I ran into a conflict while running 'git rebase branch1 branch2'. So I edited
the file and resolved the conflicts, and then ran 'git add <file>; git rebase
--continue'. This printed out a message 'No changes - did you forget to use git
add?'. I thought 'No, I'm pretty sure I ran git add' and I assumed I had run
into a bug in git because I didn't see how this conflict was different than any
others I had successfully resolved. The next time this problem came up, the
light finally came on and I realized that I should just run 'git rebase --skip'
because when I resolved the conflicts, I had basically undone all changes that
the patch would introduce.

OK, so there isn't a bug in git, but since then I've seen co-workers stumped by
this same problem. So maybe it would help to clarify the message? Maybe
something like "The index is in the same state as it was before the patch was
applied - refusing to make an empty commit. Did you forget to use 'git add'? Or
maybe you should use 'git rebase --skip'?"


Dale
