From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 10:13:06 -0700
Message-ID: <451AB122.9020600@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 19:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GScyE-00038N-6e
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 19:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWI0RNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 13:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWI0RNM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 13:13:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:46372 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030459AbWI0RNK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 13:13:10 -0400
Received: by nz-out-0102.google.com with SMTP id n1so116932nzf
        for <git@vger.kernel.org>; Wed, 27 Sep 2006 10:13:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CAsyNzSFhYAlkLcGK0xc3O26XxOusY+HFPcrUdDBjGc+5BHEBLxh5xb1ELSEQa1TSOB/lu117Rctx5G752fN682WPyWCkiQ88POovL2dDZBJ2P/n2dDJ+rGA2H+g8smSwDWUMmb1QZa/XnvkpE0mI2Us2uu0lY5YhPxtFa0Ikp8=
Received: by 10.65.112.5 with SMTP id p5mr295862qbm;
        Wed, 27 Sep 2006 10:13:09 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id q15sm1034044qbq.2006.09.27.10.13.08;
        Wed, 27 Sep 2006 10:13:09 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27914>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 27 Sep 2006, Martin Waitz wrote:
> 
>> On Tue, Sep 26, 2006 at 03:33:49PM -0700, A Large Angry SCM wrote:
>>> So, for each subproject of a parent project, you want to record branch, 
>>> version (commit ID), and directory location. Not quite as easy to do in 
>>> a makefile but do-able.
>> I've been playing with this kind of subprojects a little bit.
>>
>> My current approach is like this:
>>
>>  * create a .gitmodules file which lists all the directories
>>    which contain a submodule.
>>  * the .git/refs/heads directory of the submodule gets stored in
>>    .gitmodule/<modulename> inside the parent project
> 
> Taking this a step further, you could make subproject/.git/refs/heads a 
> symbolic link to .git/refs/heads/subproject, with the benefit that fsck 
> Just Works.

Wouldn't an fsck in the parent complain about missing objects?
