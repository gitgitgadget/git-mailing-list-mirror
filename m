From: viresh kumar <viresh.kumar@st.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Wed, 15 Jun 2011 17:32:30 +0530
Message-ID: <4DF89F56.3060200@st.com>
References: <4DF87B42.1020004@st.com> <m3ei2vv0nw.fsf@localhost.localdomain> <4DF891CC.1040700@st.com> <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: "kusmabite@gmail.com" <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jun 15 14:03:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWooV-000806-Ht
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 14:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab1FOMDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 08:03:07 -0400
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:40058 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750771Ab1FOMDE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 08:03:04 -0400
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob104.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTfifc4NkWDM5ujpcaj/lz7rC4oNdPvgg@postini.com; Wed, 15 Jun 2011 12:03:03 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E24C3DF;
	Wed, 15 Jun 2011 12:02:37 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A587FD3B;
	Wed, 15 Jun 2011 12:02:37 +0000 (GMT)
Received: from [10.199.16.92] (10.199.16.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 15 Jun 2011
 20:02:37 +0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175827>

On 06/15/2011 04:56 PM, Erik Faye-Lund wrote:
> On Wed, Jun 15, 2011 at 1:04 PM, viresh kumar <viresh.kumar@st.com> wrote:
>> On 06/15/2011 04:10 PM, Jakub Narebski wrote:
> Sounds like you should try "git config core.filemode false":
> 
> "core.fileMode:
>      If false, the executable bit differences between the index and
> the working copy are ignored; useful on broken filesystems like FAT"
> 
> (from from http://kernel.org/pub/software/scm/git/docs/git-config.html)
> .
> 


On 06/15/2011 04:59 PM, Jakub Narebski wrote:
> On Wed, 15 June 2011, viresh kumar wrote:
>> On 06/15/2011 04:10 PM, Jakub Narebski wrote:
>>> viresh kumar <viresh.kumar@st.com> writes:
> Ah. This is caused by the fact that FAT doesn't store executable
> permission.
> 
> So beside setting `core.symlinks` to false, you would have also set
> `core.filemode` to false (and perhaps also `core.ignorecase` to true).
> 
> You might also want to set `core.ignoreStat` to true to try to increase
> performace.
> 
> P.S. git-bundle ddidn't work?

didn't tried that. :(

> 

Guys, thanks for your inputs. core.filemode was new to me.
I tried to resolved issue in some other way.
I have tarred kernel before copying to memory stick. And after untarring kernel
on windows, file permission are not changed for all files with permission 644 originally.

There are some files in kernel whose permissions are 755 and they are converted to 644.
And are shown in git status as _modified_.

I got rid of them with core.filemode as false, but there is one more issue, as pointed out by
Andreas. There are few files in kernel with same file name but in different _cases_ (one in caps
and another in small.) and so i am getting issues with these now.

And don't have any idea how to get rid of that? And why does kernel have such file names at all?

-- 
viresh
