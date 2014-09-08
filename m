From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [RFH] renaming strcmp/strncmp-icase
Date: Mon, 08 Sep 2014 23:36:15 +0200
Message-ID: <540E214F.5010708@web.de>
References: <xmqqmwaalzb4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 23:36:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR6c9-0007Vl-SD
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 23:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbaIHVgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2014 17:36:38 -0400
Received: from mout.web.de ([212.227.17.11]:52911 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254AbaIHVgi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 17:36:38 -0400
Received: from [192.168.178.27] ([79.253.187.29]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MSaZk-1XqRU731xk-00RYY4; Mon, 08 Sep 2014 23:36:35
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqmwaalzb4.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Q3mjuJE8jdrMhHUttCR7mhJj1xaeSKeLfmC/uWiZLmPBQnOBX2c
 +gtsjQyh1l+eC19TnsTQvTSqeLJN2pABcR7Vtqez8p10wls2Fz3xyFtCGppoHsvqA8g3IqB
 bQ0HAzZC2yhuvbL5kkkMEA/ZAAKhA/U2bYLlefaq0mtM9dz+ObEwrzfYr1egN9XgJgKa5gl
 lt0iWxCKcO7rmop49fnUQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256679>

Am 08.09.2014 um 20:52 schrieb Junio C Hamano:
> There are these two functions in dir.c that has only a handful of
> callers outside:
>
>      int strcmp_icase(const char *a, const char *b);
>      int strncmp_icase(const char *a, const char *b, size_t count);
>
> How many of you would think these are about comparing two strings in
> a case-insensitive way?
>
> If you raised your hand (like I did), you were wrong.  These do
> comparison case-insensitively only on a case-insensitive filesystem,
> and hence calling it makes sense only for pathnames you grabbed out
> of the filesystem via readdir() (or the user gave us, intending to
> name paths).
>
> To avoid confusion, I think they should be renamed to stress the
> fact that these are about comparing *PATHS*.  As I always say, I am
> bad at naming things and good suggestions are appreciated.

> pathnamecmp()/pathnamencmp() perhaps?

"namen" looks strange to me.  How about pathcmp/pathncmp?

Ren=E9
