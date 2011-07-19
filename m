From: Chris Packham <judge.packham@gmail.com>
Subject: Re: how to add files/folder from work-tree
Date: Tue, 19 Jul 2011 20:13:08 +1200
Message-ID: <4E253C94.7000709@gmail.com>
References: <20110719120048.3dd56eb6@shiva.selfip.org>	<4E2537F8.6000506@gmail.com> <20110719133633.0797713d@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Jul 19 10:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj5QU-000092-J7
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 10:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab1GSIND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 04:13:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42826 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab1GSINC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 04:13:02 -0400
Received: by iwn6 with SMTP id 6so3844639iwn.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 01:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vqcdvl6X2xL/3o7N1eo9nwVBBLv2tfVzZpyaS8IcoPk=;
        b=q1cXtzExxNrbKu4DebuTY7+vCphe5hTXmP+Gb5Pp6vhtvTsMYMGJo7nsLU01IRoYeT
         j2mrolBkMNmcp7Xb2XZTYAU8DAf6Hv1hus8nTUS3Obp7Vzr8ZV7wnjyBoYtMXpISpyWr
         2SvZDl/zYHtIaA15GVqnU2h1VPVROTa5KQPg4=
Received: by 10.231.92.84 with SMTP id q20mr6960577ibm.92.1311063182143;
        Tue, 19 Jul 2011 01:13:02 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id x11sm3465503ibd.58.2011.07.19.01.12.59
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 01:13:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <20110719133633.0797713d@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177441>

Oops managed to drop the Cc for the mailing list from my initial response.

On 19/07/11 20:06, J. Bakshi wrote:
> On Tue, 19 Jul 2011 19:53:28 +1200
> Chris Packham <judge.packham@gmail.com> wrote:
> 
>> On 19/07/11 18:30, J. Bakshi wrote:
>>> Hello,
>>>
>>> I am using a git repo which has detached work tree. I like to add the files, folders located at the work tree ( it is a site under htdocs) at the git repo. Is it possible to do it within the work-tree or I need a separate working space from where I need to do all these operation ?
>>>
>>> Thanks
>>>  
>>> --
>>
>> I'm not sure I fully understand your question but what I _think_ you
>> want to do is specify the path to the repository with the GIT_DIR
>> environment variable. Like this
>>
>>  cd /place/where/files/are
>>  GIT_DIR=/place/were/repo/is/.git git add <file>
>>
> 
> 
> I have set a git repo with attached work-tree with hook as below
> 
> git -bare init  /home/git/test.git
> cd /home/git/test.git
> git config core.worktree /var/www/test
> 
> vim /home/git/test.git/hooks/post-receive
> 
> #!/bin/sh
> git checkout -f
> 
> Now the /var/www/test has already some files/folder. How can I add those to the repo within from its work-tree ?
> 
> Thanks

I think my initial response is correct. Try the following

  cd /var/www/test
  git --git-dir=/home/git/test.git add <files>
  git --git-dir=/home/git/test.git commit -m "blah"
