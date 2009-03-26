From: David Reitter <david.reitter@gmail.com>
Subject: How to merge by subtree while preserving history?
Date: Thu, 26 Mar 2009 18:59:51 -0400
Message-ID: <A5C2B218-4E4F-4C05-959D-5B6E9C619DDB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 00:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmybK-0004QU-JH
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 00:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759303AbZCZXAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 19:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759210AbZCZXAB
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 19:00:01 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:49994 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbZCZXAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 19:00:00 -0400
Received: by bwz17 with SMTP id 17so777698bwz.37
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 15:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=MXCTqIvzvSI7T1zNRYZeAwOYQZ4t74u2seb7G6mUvKM=;
        b=oxq+0lEXUEYu0yegndfW76uDar2kfbU/OAL19j3e1rmk13U7AaxLwRBMLLta+Bl56N
         P/94CysGIp+U10QQPMw6z6I7MnAZxiDd+otVAP42H+faKOaIBUo+AIsUqoUBejK3rn+R
         UEkDteMu1U7ejfE+a6Jv6w//UQ/Z2BlSzqw1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=lmGE5BgDFQe1w30ejdd/PsLmu2EFdrIcOjV8MSwE9fpbmOWyEwPasVaaFpP9BNung/
         Pdx9U59ooiOdZ1vLIngccIj1rrP6TqNa9LZyHZmESciux07sa3jKkWFdoLaJbVu8G7I8
         fYE0gDEMPBQZUgx1/e9XVtKOLvHGuiWRmkgb0=
Received: by 10.103.240.15 with SMTP id s15mr110898mur.93.1238108397104;
        Thu, 26 Mar 2009 15:59:57 -0700 (PDT)
Received: from ?192.168.1.42? (pool-72-65-195-138.pitbpa.east.verizon.net [72.65.195.138])
        by mx.google.com with ESMTPS id e9sm1698886muf.38.2009.03.26.15.59.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Mar 2009 15:59:55 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have two separately developed projects (foo, bar) which I'd like to  
merge; the contents of foo should, initially, go in a subdirectory of  
bar.

I'm aware of two methods:  moving (renaming) everything within foo  
into foo-dir, and then just pulling foo into bar.

This works beautifully, except that the big rename causes havoc w.r.t.  
to the files histories, i.e. git-log needs a "--follow" argument now,  
and "diff-tree" can't track changes when given the new file name.  No  
good.

I've also tried the method described in [1], but it seems that all  
history is lost here (the text could point this out..)
I've tried to "git pull -s subtree foo master" directly as well, but  
then it put foo into strange places (and lost the history).


So, I'm at a loss.  Suggestions much appreciated.




[1] http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
