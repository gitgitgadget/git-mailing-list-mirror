From: Simon <simonzack@gmail.com>
Subject: Git commit amend empty emails
Date: Thu, 11 Dec 2014 00:17:35 +1100
Message-ID: <548847EF.7080805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 14:17:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyh9C-00034I-0d
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 14:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471AbaLJNRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 08:17:37 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:61600 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461AbaLJNRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 08:17:36 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so2787877pde.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 05:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=3GrSjhlRPD6HYOzSFzT03Ld9z23a2DJ9V9StbNjw8EA=;
        b=TZK29UvCN3/lWdLf7A5B2ytM76K+Ylr5YzdmZHK3paFsoPqdixB5aUeCk3W1sHWES/
         cRGgAM8GYmWnpMEUCD3H0YcWqFDGE+dEfMjrFcjOL3TkhubMEW8/HOx+Q9DzIeC7RM/0
         zVUd8uEJyNmSH4OeiFQ+aWFEhxTWoRNbFU6aLMo4nDeBS4GtUtFoFHlO+xw8+9P5XBbn
         GVip0fVlJWTJr1jN0IEI0W3nZtDDa+ZT8WkGdvhyTOiiKcpPpf288O2LJis+RHQyiOcT
         mLNsNoZIOiE+Yy0EbHa5S81iuTMpCXGJM0kjPrBy7s/NO/73mVbGd1NAeczTBJWGLit2
         X9WA==
X-Received: by 10.68.170.130 with SMTP id am2mr7013933pbc.156.1418217455784;
        Wed, 10 Dec 2014 05:17:35 -0800 (PST)
Received: from [192.168.2.141] (c220-239-56-122.eburwd6.vic.optusnet.com.au. [220.239.56.122])
        by mx.google.com with ESMTPSA id fa9sm4317756pab.36.2014.12.10.05.17.34
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 05:17:35 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261211>

Git is having empty email problems I think, I'm on git v2.1.3.

Steps to reproduce:

     $ git init
     Initialized empty Git repository in /tmp/test_git/.git/
     $ echo 'test' > abc
     $ git add --all 1 =E2=86=B5
     $ git commit --message 'test'
     [master (root-commit) 3cc2793] test
      1 file changed, 1 insertion(+)
      create mode 100644 abc
     $ echo 'test2' > abc
     $ git commit --amend
     fatal: Malformed ident string: 'admin <> 1418217345 +0000'
