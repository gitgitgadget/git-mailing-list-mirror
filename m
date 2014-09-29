From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Do not make trace.c/getnanotime an inlined function
Date: Mon, 29 Sep 2014 22:40:21 +0200
Message-ID: <5429C3B5.5020401@kdbg.org>
References: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>	<54285E51.3090209@kdbg.org> <CAP30j14QGtHC7huU=3t4sJT_dZ3t9V=CBWyGyJW7EjT9H5ZK9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: karsten.blees@gmail.com, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 22:40:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYhkJ-00055l-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 22:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbaI2Ukb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 16:40:31 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:41720 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751742AbaI2Uk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 16:40:29 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3j6Fwg5RvFz5tlB;
	Mon, 29 Sep 2014 22:40:19 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1323819F5C3;
	Mon, 29 Sep 2014 22:40:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <CAP30j14QGtHC7huU=3t4sJT_dZ3t9V=CBWyGyJW7EjT9H5ZK9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257638>

Am 28.09.2014 um 22:42 schrieb Ben Walton:
> On Sun, Sep 28, 2014 at 8:15 PM, Johannes Sixt <j6t@kdbg.org
> <mailto:j6t@kdbg.org>> wrote:
>     Am 28.09.2014 um 09:50 schrieb Ben Walton:
>     > -inline uint64_t getnanotime(void)
>     > +uint64_t getnanotime(void)
> 
>     But then the function could stay static, no?
> 
> 
> This function is used in several places outside of the translation unit
> so while it's possible, I think it's more work than it's worth...

I see. I didn't check myself, sorry. I assumed that due to the 'inline'
the function would not have been available outside. Now your patch looks
good.

Thanks,
-- Hannes
