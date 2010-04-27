From: Andreas Ericsson <ae@op5.se>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 21:47:48 +0200
Message-ID: <4BD73F64.1070604@op5.se>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern> <4BD6ACEF.1040909@op5.se> <alpine.LFD.2.00.1004272111540.5630@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 21:47:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6qlC-0001Os-R1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 21:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab0D0Trx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 15:47:53 -0400
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38100 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754877Ab0D0Trw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 15:47:52 -0400
Received: from source ([209.85.219.223]) by na3sys009aob112.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS9c/ZkqpfYnlgVKCWJIbeJtkADR9b1BL@postini.com; Tue, 27 Apr 2010 12:47:52 PDT
Received: by mail-ew0-f223.google.com with SMTP id 23so4937615ewy.14
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 12:47:50 -0700 (PDT)
Received: by 10.213.41.15 with SMTP id m15mr530007ebe.5.1272397670529;
        Tue, 27 Apr 2010 12:47:50 -0700 (PDT)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id 16sm2904027ewy.3.2010.04.27.12.47.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 12:47:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <alpine.LFD.2.00.1004272111540.5630@bbs.intern>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145939>

On 04/27/2010 09:38 PM, Gerhard Wiesinger wrote:
> On Tue, 27 Apr 2010, Andreas Ericsson wrote:
> 
>> On 04/27/2010 07:23 AM, Gerhard Wiesinger wrote:
>>> Hello,
>>>
>>> I'm new to git and I'm looking for the following features:
>>> 1.) Metadata for
>>> a.) directory versioning (e.g. add/rm, mv)
>>
>> If you're talking about empty directories, that feature doesn't
>> exist and I can't imagine why you'd want it to. If you'd care to
>> explain why you want it, I'm sure we can find a different way of
>> achieving your goal.
> 
> Git focuses on content but I think git should also focus on metadata. 
> For example restructuring source code moves (git mv file1.c file2.c, git 
> mv dir1 dir2) should be documented also in the repository like e.g. 
> subversion and commercial SCM like clearcase do. Otherwise we are on 
> "CVS" level.
> 
> Empty directories is a special case and sometimes you need just 
> versioned empty directies.
> 

This has been discussed to death several times before on this mailing
list. Browse the archives. There haven't been any new arguments the
last 14 times it came up, so I doubt you'll be able to come up with
a single good reason to track file renames explicitly.

>>> b.) rights (basic: chmod, chow, chgrp, extended: extended attributes
>>> like ACLs and selinux), necessary for versioning e.g. /etc
>>
>> Sounds like you want a backup-program. Some projects have been
>> aimed towards this goal already. I'm sure google can provide
>> more information. AFAIR, most of them work with two hook-scripts
>> that update a regular file with the meta-data of all tracked
>> files. This makes committing and checking out slower than it
>> would otherwise be, but since it's doing more I suppose that's
>> to be expected.
>>
>> Adding it to core git would mean re-designing git's basic data
>> model, which is obviously not something we're about to do on
>> a whim.
> 
> No, I'm NOT looking for a backup program. Every admin has the problem of 
> versioning config files (for example /etc). Versioning of config files 
> makes sense because one can track the changes and e.g. correlate to 
> problems. A backup program doesn't have features like history, committer 
> and comments on file changes. Therefore git would be a perfect tool also 
> for versioning configuration. (Software development doesn't end with the 
> build but typically also has deployment&configuration issues).
> 

Right. So you want a *fancy* backup program and not just any random
backup solution. There are solutions for this. Someone else already
mentioned them elsewhere in this thread, so I'll refrain from further
comments on this.

In short: What you want can be (and has been) done, but it's written
as addons and not integral parts of git.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
