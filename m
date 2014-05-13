From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [BUG] git-gui regression in 2.0rcX within submodule
Date: Tue, 13 May 2014 23:14:43 +0200
Message-ID: <53728B43.3000608@web.de>
References: <20140512234518.GB5529@home.lan> <5371D840.2020208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Chris Packham <judge.packham@gmail.com>,
	Yann Dirson <ydirson@free.fr>, GIT list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue May 13 23:14:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkK2J-0001WO-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbaEMVOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:14:52 -0400
Received: from mout.web.de ([212.227.15.4]:50388 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbaEMVOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:14:51 -0400
Received: from [192.168.178.41] ([84.132.184.198]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M5OYl-1X0UHG0X9j-00zaXU; Tue, 13 May 2014 23:14:49
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <5371D840.2020208@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:9a3mxncqJwrnLDmZ7qlj1thZVrZwYF9l2dCvJU9WUkdtvRYLV3n
 SP6Xut0fDmJPMTyuinUPmtIyyeB5J0v01nOKBdVQbesH5gsbV1//vuYj2fNXBr2PkvRIInC
 izR6/xBflUuJ/6FHbsHYXyyhTcbf0uOgwBt6vBD6U1TtUmPtSO6uHHotg/L3qgblMTovbdB
 bZBEMTCszkloWdxkUMq3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248857>

Thanks for the reminder, I'm currently looking into that.

Am 13.05.2014 10:30, schrieb Chris Packham:
> Hi,
> 
> On 13/05/14 11:45, Yann Dirson wrote:
>> In 2.0rc2, git-gui is unable to work inside submodules, where 1.9.2
>> did not show such a problem:
>>
>>
>> yann@home:~$ cd /tmp/
>> yann@home:tmp$ mkdir foo
>> yann@home:tmp$ cd foo/
>> yann@home:foo$ git init
>> Initialized empty Git repository in /tmp/foo/.git/
>> yann@home:foo (master)$ git submodule add git://git.debian.org/git/collab-maint/tulip.git debian
>> Cloning into 'debian'...
>> remote: Counting objects: 317, done.
>> remote: Compressing objects: 100% (199/199), done.
>> remote: Total 317 (delta 184), reused 166 (delta 95)
>> Receiving objects: 100% (317/317), 73.81 KiB | 0 bytes/s, done.
>> Resolving deltas: 100% (184/184), done.
>> Checking connectivity... done.
>> yann@home:foo (master)$ git status 
>> On branch master
>>
>> Initial commit
>>
>> Changes to be committed:
>>   (use "git rm --cached <file>..." to unstage)
>>
>>         new file:   .gitmodules
>>         new file:   debian
>>
>> yann@home:foo (master)$ (cd debian/ && git gui)
>> [errors out after showing the following error dialog]
>>
>> | No working directory ../../../debian:
>> | 
>> | couldn't change working directory
>> | to "../../../debian": no such file or
>> | directory
>>
> 
> I've already reported the same issue[1] and have posted a possible
> solution[2] although I haven't seen any feedback from Pat or anyone else.
> 
>>
>> strace shows the failing chdir call is from git-gui itself, after
>> getcwd() told him that it is in the dir that is indeed the workdir
>> already.
>>
> 
> --
> 
> [1] - http://article.gmane.org/gmane.comp.version-control.git/247511
> [2] - http://article.gmane.org/gmane.comp.version-control.git/247564
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
