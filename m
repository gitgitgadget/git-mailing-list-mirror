From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: EOL handling (EGit/svn/Windows)
Date: Tue, 10 Feb 2015 06:49:33 +0100
Message-ID: <54D99BED.8010005@web.de>
References: <CAA01Csrp0ZOouM5zhVuHQW9sWCnbMMLRkmcbRtgsU3k8wNtSqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 06:50:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YL3iI-0004eg-Ga
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 06:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbbBJFuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 00:50:15 -0500
Received: from mout.web.de ([212.227.17.12]:49663 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbbBJFuO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 00:50:14 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M8Qtq-1XQKUD28qg-00vykg; Tue, 10 Feb 2015 06:50:11
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAA01Csrp0ZOouM5zhVuHQW9sWCnbMMLRkmcbRtgsU3k8wNtSqw@mail.gmail.com>
X-Provags-ID: V03:K0:Pqp7q8EpI8IAaf5iuhheZ4RToZkO9qUJgFCbU1myst1/db/Tf2g
 lJi6p2D9rUFJir9eWokTxCYaL16I5w7Eb4o5rKCd2z+9zK3M64GHKX3wIwP8Nz99JCJ1qya
 gIWlM4B7Z7mfq8MVMOm6DmsXNZOfQuhcSmDOF1dwmegW4eN2McBPvMVAbebdIqdfCFVEteD
 0TyNMvDEf/IC8pvgKitSw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263625>

On 02/09/2015 11:22 PM, Piotr Krukowiecki wrote:
 >Any other suggestions?

My, somewhat personally, suggestion:
If there is more than one developer, don't use core.autocrlf at all-
it is a local setting, which doesn't travel through the repo, and
is slightly different in Git Egit, depending on the version.

Git for Windows has it enabled by default, Cygwin has not.

Which Git versions are you using ?
How many people are there involved, how many on Windows, how many on Linux ?
Do you want to commit to svn, or is this a one-time conversion ?

If it is a one-time conversion, and you continue to work in Git only,
then the cleanest, most portable and future proof way is to use the 
.gitattributes file,
add that to the repo, do the normalization  and push.
A line like this:
* text=auto
is the easiest way.

Have a look at
https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
take a tee or coffee, do some experiments first with a dummy repo,
but all the client OS/Gits involved.
Please let us know the result (or feel free to ask more questions)
