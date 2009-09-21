From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Mon, 21 Sep 2009 13:34:26 -0500
Message-ID: <HfI-UY0xo4DwMQZzRdb4aklE18OmVn-XMfoIB2UHx6G-nEoneRq5rQ@cipher.nrlssc.navy.mil>
References: <20090921160551.GD8173@gryning.com> <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: c@gryning.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 20:34:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpnil-0006FY-Ir
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 20:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbZIUSed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 14:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbZIUSed
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 14:34:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56031 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbZIUSec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 14:34:32 -0400
Received: by mail.nrlssc.navy.mil id n8LIYRMk007061; Mon, 21 Sep 2009 13:34:29 -0500
In-Reply-To: <7vskeguqmb.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 21 Sep 2009 18:34:27.0124 (UTC) FILETIME=[2634E740:01CA3AEA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128900>

Junio C Hamano wrote:
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> 
>> Craig Taylor wrote:
>>> Hi all
>>>
>>> I'm compiling/installing git in a Solaris environment without root.
>>> Using 'make DESTDIR=<some path> install' to stage an install to an
>>> alternate location.
>>> The perl module component of 'make DESTDIR=<some path> install' installs
>>> into the system perl lib path without prepending the forced install
>>> destination or my '--prefix'.
>>> This seems counter intuitive and I would consider a bug.
>> Try 'make prefix=<some path>'.
>>
>> btw, this is in the first paragraph of the INSTALL document.
> 
> But is that what Craig is trying to do?
> 
> I think he wants to build git to be installed in /usr/bin/git or whatever,
> and he would say "prefix=/usr".  He however wants "make install" to write
> into /var/tmp/g/usr/bin/git, not /usr/bin/git, so that he can for example
> make a tarball with "cd /var/tmp/g && tar cf ../git.tar .", and extract it
> as root under the real '/'.  "make DESTDIR=/var/tmp/g" is exactly for
> that, and if it is not working I would say it is a bug.

Ah.  I did not realize that that is what DESTDIR is for.

Thanks for the correction.

-brandon
