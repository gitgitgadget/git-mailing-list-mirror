From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 6 Jan 2013 01:32:11 -0800
Message-ID: <20130106093211.GB10956@elie.Belkin>
References: <2491041.bQ51Qu8HcA@thunderbird>
 <1890551.8jTmplCF6O@thunderbird>
 <BB541ECCD3F04E479F06CA491DDB598D@black>
 <50E92675.4010907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 06 10:32:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trmat-0001bV-Hl
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 10:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab3AFJcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 04:32:20 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37368 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3AFJcS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 04:32:18 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so10050467pad.38
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 01:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H+yGEaQcLMSrfuA7UD+vxqTgzTVuxH6xxtfsIA/3md8=;
        b=nK2MlwKkKmkScXvqdCKpx/4fuf+zmAErgmbeb9AkELEfzkkP2bfXSRAo9VXZHIw71E
         af9sv6hmJk4nz/SXBPpS46VRNA+OYsoeRhFUF4w65N5eBMoOZveemoDJI78Aqjge5OOz
         vsuK8/9e4iiUL8JsyhNjfotHgZYrq2EBl8L/v+uGSaMI98GmkGLBP1/pMxiWAMi1Gv06
         b9unW+RZkRT2IvE3fgHi5D9HfMfPT6DMXN2yLAIU6nKjZ68J/Jq5VQqL25qeTrR7gWyK
         6UuGtUJVY5op5yiROkMPJaO2pjQ9Iad6iP9Fuu5+fxXPaIni1m9mxSVe+dVWZwK4b3Xq
         0opQ==
X-Received: by 10.68.252.4 with SMTP id zo4mr179137748pbc.126.1357464738240;
        Sun, 06 Jan 2013 01:32:18 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id a9sm849253pav.24.2013.01.06.01.32.15
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 01:32:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50E92675.4010907@web.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212788>

Hi,

Torsten B=C3=B6gershausen wrote:
>> Stephen & Linda Smith wrote:

>>> git co 9fca6c && make all
>>> ...   The make errored out as before
[...]
>>> git co 9fca6c^  && make all
>>> ... and this compiles to completion
>>>
>>> CYGWIN_NT-5.1 WINXPMACHINE 1.7.14(0.260/5/3) 2012-04-24 17:22=20
>>> i686 Cygwin
[...]
> You can either upgrade to cygwin 1.17 or higher.
> Or, if that is really not possible (because you are sitting on a prod=
uction machine,
> where no changes are allowed),
>
> You can enable this in Makefile:=20
> CYGWIN_V15_WIN32API =3D YesPlease

What I don't understand is why commit 9fca6c would have had any
effect at all.  Since 1.7.14 doesn't match /^1\.[1-6]\./, wouldn't
the setting to avoid including <sys/stat.h> and <sys/errno.h> be
unset both before and after that commit?

Stephen, what is the content of your config.mak?

Curious,
Jonathan
