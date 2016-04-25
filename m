From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] convert.c: fix some sparse warnings
Date: Mon, 25 Apr 2016 06:15:04 +0200
Message-ID: <571D99C8.3050006@web.de>
References: <571CFEE2.2070708@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 25 06:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auXvf-0004Kh-LU
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 06:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbcDYEPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 00:15:18 -0400
Received: from mout.web.de ([212.227.15.14]:51450 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbcDYEPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 00:15:17 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M1noI-1bjcJ61xj0-00tmvU; Mon, 25 Apr 2016 06:15:06
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <571CFEE2.2070708@ramsayjones.plus.com>
X-Provags-ID: V03:K0:4H+gmOguO+NZEveInq19Rl9F6e24OdzmIVVfoTwwLL4go663nV1
 QJhbt4qybNIanSUmgAFRxkz3eLCxiVOpUiBo12YdlBmg31yrD6DVrN4wrJU5Zm/b2CxqkMp
 xgIzakPG5wXHg7pm44yR5bcS4Fa3ta2Y/yUwlRreRu8kUDHbNojkMkMW5Rl/5wz6zmMwFMu
 5K5I7/DZGtkS8z91Kyz9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZumaT0GDatU=:asAYE9iivHUWpnOZ2OPY+7
 7KzjYjOVk8gj7dWlgBgJC1H7+SQ3unOoGzVCMQnrn+8KXE7WQ9D9n8XaDrXTrbxBV+BgfbG6Q
 6ycCezcNbn78l+6YwNkbPVBmXK3hQxe9yQxETelMVoBaCXZYCj9hXXvCachXZAAqNXoq8l0d7
 aOLJuuNooX+uc/3snIDLDnY4PT66N9KLrPW6ujHelaWDZv9fGEyaaxfcmU2qEzxeemFw8h8SH
 n0267EJtA3uLdRhpd5T9+SI2dExyqvWF+y6ORIytC23FXc6BykQZ59jSNqNtSBKMSwWnaPEoK
 gDPS3g+3xP73lTNyS7/zKOl4YLT8WP75SDYZhffS1hcBDiyF0ddrBbybe0BS9y9oOBH2kxfe4
 TNOLn5W6dQQeZkLjRY4BdabcI+pgAmF+/KJQNwfHJBcBTxoA7QELWaDIhlF9jBph7xOg5eqQm
 TRJ6YbG3vknvUCDjpZTs//EaKMJ4ckX5GOUNO3eEt495x5uCP7+s/6nner85hZKlTl/hs01MS
 2EbSY+m0x8cv5XBt14nCAYIRG8bs0ad8jC1AFX+J8HhxHuTwtdAGmRKAsOE4ZOop0zVcu9RMQ
 REe2I7AjxCM5aSN9adkbAbSbuYDeoqJsNr/pB5oRqBCWKwQEqhfKS5r9yZOsRRoJr6woQoziX
 Y7BULr9W6lUc2jxe1HOdbX+ILLyQx/gH9ujb1/8JJWhtiIUOpU72ylKNIEIw9Do1Ls5AKrtxc
 Owiylqnbo4Ap0eS5xvc1Jpgg67znwRonE203gKwRKg8Ycisi3JwxIsE93uf67zcxyYbBzdWC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292448>

On 04/24/2016 07:14 PM, Ramsay Jones wrote:
> Sparse complains thus:
>
>        SP convert.c
>    convert.c:178:24: warning: Using plain integer as NULL pointer
>    convert.c:239:28: warning: dubious: !x & y
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Torsten,
>
> When you next re-roll your 'tb/convert-eol-autocrlf' branch, could you
> please squash this into your patch corresponding to commit cbcc0471
> ("convert.c: more safer crlf handling with text attribute", 22-04-2016).
>
> [No, you have seen this before! ;-) ]
>
> Thanks!
Thanks,
your update has been applied and was lost later. Sorry for that.
I will send out a v7, after waiting for more comments on v6b.
