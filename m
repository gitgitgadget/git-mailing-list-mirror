From: viresh kumar <viresh.kumar@st.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 16:34:44 +0530
Message-ID: <4DF891CC.1040700@st.com>
References: <4DF87B42.1020004@st.com> <m3ei2vv0nw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 13:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWnuL-0003iE-L2
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 13:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab1FOLFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 07:05:07 -0400
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:43180 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751680Ab1FOLFG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 07:05:06 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob101.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTfiR3009f3EXA4JiIylvVpH0t5EJ5Dao@postini.com; Wed, 15 Jun 2011 11:05:05 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 76A9F10D;
	Wed, 15 Jun 2011 11:05:00 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 62CF7D35;
	Wed, 15 Jun 2011 11:05:00 +0000 (GMT)
Received: from [10.199.16.92] (10.199.16.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 15 Jun 2011
 19:04:58 +0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <m3ei2vv0nw.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175822>

On 06/15/2011 04:10 PM, Jakub Narebski wrote:
> viresh kumar <viresh.kumar@st.com> writes:
>> After completing copy operation on mem stick, i found something strange.
>> - git branch shows correct results and is exactly same of state at Linux machine.
>> - git log is also fine.
>> - git status, shows me a lot of files are modified, which is not present in Linux.
> 
> That is probably because stat information is stale... or stat
> information doesn't work.  Does second "git status" still show files
> as modified?
> 

Yes. The files status is same.

>> - git reset --hard also doesn't work and fails with following error.
>>
>> $ git reset --hard HEAD
>> error: unable to create symlink arch/microblaze/boot/dts/system.dts (Operation not permitted)
>> Checking out files: 100% (36696/36696), done.
>> fatal: Could not reset index file to revision 'HEAD'.
> 
> Try setting `core.symlinks` to false, or just try
> 
>  $ git -c core.symlinks=false reset --hard HEAD
> 
> Notice that your repository includes symlinks.
> 
> 
> BTW. what filesystem do you use?
> 

It was FAT on memory stick as FAT is also there in Windows PC.
More observation: All files marked modified had only changes in file permissions.
i.e. 755 instead of 644. chmod doesn't work with FAT so can't change there permissions
now.

Problem is not only for symlinks but standard c files too.

-- 
viresh
