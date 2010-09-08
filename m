From: Douglas Tan <douglas@getgosu.com>
Subject: Re: Propagating config to clones/pulls
Date: Wed, 8 Sep 2010 11:08:13 +0800
Message-ID: <5892B461-8BBA-4E1D-9BC4-3EADCEA4F98E@getgosu.com>
References: <A8F08AD5-6DB5-4A4D-9A8F-79DDBD93E666@getgosu.com> <201009071123.21011.trast@student.ethz.ch> <AANLkTikbCTRKpN7w=-xoj8uKvSV1X2U8fnhXgva=oA=8@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 05:08:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtB1Y-0008DR-C3
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 05:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab0IHDI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 23:08:26 -0400
Received: from mail.getgosu.com ([67.110.176.227]:59653 "EHLO mail.getgosu.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab0IHDIY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 23:08:24 -0400
Received: from [10.10.13.18] (unknown [10.10.13.18])
	by mail.getgosu.com (Postfix) with ESMTPSA id 507AE22C18;
	Tue,  7 Sep 2010 22:37:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=getgosu.com;
	s=default; t=1283913428;
	bh=QIdyWuKkI719VZcQxOSIjzg1FMMDaA2zFTVzI+M2iZo=;
	h=Subject:Mime-Version:Content-Type:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To;
	b=GAEzYFi2FHEU5rjNhlDl5gHT6ODkBiNziuKeZv/Q4j4zepjbuPS5ga907j37lh4Ge
	 RrUbSLyaSpvoSPcO5veBsDw1IlvmRQ1Fdr2F6PptovlStV/Huhxjtmpj5VluuUg190
	 8nmW0mZ5IjfoOOiqdev3PpqkzwouWX4tWnZeQK94=
In-Reply-To: <AANLkTikbCTRKpN7w=-xoj8uKvSV1X2U8fnhXgva=oA=8@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155758>

Thanks for the suggestions, I think I'll have everyone cloning the repositories to add the configuration settings in ~/.gitconfig instead.

On 07/09/2010, at 7:05 PM, David Aguilar wrote:

> On 9/7/10, Thomas Rast <trast@student.ethz.ch> wrote:
>> Douglas Tan wrote:
>>> 
>>> I have some config settings that I'll like to make default for
>>> anyone cloning/pulling from the central remote bare repository. I've
>>> tried to do this by editing the config file in the bare repository
>>> on the server but the change doesn't appear when cloning. How can I
>>> go about pushing default config settings to anyone cloing or pulling
>>> from the repository?
>> 
>> You can't, since that would open a whole range of security issues.
>> 
>> You can put some config defaults inside the repository itself, but it
>> is up to your users whether they apply them.  Perhaps it's best to
>> write them as a shellscript that adds to the configuration file(s) so
>> that it is easy to apply it later, e.g.,
>> 
>>  #!/bin/sh
>>  git config diff.jpg.textconv exiftool
>>  cat >> .gitattributes <<EOF
>>  *.jpg diff=jpg
>>  EOF
>> 
>> --
>> Thomas Rast
>> trast@{inf,student}.ethz.ch
> 
> Also.. if you happen to have administrator access to their machines
> (or if they do) then you can roll an .rpm/.deb/etc. containing an
> /etc/gitconfig and install it on their machines.  That'll apply these
> settings globally without them having to run a script everytime a repo
> is cloned.
> -- 
>    David
