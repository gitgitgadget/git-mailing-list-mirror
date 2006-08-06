From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: git-fast-import
Date: Sat, 5 Aug 2006 22:51:28 -0400
Message-ID: <9e4733910608051951g42bc4a5dv560c12e0a9add163@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 04:51:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Yjl-0006II-4h
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 04:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWHFCva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 22:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWHFCva
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 22:51:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:39832 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751494AbWHFCva (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 22:51:30 -0400
Received: by nf-out-0910.google.com with SMTP id k26so72052nfc
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 19:51:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DpcbuRFqHLjwRhaHPmd47rtQQ0IfMJrIouMt4NdOY7MJIctd0MDN4wdsqQMLtF1hBkoeRVO2gtei1emvM+n0z4yiMLtNwugk+C9hrWFARmueVpRbyO7b+8nuNB5YucYvJMihX55UuM0ar3wy0VKc8QHro5caqhkhJuJMXK5rtKU=
Received: by 10.78.175.14 with SMTP id x14mr2032616hue;
        Sat, 05 Aug 2006 19:51:28 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sat, 5 Aug 2006 19:51:28 -0700 (PDT)
To: git <git@vger.kernel.org>, "Shawn Pearce" <spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24954>

git-fast-import works great. I parsed and built my pack file in
1:45hr. That's way better than 24hr. I am still IO bound but that
seems to be an issue with not being able to read ahead 150K small
files. CPU utilization averages about 50%.

I didn't bother reading the sha ids back from fast-import, instead I
computed them in the python code. Python has a C library function for
sha1. That decouple the processes from each other. They would run in
parallel on SMP.

My pack file is 980MB compared to 680MB from other attempts. I am
still missing entries for the trees and commits.

-- 
Jon Smirl
jonsmirl@gmail.com
