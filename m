From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [git-for-windows] How is detected binary files?
Date: Fri, 27 Nov 2015 15:14:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511271510520.1686@s15462909.onlinehome-server.info>
References: <487b881f-9e3e-4d22-ba1e-af3beeaccd6e@googlegroups.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git-for-windows <git-for-windows@googlegroups.com>,
	git@vger.kernel.org
To: Andrzej Borucki <borucki.andrzej@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 15:15:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2Jnl-0000Rt-Fk
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 15:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbbK0OPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 09:15:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:52358 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbbK0OPD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 09:15:03 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MLB89-1a2amZ3RmD-000ILj;
 Fri, 27 Nov 2015 15:14:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <487b881f-9e3e-4d22-ba1e-af3beeaccd6e@googlegroups.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:+SxYzOwL/7VOOfxOLGvcpJ0Yhbissg/naHcGF945OpEhJ4RnLWb
 szpPIg+apff8kmabyYqb9C9kmvRuNI/7g9ZZMWVvkZHOSY1kdJ44aoLRbw7Nb8uQks5dCt4
 9FQuUp/pZphXwscLUAC5qM/pgxDcJ04XpydTD2jodzIVaLNhj8MUbYsOw7XT/HkuitK/AXS
 5BVsrIp5d3tl7DGJ/DwkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zXhFEAQWUp4=:gRe126WR/JjlMSrQ47slwM
 u6Dsm32exkOlzEmufwmgJYay7vbe2VMcqz5KwUavn1MfQKMmgU1sNP+yxabv165XKZFY55sEo
 ppSj1SQN7fhOVJPpixaiT8RRigCpneEjqWmA9FTjigzKWuzFp6F582XzK8wBsAeaelezO6X8C
 C5QeVjTDPW6ZUIlkSDuKenHR7YOcqqewqJkF8MzIbU43LOx21djseNhvmNl7KJP5alAbLLby0
 Impbfk+XKRy2Tg4v5zj3G+yj5UpwYq5UrXVHKwFXSS199sBqYglZf37M1bPS+m7spa+Xw6wt4
 IItCwwH41y7H+s7IV42RoRmDdKmOQYR2Q8IInbA8up+3FO8q2wKFe52CeoXjSElorMO3pFdjK
 PSWNMO3LYrsJp9gbz4IV1IUVPORoAFngfl5M5MJiBeP7xdLUUu0tZ4BWqyVCNT0tDU5+76Vo0
 66gDcKE1eZagGUe0wU6TbbMkeGwXnmQgiqXX4Fqde32sUtDF29BprPvD/E11u5XMBsFDPF/NJ
 Vp0Xqplzn0zWKZcanwuRdWjfWuIrLdTxksiO4GIkP4UhK1yNv/j3SMR2QUrTw+HEYqunuu8YV
 ZtDpwiuk1rYjpaFPb13qE4B+dAwVKtciXHXHza/fomb2BunoYv5G3x2PvWjm+SEO1JkwHCBNd
 kUCwn2rUoEO59D/USxqysE5ygrnqSDJmRd/Ki0CW/4zJOaVAwi/YeclvOWFLIGjPqv8hvra+x
 jk78Z8+oqhRuA3PnF+d5levOcz37t44+T+UFVB9ZTHCiQX7YZq2xKzuoE5CWcUQeS31cQ+F0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281776>

Hi Andrzej,

On Wed, 25 Nov 2015, Andrzej Borucki wrote:

> How git detects that file is binary? This must be safe because it not 
> allowed to change line breaks in binary files. 
> Binary files can contain byte 0 (zero), but:
> - 16 bit UTF also can contain zero
> - short binary files can not contain zero

It would probably be better to direct this question to the general Git
mailing list (you reached the Git for Windows one, and this issue is not
specific to Windows).

To answer your question, a NUL byte within the first 8000 bytes is indeed
considered as an indicator for binary files.

If you use UTF-16, you will need to mark your files as such explicitly
(Git does not handle UTF-16 internally).

As to short binary files, you will also have to mark those explicitly.

Ciao,
Johannes
