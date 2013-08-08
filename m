From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 5/5] rm: delete .gitmodules entry of submodules removed
 from the work tree
Date: Thu, 08 Aug 2013 19:11:04 +0200
Message-ID: <5203D128.7030705@web.de>
References: <51F8187F.7040603@web.de> <51F81957.1000709@web.de> <52014B4D.3090602@web.de> <7v8v0efrs3.fsf@alter.siamese.dyndns.org> <20130807182809.GA15123@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 19:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Tk5-0008NX-6B
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032Ab3HHRLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:11:11 -0400
Received: from mout.web.de ([212.227.17.12]:62926 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757993Ab3HHRLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:11:10 -0400
Received: from [192.168.178.41] ([91.3.187.57]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Lba35-1Vql2O3yih-00lDny for <git@vger.kernel.org>;
 Thu, 08 Aug 2013 19:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130807182809.GA15123@paksenarrion.iveqy.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:0RZCQVHr18j3cPk0mz1qtaIiHeH/t625eppVxyfQ0NzKPIzM5zD
 +AiUYFAth1uhAyB7Msv/Q70ZiTAX9eVcK1uZi3p8N0fqqpIuwObNagjPmMx0WvHwNOgIymX
 dKDeflMWchYj5wr0qHe9F2GF6P6EVeSRbjSPQyWwnsQapN4TgUwq5S1+CxfVAxA6NWjBq7J
 p989YLdz15DS4j1qkIXiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231904>

Am 07.08.2013 20:28, schrieb Fredrik Gustafsson:
> On Tue, Aug 06, 2013 at 02:11:56PM -0700, Junio C Hamano wrote:
>> Thanks, will replace the top two commits and queue.  Looks like we
>> are getting ready for 'next'?
> 
> I'm a bit curious about if we should move towards a reentrent libgit
> (which would for example make multithreading easier) or not.

I'm not aware of such an effort in core Git (I always thought that
libgit2 is the project doing what you seem to aim for).

> If so, I suggest that this patch only use die() in builtin/. However I
> know that there's a lot of die() all over libgit today, I'm curious
> about what direction we're heading.

The die() calls are just one part. Global variables are another issue,
we have memory which is implicitly freed on exit ... so unless we
commit ourselves to fix all those issues I see no point in moving the
die() calls into builtin/ in my series.
