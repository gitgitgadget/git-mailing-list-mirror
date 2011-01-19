From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git submodule vs git mergetool
Date: Wed, 19 Jan 2011 19:40:55 +0100
Message-ID: <4D373037.8050606@web.de>
References: <AANLkTi=jS1LQY0kfSD_=o0PZ9BAF7k=06QFT+agkvGNa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 19:41:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfcxu-0008LQ-MO
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 19:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab1ASSlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 13:41:00 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:44979 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab1ASSlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 13:41:00 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9CD251853DB94;
	Wed, 19 Jan 2011 19:40:58 +0100 (CET)
Received: from [93.246.61.5] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pfcxm-0005dP-00; Wed, 19 Jan 2011 19:40:58 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=jS1LQY0kfSD_=o0PZ9BAF7k=06QFT+agkvGNa@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18DjVvbMmxwRcKGs44GTZfSsRePJL/4XjgHaI+y
	BfPmeeiutv3qafDWIduEaUR9lYP403l/H6HNk69htjfzVwCcI4
	Lcpp7DoMeUEdNH5s09RA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165274>

Am 18.01.2011 10:04, schrieb Mathieu Malaterre:
> $ git mergetool
> merge tool candidates: meld opendiff kdiff3 tkdiff xxdiff
> tortoisemerge gvimdiff diffuse ecmerge p4merge araxis emerge vimdiff
> Merging the files: Testing/Data
> 
> mv: cannot stat `Testing/Data': No such file or directory
> cp: cannot stat `./Testing/Data.BACKUP.5251': No such file or directory
> error: git checkout-index: cannot create temporary subproject
> error: git checkout-index: cannot create temporary subproject
> Normal merge conflict for 'Testing/Data':
>   {local}: created
>   {remote}: created
> Hit return to start merge resolution tool (gvimdiff):
> 3 files to edit
> Testing/Data seems unchanged.
> Was the merge successful? [y/n] y
> fatal: unable to stat 'Testing/Data': No such file or directory
> 
> I guess this is a minor issue, but I thought I should report it here.

I assume this happens when you do the merge in a work tree where this
submodule does not exist? Right now git does not populate submodules
that show up while switching branches or doing a merge. I am working
on that feature, but progress is not as swift as I hoped ...
