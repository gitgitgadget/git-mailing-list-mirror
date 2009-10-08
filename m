From: Andreas Ericsson <ae@op5.se>
Subject: Re: git log -S not finding all commits?
Date: Thu, 08 Oct 2009 11:12:06 +0200
Message-ID: <4ACDACE6.9060509@op5.se>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel <mjucde@o2.pl>
X-From: git-owner@vger.kernel.org Thu Oct 08 11:16:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvp6y-0003ZS-HB
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 11:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbZJHJMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 05:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbZJHJMs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 05:12:48 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59158 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751879AbZJHJMs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 05:12:48 -0400
Received: from source ([209.85.219.220]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSs2s6gZUvv74NU9Q+t4bpcknGTaJZebI@postini.com; Thu, 08 Oct 2009 02:12:52 PDT
Received: by ewy20 with SMTP id 20so1466453ewy.16
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 02:12:10 -0700 (PDT)
Received: by 10.216.85.13 with SMTP id t13mr300076wee.127.1254993130215;
        Thu, 08 Oct 2009 02:12:10 -0700 (PDT)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id 7sm179878eyb.29.2009.10.08.02.12.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 02:12:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3 ThunderGit/0.1a
In-Reply-To: <7ae12651.522df17b.4acda0f5.21a31@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129685>

On 10/08/2009 10:21 AM, Daniel wrote:
> Hi,
>
> I did:
>
> $ git version
> git version 1.6.4.4
> $ mkdir a&&  cd a&&  git init
> $ echo "Free data">  a
> $ git add a
> $ git commit -m1
> $ echo "Free data allocated by other function">  a
> $ git commit -a -m2
> $ PAGER=cat git log -S'Free' --oneline
> 2f34241 1
>
> I would expect "git log" to show both 1 and 2 commit, but it prints only 1.
>
> Is it the correct behavior?
>

Yes, it's the correct behaviour. -S finds only lines where what you search
for was added or deleted. It counts the number of occurrences of what you
specify in each resulting tree and only shows the commits where that number
changed. In your case, searching for "Free data " would have printed both
commits, since you first introduce that entire string and then remove it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
