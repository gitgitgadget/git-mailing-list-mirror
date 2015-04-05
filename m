From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 0/6] address packed-refs speed regressions
Date: Mon, 06 Apr 2015 01:04:53 +0200
Message-ID: <5521BF95.4030207@web.de>
References: <20150405010611.GA15901@peff.net> <55213B93.9050207@web.de> <20150405185259.GB13096@peff.net> <20150405185911.GA19902@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:05:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YetbV-0003kb-JF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 01:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbbDEXFD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2015 19:05:03 -0400
Received: from mout.web.de ([212.227.17.11]:53448 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbbDEXFC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 19:05:02 -0400
Received: from [192.168.178.27] ([79.250.182.13]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MS2LO-1YqT8u3zy6-00TB8o; Mon, 06 Apr 2015 01:04:55
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150405185911.GA19902@peff.net>
X-Provags-ID: V03:K0:ZZlcpPmTm0coN4yp1DO0UpDTPtV9qrcP8/El8gae1D+g5PLrdyC
 i5iEeyoZ2auG680QuFqOR7nO7eF3yf3wPoCJErUDNjSkzMsjeB22VwHNmr/ACnUUZYpMTbR
 amRckQB7tkrd6rxhRL6DUMivzEHPRIn8+w98xELVBhE4sSB5nwBHrnEPOq/fVWBwMFLonEp
 OAGaAKyzVlfCczyUUi7IA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266825>

Am 05.04.2015 um 20:59 schrieb Jeff King:
> Still, the numbers are promising. Here's are comparisons
> against for-each-ref on torvalds/linux, which has a 218M
> packed-refs file:
>
>    $ time git for-each-ref \
>        --format=3D'%(objectname) %(refname)' \
>        refs/remotes/2325298/ |
>        wc -c
>    44139
>
>    real    0m1.649s
>    user    0m1.332s
>    sys     0m0.304s
>
>    $ time ~peff/git-quick-list refs/remotes/2325298/ | wc -c
>    44139
>
>    real    0m0.012s
>    user    0m0.004s
>    sys     0m0.004s

Sweet numbers. :-P

I'm not familiar with refs.c, but its sheer size alone suggests that it=
=20
won't be easy to integrate this prototype code there. :-/

Ren=C3=A9
