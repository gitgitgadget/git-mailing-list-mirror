From: Andreas Ericsson <ae@op5.se>
Subject: Re: Misterious warning about file system boundaries
Date: Thu, 10 Jun 2010 10:03:27 +0200
Message-ID: <4C109C4F.1030809@op5.se>
References: <4C0FF7B9.8040007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 10:04:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMckF-0001I9-1S
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 10:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610Ab0FJIDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 04:03:35 -0400
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49282 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752064Ab0FJIDb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 04:03:31 -0400
Received: from source ([74.125.78.149]) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTBCcUeU5cPVT8SteqxqRtlM+D4zpUodW@postini.com; Thu, 10 Jun 2010 01:03:30 PDT
Received: by ey-out-1920.google.com with SMTP id 5so1911eyb.16
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 01:03:28 -0700 (PDT)
Received: by 10.213.21.138 with SMTP id j10mr1821409ebb.50.1276157008227;
        Thu, 10 Jun 2010 01:03:28 -0700 (PDT)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id 13sm4593467ewy.1.2010.06.10.01.03.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 01:03:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <4C0FF7B9.8040007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148840>

On 06/09/2010 10:21 PM, Michael J Gruber wrote:
> Heya,
> 
> now what is going on here? After upgrading to current next I get
> 
> warning: working tree spans across filesystems but
> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.
> 
> in several repos, such as my local git.git repo. That is certainly on a
> single file system only (ext4 over lvm over luks, all on one partition,
> Fedora 13). I also get this for another repo, but not for every repo. It
> goes away when I set the var and comes back when I don't set it, of course.
> 
> Although I haven't bisected this should be due to
> 52b98a7 (write-index: check and warn when worktree crosses a filesystem
> boundary, 2010-04-04).
> 
> How does the code detect a file system boundary, and where could it go
> wrong?
> 

According to the patch, it checks if the device id recorded from stat(2)
is the same for all files and, if not, warns about it.

It seems that your interpretation of "one partition" differs from that
reported by the kernel. Why that is so, I have no idea.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
