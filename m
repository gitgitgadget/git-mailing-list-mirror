From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 25 May 2016 18:49:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605251844580.4449@virtualbox>
References: <20160525020609.GA20123@zoidberg> <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605251406020.4449@virtualbox> <xmqqoa7u15lq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 18:49:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5c09-0006LE-Jj
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 18:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbcEYQtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 12:49:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:49181 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824AbcEYQti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 12:49:38 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLNpK-1b69xh1GiY-000Yfe; Wed, 25 May 2016 18:49:31
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqoa7u15lq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fKOyEjdkT39m3yztqT86iASI4x6PD/foeenh8KrlnosxM0SuAa8
 9ojtqlmx7IEQWFvl2UysntKU9lfv8LhRl6nnRNyTb8CtIDup+TdZBmFSce9G6dQ8QhXMOO1
 5K1i1aUcCz8klZ0niXzdpUkJcs7su1wHfgpGbO4ulRdLfVUge+D5kYWGOO6CCFtUpxiLnWq
 ttL9hM8ABr6h3k5aVabpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jdXh+zqWjFk=:LCNUtwU5ZrF2NuZn4+sjXX
 2FiQ4UtkL13anelBT8lV6YOo+rFLgQKu0at747DiztaXc03i2mA5g0+EAxukXG8oF3ebfU9pJ
 g7R/H0sIZhuKHz7Bt6i1YYltKLvNQKQByKvkWLZ15a0363yB2qOA5hLduR/JxBQ93g5rrwq51
 mQG3+kfySiJ05Mj/RZBDVBOtlNoaL6lC5f9KRnrl6/5doG5Tun0wfpYTVfSYUtoe4tZZ5Gvu/
 ZrTOT2SEEYCaA7T8dq7jig73JCN4GHhmdM1EbrokKu+nyasaYyXKHFU6XLU1fQpI1+Tq8F43n
 2lR5FCZN+RXWShrZ+/4nLv0JLnFN0Piepv2OAchPOpZS+c3DNtxK3vuD/QYzcFfykMCAo8OmK
 BuSqVRiuixgU1G46pmvXGmtU58B8e48jo4CbefmBiRX6It+WDFW+dCfIcWBpiXGiSoPSksi3s
 dF+9gNfndYSvPf1q83W4JAqCfhQ9N1QQ/Ha/meJgoCKuXV60cacUVOcqZ5T8MrASUOJ9Vqfhg
 bx9BoY4Gc3f17g4YMe/ZWOe5gEvqMlkjlOimGCO0zEYb5D23kJdCa+gpncuFbWWotd42bu4LV
 drmvGVLMPMa2XO7M89VBcKSfY8LwvviGrlo6cfBhrFuumbF1aqDP+f2rtKC1rd9lwnTYPKlTF
 O0ZCg4N8YiSImiQ93mOsqxETbhUOXFCz48rnRPm2eRFqkrfB3kBOS3pBpKR/SDy+ZkN1FQkbN
 oljgaHL7wbxN6Hl8Zh6BmvQDcfcaNqkgnkuiyff0pv8xsYBkEA8B+3onBaUKFnX1NoJCB6on 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295580>

Hi Junio,

On Wed, 25 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 25 May 2016, Junio C Hamano wrote:
> >
> >>  * I am not familiar with life on filesystems with core.filemode=0;
> >>    do files people would want to be able to "add --chmod=+x" share
> >>    common trait that can be expressed with .gitattributes mechanism?
> >
> > I think it is safe to say that the biggest example of core.filemode == 0
> > is Windows. On that platform, there simply is no executable bit in the
> > sense of POSIX permissions. ...
> > ... I still like Ed's idea and would love to have it: it is murky waters to
> > require users to call plumbing only because our porcelain isn't up to par.
> 
> I thought that I made it absolutely clear that I like the addition,
> too.  If it wasn't clear enough, I can say it again, but I do not
> think you need it ;-).

Oh, I understood that you liked it, sorry if my mail looked accusatory.

> The "attribute" thing was an idea that was hoping to make the system
> as a whole even more helpful;

I understood that, too. My first impression was that it would not be.
However, as Git for Windows can set default attributes in
/mingw64/etc/gitconfig, I guess it would actually be helpful. We could
automatically mark all *.exe, *.com, *.bat, *.cmd files as executable. It
would then still be the users' responsibility to add their own attributes
for, say, *.js, *.rb, *.py, *.sh, and whatever else.

Ciao,
Dscho
