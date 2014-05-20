From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: untracked file deleted from the master branch, when checked out
 to it from a local branch
Date: Tue, 20 May 2014 11:56:57 -0500
Message-ID: <537B8959.7090100@gmail.com>
References: <2525467.KRXv8a3gWS@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arup Rakshit <aruprakshit@rocketmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 18:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmnLe-0007Bi-M1
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 18:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaETQ47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 12:56:59 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:55799 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbaETQ46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 12:56:58 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so810159obc.37
        for <git@vger.kernel.org>; Tue, 20 May 2014 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=OerpLd3OQV6Y2689kL3suDqNJF9LJcpo9dOFyn3HhHM=;
        b=l290PF3gJlmC1RfMRKP/ivDRfKC+LzYbPml3/RwGcfMuqCFNYiVPgAUkPjcoeduVwj
         duHc/qS/M1DV1nlrBM1lvTszyzCYZKLXhjttaaKeDZ25Mkh45bU8Y9bVM0qj73yY+EXN
         hj8EBq6tqGlDdc+pVjDTisDXCCoN8EcsINKG5Kzg07Y1p+1vlaPOEYuN7xiniRkbnUXw
         XXGcHslZXVhUQ9ZLC7BkSuaidawv4iLYXEMWvYahZlRHybY7/hqfgdq17OQnrgkhMD+o
         ITRbaZWonCLUjm6Qu7PGmHdWQ4/O6589MySl517mUXkNrG2bHPkoj9URx3X8Q7I1qKpF
         zZrQ==
X-Received: by 10.60.115.202 with SMTP id jq10mr45294105oeb.0.1400605017845;
        Tue, 20 May 2014 09:56:57 -0700 (PDT)
Received: from [10.3.3.221] ([199.227.34.94])
        by mx.google.com with ESMTPSA id g3sm30527701obd.18.2014.05.20.09.56.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 09:56:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <2525467.KRXv8a3gWS@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249700>

On 5/20/2014 10:38 AM, Arup Rakshit wrote:
> I was following some tutorial (http://gitref.org/branching/#merge) - and doing
> it in my console :
>
> Arup-iMac:arup_git shreyas$ git status
> # On branch master
> nothing to commit, working directory clean
> Arup-iMac:arup_git shreyas$ touch test.rb
> Arup-iMac:arup_git shreyas$ ls
> git_1.txttest.rb
> Arup-iMac:arup_git shreyas$ cat test.rb
> Arup-iMac:arup_git shreyas$ vi test.rb
> Arup-iMac:arup_git shreyas$ cat test.rb
> class Foo
>    def self.bar
>      12
>    end
> end
>
> Foo.bar
> ***********HERE I switched to a NEW Branch****************
...
> ********FROM MASTER BRACH WHY THE FILE test.rb DELETED?***********
> Arup-iMac:arup_git shreyas$ ls
> git_1.txt

Because you never committed the original file to the master branch 
before you created and switched to the change_class branch.

You're missing
     git add test.rb
     git commit -m "initial version of test.rb"
before you switch branches the first time.

-- 
.marius
