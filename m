From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
Date: Sat, 10 Jan 2009 16:55:32 +0100
Message-ID: <81783342-81AA-415A-8EF3-1CD9F5390483@zib.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de> <1231595452-27698-2-git-send-email-prohaska@zib.de> <1231595452-27698-3-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steve Haslam <shaslam@lastminute.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 16:57:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLgDX-0002nK-U6
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 16:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZAJP4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 10:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbZAJP4U
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 10:56:20 -0500
Received: from mailer.zib.de ([130.73.108.11]:60948 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbZAJP4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 10:56:19 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0AFtx65008034;
	Sat, 10 Jan 2009 16:56:04 +0100 (CET)
Received: from [192.168.178.21] (brln-4db952c9.pool.einsundeins.de [77.185.82.201])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0AFtvXf013982
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 10 Jan 2009 16:55:58 +0100 (MET)
In-Reply-To: <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105122>


On Jan 10, 2009, at 3:34 PM, Johannes Schindelin wrote:

> On Sat, 10 Jan 2009, Steffen Prohaska wrote:
>
>> From: Steve Haslam <shaslam@lastminute.com>
>>
>> If the user specified the full path to git-upload-pack as the -u  
>> option to
>> "git clone" when cloning a remote repository, and git was not on  
>> the default
>> PATH on the remote machine, git-upload-pack was failing to exec
>> git-pack-objects.
>>
>> By making the argv[0] path (if any) available to setup_path(), this  
>> will
>> allow finding the "git" executable in the same directory as
>> "git-upload-pack". The default built in to exec_cmd.c is to look  
>> for "git"
>> in the ".../libexec/git-core" directory, but it is not installed  
>> there (any
>> longer).
>>
>> Much the same applies to invoking git-receive-pack from a non-PATH  
>> location
>> using the "--exec" argument to "git push".
>>
>> [ spr: split Steve's original commit into two commits. ]
>
> I think you do not want to have that [ ... ] in the commit message,  
> but
> after the "--".
>
> Further, it would make sense to have these 2 patches independently,
> provided that a test is added with which we could verify that the  
> patches
> are actually necessary for upload-pack/receive-pack.


Steve,
could you comment on this.  You are the original author of the patch.

	Steffen 
