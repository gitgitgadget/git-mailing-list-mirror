From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [bug] git checkout lies about number of ahead commits when switching
 from detached HEAD
Date: Sat, 19 Mar 2011 22:53:13 +0100
Message-ID: <4D8525C9.2060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 22:53:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q145P-0001z2-Ue
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 22:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757663Ab1CSVxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 17:53:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59398 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655Ab1CSVxW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 17:53:22 -0400
Received: by wwa36 with SMTP id 36so6098223wwa.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=POgyEgXgaG95u1VuF2KiUXtRPP45AdetURlPLTo7nww=;
        b=Hwiwfl1q3eXPH6T/9ettcPNOxBOHiqc6dABXesr/3bG9GrXYmTouMG0STBiIFjtJyp
         U51XbHuY+lNOWzofgvc+mgssqDrzDSletW/YK5O0/cUhgFnLvf1RxHV+2Dqv3iaGRcmz
         CRXJ7G+WYOaadudJAsmHJrEBy61lN4K5GZfnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=TNlK3cVAxRohIE9FgeGgPOO6IRhvm0PNao0aJBi0zNh2wlMjyNzRBAMYllXfIy9pQm
         zUL7cWL0abhlJgFSExB3CKCPNTLw5vSHRbs1dzuUYNsqRfcHFHDBdOBbGleAeIg8I5j7
         gi57lbsp7++QtHPVKo2RZnAbv4PNdLa3s+kxQ=
Received: by 10.227.139.90 with SMTP id d26mr2621269wbu.71.1300571601220;
        Sat, 19 Mar 2011 14:53:21 -0700 (PDT)
Received: from [192.168.1.101] (app184.neoplus.adsl.tpnet.pl [83.26.149.184])
        by mx.google.com with ESMTPS id u9sm2003734wbg.34.2011.03.19.14.53.19
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 14:53:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169468>

It says "by 0 commits" when going back from detached HEAD to
master branch:


$ git checkout HEAD^

$ git checkout master
Previous HEAD position was af4c62a... Merge branch 'maint'
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 0 commits.
                                        ^^^^^^^^^^^^

$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
                                          ^^^^^^^^^^^

#
nothing to commit (working directory clean)


-- 
Piotr Krukowiecki
