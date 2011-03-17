From: Thomas Egerer <thomas.egerer@secunet.com>
Subject: Re: [PATCH] pretty.c: Make user defined format honor color option
Date: Thu, 17 Mar 2011 13:02:40 +0100
Message-ID: <4D81F860.2070703@secunet.com>
References: <4D81C741.8060108@secunet.com> <1300354791.3269.19.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 13:02:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0BuY-0001W9-Jd
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 13:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab1CQMCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 08:02:33 -0400
Received: from a.mx.secunet.com ([195.81.216.161]:53020 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846Ab1CQMCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 08:02:32 -0400
Received: from localhost (alg1 [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B654D1A0082;
	Thu, 17 Mar 2011 12:53:26 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mail-srv1.secumail.de (unknown [10.53.40.200])
	by a.mx.secunet.com (Postfix) with ESMTP id C9DBE1A007F;
	Thu, 17 Mar 2011 12:53:25 +0100 (CET)
Received: from [10.182.7.178] ([10.182.7.178]) by mail-srv1.secumail.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 17 Mar 2011 13:02:29 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20101227 Icedove/3.0.11
In-Reply-To: <1300354791.3269.19.camel@wpalmer.simply-domain>
X-Enigmail-Version: 1.0.1
X-OriginalArrivalTime: 17 Mar 2011 12:02:29.0333 (UTC) FILETIME=[30674850:01CBE49B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169240>

On 03/17/2011 10:39 AM, Will Palmer schrobtete:
> On Thu, 2011-03-17 at 09:33 +0100, Thomas Egerer wrote:
>> This patch fixes that the pretty-formats tformat and format ignore
>> git's color option.
> 
> It is my understanding that this is intentional, the logic being: If you
> normally don't want color, but have specified it directly on the
> command-line, you probably want color.
I'm using the pretty format in the context of an alias. My global setting
for colors is auto. I would expect git to not disregard this options. I
usually use the alias to display a git log in a modified way, but I also
do sometimes pipe it to grep. If there was a way to suppress output
colorization (let's say by not using global options but the command line
switch --color=never) that would work for me. But there is no wa and I
find it inconvinient to have two different aliases doing the same thing
one with color and one without while there would be a much simpler way.

> iirc, there are a couple of other places beyond log-tree.c which need to
> propagate COLOR_DIFF into the pretty context if you want to respect the
> colour option in user-specified formats. Skimming my own diffs:
> rev-list.c and shortlog.c
You're right. If there's a chance to bring this upstream, I would include
it in a revised versoin of my patch.

Thomas
