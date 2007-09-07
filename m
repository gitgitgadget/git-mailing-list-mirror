From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 22:27:55 +0200
Message-ID: <851wda2pbo.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.0709061839510.?= =?ISO-8859-1?Q?5626@evo?=
	=?ISO-8859-1?Q?.linux-foundatio?= =?ISO-8859-1?Q?n.or=04g>?=
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
	<fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>
	 =?ISO-8859-1?Q?=20<f=04br1a2$qm7$1@s?= =?ISO-8859-1?Q?ea.gmane.org>?= <851wda7ufz.fsf@lola.goethe.zz>
	<fbr4oi$5ko$1@sea.gmane.org> <85wsv26cv8.fsf@lola.goethe.zz>
	<fbsbul$dg0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:28:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITkQs-0008N2-8s
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbXIGU15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbXIGU15
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:27:57 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:39340 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019AbXIGU14 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 16:27:56 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id D1FEE2CAE79;
	Fri,  7 Sep 2007 22:27:55 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id C433913F298;
	Fri,  7 Sep 2007 22:27:55 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-039-212.pools.arcor-ip.net [84.61.39.212])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 99C1635E727;
	Fri,  7 Sep 2007 22:27:55 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3EEF51CAD71D; Fri,  7 Sep 2007 22:27:55 +0200 (CEST)
In-Reply-To: <fbsbul$dg0$1@sea.gmane.org> (Walter Bright's message of "Fri\, 07 Sep 2007 13\:22\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4183/Fri Sep  7 21:19:48 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58067>

Walter Bright <boost@digitalmars.com> writes:

>  void foo(int array[10])
>  {
>     for (int i = 0; i < 10; i++)
>     {   int value = array[i];
>         ... do something ...
>     }
>  }
>
> to:
>
>  void foo(int[] array)
>  {
>    foreach (value; array)
>    {
>      ... do something ...
>    }
>  }
>
> takes a lot of frankly unnecessary things away, each of which is a
> potential source of error when maintaining the code.

The problem is a toy problem: in real applications, you'll need to
access several data structures using the same index, and you'll need
to be able to assign index values to temporary variables and so on.
So being able to hide the type of an index in one very specific
application (looping through a single array completely) at one place
is not going to buy you much.

Anyway, D is pretty much irrelevant as a perspective for git, so you
should take it to a language advocacy group.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
