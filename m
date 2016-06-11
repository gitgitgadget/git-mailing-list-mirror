From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 31/44] run-command: make dup_devnull() non static
Date: Sat, 11 Jun 2016 10:17:47 +0200
Message-ID: <575BC92B.4080401@kdbg.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
 <20160610201118.13813-32-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 10:18:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBe7U-0004jb-VG
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 10:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbcFKIR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 04:17:58 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:10418 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbcFKIRv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 04:17:51 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rRX3J2DQ2z5tlF;
	Sat, 11 Jun 2016 10:17:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6D1C052A4;
	Sat, 11 Jun 2016 10:17:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160610201118.13813-32-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297091>

Am 10.06.2016 um 22:11 schrieb Christian Couder:
> --- a/run-command.c
> +++ b/run-command.c
> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
>   }
>
>   #ifndef GIT_WINDOWS_NATIVE
> -static inline void dup_devnull(int to)
> +void dup_devnull(int to)

I'm not adding arguments to what we've heard on whether to use /dev/null 
in this series or not. But if the outcome is to keep this patch, please 
remove the #ifndef that we see in the context lines (and the matching 
#endif), too. Otherwise, the build fails on Windows for each patch in 
the series until this change is reverted in patch 42/44.

-- Hannes
