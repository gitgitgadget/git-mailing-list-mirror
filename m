From: Andre Esser <andre.esser@geneity.co.uk>
Subject: Re: Check out doesn't set x-flag on CIFS
Date: Wed, 20 Nov 2013 11:48:29 +0000
Organization: Geneity Ltd
Message-ID: <528CA18D.40004@geneity.co.uk>
References: <loom.20130529T161408-317@post.gmane.org> <CABPQNSZDSRf9LSeBHBJ46pbBGsDwybTPkyJ2esqvoc0UHPifKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 20 13:00:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj6PQ-0002br-Q4
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 12:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab3KTL5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 06:57:25 -0500
Received: from 83-244-221-232.cust-83.exponential-e.net ([83.244.221.232]:47195
	"HELO infra-5.lohs.geneity" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751133Ab3KTL5Y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Nov 2013 06:57:24 -0500
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2013 06:57:14 EST
Received: from worker-1.lohs.geneity (worker-1.lohs.geneity [10.33.16.21])
	by infra-5.lohs.geneity (Postfix) with ESMTP id 82BED20D78;
	Wed, 20 Nov 2013 11:48:29 +0000 (GMT)
Received: from [10.33.17.0] (karlo.lohs.geneity [10.33.17.0])
	by worker-1.lohs.geneity (Postfix) with ESMTP id 738F5604BF;
	Wed, 20 Nov 2013 11:48:29 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CABPQNSZDSRf9LSeBHBJ46pbBGsDwybTPkyJ2esqvoc0UHPifKA@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238072>

On 2013-11-20 10:51, Erik Faye-Lund wrote:
> On Wed, May 29, 2013 at 4:16 PM, Andre Esser <andre.esser@geneity.co.uk> wrote:
>> Hello,
>>
>> When on a CIFS filesystem a git checkout does not replicate the executable
>> flag from the repository:
>>
>>   $ git clone git://git/abettersqlplus
>>   Cloning into 'abettersqlplus'...
>>   remote: Counting objects: 522, done.
>>   remote: Compressing objects: 100% (342/342), done.
>>   remote: Total 522 (delta 166), reused 522 (delta 166)
>>   Receiving objects: 100% (522/522), 82.40 KiB, done.
>>   Resolving deltas: 100% (166/166), done.
>>   $ ls -l abettersqlplus/absp.py
>>   -rw-rw-r-- 1 aesser geneity 45860 May 29 14:46 abettersqlplus/absp.py
>>
>>
>> Subsequently git status reports the file as changed:
>>
>>   $ cd abettersqlplus/
>>   $ git status
>>   # On branch master
>>   # Changes not staged for commit:
>>   #   (use "git add <file>..." to update what will be committed)
>>   #   (use "git checkout -- <file>..." to discard changes in working
>>   directory)
>>   #
>>   #    modified:   absp.py
>>   #
>>   no changes added to commit (use "git add" and/or "git commit -a")
>>
>>
>> If I set the x-flag manually, all is well:
>>
>>   $ chmod +x absp.py
>>   $ git status
>>   # On branch master
>>   nothing to commit (working directory clean)
>>
>>
>> This problem doesn't occur on ext3 or NFS file systems. Client is Ubuntu
>> 12.04 with git version 1.7.9.5. CIFS is exported from Ubuntu 12.04 with
>> Samba version 3.6.3.
>>
>> Since git recognises the x-flag on this CIFS file system, shouldn't it also
>> be able to set it on checkout?
>>
> 
> You might want to check out the core.filemode configuration variable.

Thanks, but unfortunately that only suppresses the error message, it
still doesn't set the x-flag when it should.

Andre
