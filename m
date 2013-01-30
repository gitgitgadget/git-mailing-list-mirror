From: Gene Czarcinski <gene@czarc.net>
Subject: Re: Bug, feature, or pilot error: format-patch
Date: Wed, 30 Jan 2013 09:41:28 -0500
Message-ID: <51093118.2060709@czarc.net>
References: <5106AF7C.1010502@czarc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jan 30 15:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0YrH-0006Mr-W0
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 15:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab3A3Olb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 09:41:31 -0500
Received: from eastrmfepo201.cox.net ([68.230.241.216]:34981 "EHLO
	eastrmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab3A3Ol3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 09:41:29 -0500
Received: from eastrmimpo305 ([68.230.241.237]) by eastrmfepo201.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20130130144128.EHTV17456.eastrmfepo201.cox.net@eastrmimpo305>
          for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:41:28 -0500
Received: from [192.168.18.148] ([68.100.144.189])
	by eastrmimpo305 with cox
	id uEhU1k00745PsQc01EhUJ2; Wed, 30 Jan 2013 09:41:28 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020205.51093118.0131,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=e+KEuNV/ c=1 sm=1
 a=xiXiwr23JuvKlkj6ngz4TA==:17 a=IUyNvTVCZWAA:10 a=3ncMKxW4HPAA:10
 a=103jMkqsgCkA:10 a=8nJEP1OIZ-IA:10 a=BIJj-m-0AAAA:8 a=hMvFJpF2QUkA:10
 a=ZZko0fuEwkH4CVfGka4A:9 a=wPNLvfGTeEIA:10 a=xiXiwr23JuvKlkj6ngz4TA==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (CRAM-MD5)
 smtp.auth=gczarcinski@cox.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <5106AF7C.1010502@czarc.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215023>

Ping

It would be useful to get some comment on this

On 01/28/2013 12:03 PM, Gene Czarcinski wrote:
> I am not on the mailing list so please CC me.  I am running git 1.8.1 on
> Fedora 18.
>
> I aam having what appears to be a problem.  Here is the sequence which
> generally describes what I did and what happened:
>
>      git  checkout  -b  test1  master
>      git  am  0001-simple-1.patch
>      git  checkout  -b  test2  master
>      git  am  0001-simple-2.patch        ### this is known to conflict
> with 0001-simple-1.patch
>      git  checkout  test1
>      git  merge  test2
> [here git-merge detects a conflict]
>      git  mergetool                               ###to resolve the
> conflict
> [conflict resolved]
>      git  commit  -a -s
>      git  log
> [shows two commits -- one for simple-2 and one for the merge]
>      git  format-patch  master..HEAD
> [two patch files created: 0001-simple-1.patch and 0002-simple-2.patch]
> [0002-simple-2.patch and 0001-simple-2.patch are exactly equal and do
> not reflect the resolved conflict]
>
> If you do git-diff between <commit-patch-1> and HEAD, you get something
> different that you got from format-patch.
>
> 1. Bug ... format-patch is broken
>
> 2. Feature ... that is the way it works
>
> 3. Pilot error ... ??
>
> I can create a good version of patch-2 manually but should I have to?
>
> Color me foolish but I assumed I could do git-format-patch in one branch
> and then use git-am to recreate that branch elsewhere.
>
> Gene
