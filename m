From: Andreas Ericsson <ae@op5.se>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 11:47:34 +0200
Message-ID: <4DF87FB6.2080503@op5.se>
References: <4DF87B42.1020004@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 11:47:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWmhL-00030q-Bk
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 11:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab1FOJri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 05:47:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33962 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab1FOJrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 05:47:37 -0400
Received: by fxm17 with SMTP id 17so260219fxm.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 02:47:36 -0700 (PDT)
Received: by 10.223.76.219 with SMTP id d27mr343426fak.87.1308131256290;
        Wed, 15 Jun 2011 02:47:36 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id q10sm121251fan.8.2011.06.15.02.47.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 02:47:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <4DF87B42.1020004@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175816>

On 06/15/2011 11:28 AM, viresh kumar wrote:
> Hello,
> 
> I wanted to copy my complete Linux GIT repo from Linux PC to Windows. I also wanted everything
> related to remote branches too, so need to copy and clone and fetch wouldn't work.
> 
> I don't have windows on same network, so i need to copy to memory stick and then to Windows PC.
> 
> After completing copy operation on mem stick, i found something strange.
> - git branch shows correct results and is exactly same of state at Linux machine.
> - git log is also fine.
> - git status, shows me a lot of files are modified, which is not present in Linux.
> - git reset --hard also doesn't work and fails with following error.
> 
> 
> $ git reset --hard HEAD
> error: unable to create symlink arch/microblaze/boot/dts/system.dts (Operation not permitted)
> Checking out files: 100% (36696/36696), done.
> fatal: Could not reset index file to revision 'HEAD'.
> 
> 
> Any help about this issue would be very helpful.
> 

The Linux kernel repository isn't very good to work with on Windows
machines, or anywhere where the filesystem is either case-insensitive
or case-agnostic.

One reason is that it contains symlink. The other is that there are
files sharing the same name and only differ in case.

I suppose the main thought behind it is that Linux kernel hackers
almost exclusively use Linux (which has sane filesystems) to do
their work, so it hasn't been rectified in the 5 or so years it has
been a known (non-)problem.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
