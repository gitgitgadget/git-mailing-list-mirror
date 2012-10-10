From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Wed, 10 Oct 2012 18:55:22 +0100
Message-ID: <5075B68A.2010404@ramsay1.demon.co.uk>
References: <50706B54.8090004@ramsay1.demon.co.uk>	<7vbogfquc8.fsf@alter.siamese.dyndns.org> <CA+EOSBnKqkQ_nLyEKzxsMYnB04X9ABMp3P3CuDy3ohfcoEbQtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 19:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM0Xv-0008Au-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 19:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628Ab2JJR57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 13:57:59 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:49578 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751733Ab2JJR56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 13:57:58 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 2497D384081;
	Wed, 10 Oct 2012 18:57:57 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 644BB38407C;	Wed, 10 Oct 2012 18:57:56 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Wed, 10 Oct 2012 18:57:55 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CA+EOSBnKqkQ_nLyEKzxsMYnB04X9ABMp3P3CuDy3ohfcoEbQtA@mail.gmail.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207420>

Elia Pinto wrote:
> 2012/10/6 Junio C Hamano <gitster@pobox.com>:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> Elia, you brought the MALLOC_CHECK_ up.  Did you hear about this
>> issue elsewhere before, and if you did, do you know how other
>> projects solves it?
> Ok. I have found. For me this is not a problem any more these days.
> Was fixed in glibc 2.8.90-9 2008
> 
> * Wed Jul 16 2008 Jakub Jelinek <jakub@redhat.com> 2.8.90-9
> - update from trunk
>   - fix unbuffered vfprintf if writing to the stream fails (#455360)
>   - remove useless "malloc: using debugging hooks" message (#455355)
>   - nscd fixes
> (from glibc rpm changelog)
> 
> This is the bugzilla filled and closed
> https://bugzilla.redhat.com/show_bug.cgi?id=455355
> 
> Ramsay, what version of glibc you have and in what distro? thanks

The glibc version is 2.5, if I believe the changelog, along with:

    ramsay$ ls -l /lib/libc.so.6
    lrwxrwxrwx 1 root root 11 2007-06-24 19:44 /lib/libc.so.6 -> libc-2.5.so*
    ramsay$ 

... but the header files tell a different story:

    ramsay$ grep 'define     __GLIBC_' /usr/include/features.h
    #define __GLIBC__       2
    #define __GLIBC_MINOR__ 4
    ramsay$ 

The distro is Ubuntu (but I can't remember which version; I would have
to re-boot to find out so ...).

HTH

ATB,
Ramsay Jones
