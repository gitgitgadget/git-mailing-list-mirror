From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 00/11] Untracked cache improvements
Date: Sat, 16 Jan 2016 15:57:42 +0100
Message-ID: <569A5A66.3090907@web.de>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 15:58:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKSIn-0007IG-HB
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 15:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbcAPO6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2016 09:58:00 -0500
Received: from mout.web.de ([212.227.15.3]:49469 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbcAPO57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2016 09:57:59 -0500
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lo0YS-1ZelpC3Rsm-00g1oV; Sat, 16 Jan 2016 15:57:46
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:gicPYEXUx+VhmtEVAPo1dirE7GamNwfuZiDS9zBMAZPj6cTs57x
 1Roi3LLsoVfWW08dBxHVVTx9FL8Szr7D8FrvlQqYBfJLLwtDA3HltHzZwRNyBpWPsERsJas
 pclw32yfdZC8fQKTRUtWKO2ozEpfuDJzz/wM7OFlnCnAAv1bEX6ZQWhaSIWdXpfCxmZoroe
 wFtLnL+Oy3F3mi/duTNfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qeA+HaCzXmw=:F4nzOBMp9AkPwS9isGLrRw
 FMzTFgYiY4VjJi8ZeIcmL8nKJGXJ301Qnwb63K89IkOoWzxarFkDoYsakaEXbqTYeo+uPltfQ
 +y0+JP7q+8LT2MSbbZVl/FLhz+ef+q0WyA581BLcJilr2DA60HOlFuRza0dA3GIKCQhujhSAg
 rEiCBg8gdMIO2+yD3I36tlD0gWAdA1LxZHgeyeFD3b0vTdhC9hgvsfjUD1bNxpp51w8kn9/OW
 obsTfwERwXHwsoE4AdwDwWOI3N7jAhuVRo87nUePcI9+eu+VyO8u+xv6C6L30FbfY2OZK3BSy
 sBYQdNrcaeY4zhhD8vhAD2xNgsjWQzaAiL7vfmH4sdp67AvHbf8fmOlwtDo9Xnx/Kigi3dPCk
 h5qKm5qV1ViKug0TN7GnktJeusA9BatrmyH+CpHtH00Fl2d0l7XdwxJOqC8DwefYWKW/bD7tM
 HlTEUECZm9EPGza+D5N1hUzTH8hqUTIu/9+8T4lg3v7Wa15WQkc0lqRkp8254K/QM0g/yWsEK
 H1C3M3Sfp4KNYsvvG3Gz63g1KrXWJywtb9duyvArSBuC+mMbNwr66+iFmV71JDxhX1taIclAQ
 3k/t35k46aZwyD6JnqprScK5DWEI2AtLN20ugfLyabh9l+1WSL/W4yx0kdgTbAGJjY16UqCur
 NZvLfHm+jd5jzga1JgR5JVEWVwO9XZtz0/RY5cuK3Mk0KV8sRBs1DmfAcIo0ZkZJEkcoBI8Ym
 bFmoeWnEShRaA8Ys/7G7ak92vKCfzGb1lrA5Rskygnb6+aRrE0j/VIzQlJgHOggC6nEXNLDm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284244>

General question after testing UC on a slow network share:

time ./git status
On branch uc-notifs63
Your branch is up-to-date with 'cc/uc-notifs63'.

It took 6.27 seconds to enumerate untracked files. 'status -uno'
may speed it up, but you have to be careful not to forget to add
new files yourself (see 'git help status').
nothing to commit, working directory clean

real    0m19.159s
user    0m0.085s
sys     0m0.293s
----------------------
Does it makes sense  to hint the user about the untracked cache ?
