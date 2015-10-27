From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Tue, 27 Oct 2015 16:50:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de> <xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com> <20151027012336.GK31271@freya.jamessan.com>
 <xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 16:51:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr6Wd-0005lM-75
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 16:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbbJ0Pu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 11:50:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:60075 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbbJ0Pu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 11:50:57 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LaJWs-1aDXVZ2GUw-00m3Ek;
 Tue, 27 Oct 2015 16:50:39 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:6AIYLjL+9tNr0HR2FAldFOh0d7htUjR0K9oZKz3k4ktWXxBc/Nl
 rkgbtVg/vjob2Rl1NTVTltWPHOxHVFgCABL71InMbZ3DKElJ2bdL+OfTbkogzMOoLEbkL0z
 amSQqBTtrPYikB/c2+W6nkOAQUujCtIHVpXc80UPmjv1XBHJnRNeXE8KyA5jn1dEC5wZAQI
 93+AwisVjfee61yU8icCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rdCok3UinSk=:VttoBJ2FFUYqUJDab8yjmA
 vb31PFIShMa/WlDFi1d1JOakRly8YOG8JOHu4DrbrKyOSnI9HrUzAuYbAgwW4lRH9JzQ3YNCv
 kUzTom5F9gZE6+QQ9+TCprZmiRrB282Snk7XUSeTdYuFcZtCe7EupCk09WJcE07Neb8yW3zQf
 n4RGDEFHpaxvB3jbSHlcMYj8T9SkIfNvxheJaE+tp/rliEDbgA+1iP1GCjskvg6jnXWyg5fip
 7zIdXJCmTA9hvePzIRnIm2UTZHUgNX2K+s3h3I/jJIZjfAeyfqaNAAuGrB9y20yzvxg7UZF73
 a+ZTcXIUi5Kw+yD5sLrobo1p5o6iQV3wrE2pYgbKuwpqRq100YN3LDm4N6bAvw7am01mmu/J0
 A8M1I6PSvsmsOFQUHn58vxON/e9RJCvH63M//pUZevtkb/QkHsvw7l+0dUstSMW/+A/2AVOWa
 TVn+FM11VHAZ3zTNa4MgUhHLUSQNXsZxa9xKZL6go2lWH9cHpj1mk5Wo8RIhH0wFFYPhSJapw
 wS0cc0DSTxEC+4dA7HiFu50VlwN44+rJ5uxjiLNyfqFXLltGmKsp58n6URdr5HGkZ5cqnwV9W
 sypxSU7qi6ecL3tDFc1d6OtHRzis56tdv4OR3Lm89Kg42nIJPY7ZINX6Y0f/gX6OQxTihwfaC
 i1VaGYZeY/JfOCrYRVBpPng32VDgjtYysJyg0OmOxvW5rH7z/8lfiMIyxHuS+UY/TeozmLlAP
 YYDrG3j21Aq9l08HmnEKvQkS6FS3amARzueGT/yS1Da4xU5Ihqh9nlFbgJVvFPqlKrd8dZqh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280266>

Hi,

On Mon, 26 Oct 2015, Junio C Hamano wrote:

> James McCoy <vega.james@gmail.com> writes:
> 
> >> The code looks OK but the last paragraph makes _us_ worried.  What
> >> is the licensing status of the original at SO?
> >
> > According to Stackoverflow[0],
> >
> >   As noted in the Stack Exchange Terms of Service[1] and in the footer of
> >   every page, all user contributions are licensed under Creative Commons
> >   Attribution-Share Alike[2]. Proper attribution[3] is required if you
> >   republish any Stack Exchange content.
> >
> > [0]: https://stackoverflow.com/help/licensing
> 
> Yes, and (please correct me if I am wrong--this is one of the times
> I hope I am wrong!) I thought BY-SA does not mesh well with GPLv2,
> in which case we cannot use this patch (instead somebody has to
> reimplement the same without copying).

Pat, could you please allow us to insert your SOB?

Thanks,
Dscho
