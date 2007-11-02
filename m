From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git rm --cached
Date: Fri, 02 Nov 2007 17:41:40 -0400
Message-ID: <20071102174140.vobtdjxfwsgoc040@intranet.digizenstudio.com>
References: <20071102021711.GA28703@fawkes.hq.digizenstudio.com>
	<87mytwiq1f.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 22:42:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io4H6-00031I-SY
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 22:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbXKBVln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 17:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbXKBVlm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 17:41:42 -0400
Received: from k2smtpout04-01.prod.mesa1.secureserver.net ([64.202.189.166]:57820
	"HELO k2smtpout04-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754267AbXKBVlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 17:41:42 -0400
Received: (qmail 28421 invoked from network); 2 Nov 2007 21:41:40 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout04-01.prod.mesa1.secureserver.net (64.202.189.166) with ESMTP; 02 Nov 2007 21:41:40 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id C016310007A;
	Fri,  2 Nov 2007 21:41:40 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 635VmBkK1px1; Fri,  2 Nov 2007 17:41:40 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id 0F04E10008A; Fri,  2 Nov 2007 17:41:40 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Fri, 02 Nov 2007 17:41:40 -0400
In-Reply-To: <87mytwiq1f.dlv@vanicat.homelinux.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63179>


Quoting Remi Vanicat <vanicat@debian.org>:

> Jing Xue <jingxue@digizenstudio.com> writes:
>
>> In the following scenario, why do I have to run 'git reset' following
>> 'git rm --cached 1.txt' to revert to exactly where I was before 'git add
>> 1.txt'?  Shouldn't 'git rm --cached' have done that already?
>
> Observed behavior are exactly what I expected: 'git rm --cached' mark
> the file in the index as been deleted without deleting it in the
> working directories, it did not but the index it was before the
> 'git add 1.txt'.

I was confused by two things I guess:

1. I looked at the "index" as a staging area for _changes_ not files  
themselves. So where 'man git-rm' says '--caches ... remove[s] the  
paths only from the index, leaving working tree files.'  I took it to  
mean that it removes the changes on those paths, rather than staging a  
new "path deletion" action for a later commit.

2. The FAQ entry "Why 'git rm' is not inverse of 'git add'" says "a  
natural inverse of 'add' is 'un-add', and that operation is called 'rm  
--cached',..."  Now I realize that only applies to adding a new file,  
but not changes on an existing file.

> You probably want to use git reset HEAD -- 1.txt to unstage
> modification on 1.txt

Sure.

Thanks.
-- 
Jing Xue
