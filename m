From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] diff: don't read index when --no-index is given
Date: Mon, 09 Dec 2013 21:55:39 +0100
Message-ID: <52A62E4B.8080001@web.de>
References: <20131209192000.GS29959@google.com> <1386621634-25444-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 21:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7rs-0000Va-0i
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120Ab3LIUzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:55:48 -0500
Received: from mout.web.de ([212.227.17.11]:59073 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932820Ab3LIUzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:55:47 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MfYTr-1WE7pb0pAZ-00P4n0 for <git@vger.kernel.org>;
 Mon, 09 Dec 2013 21:55:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <1386621634-25444-1-git-send-email-t.gummerer@gmail.com>
X-Provags-ID: V03:K0:00Qq/uT49AztXKT5hDRHTOo5szyGOSOaVPYrhTnYXoX6y9qEBqW
 TtOwzFaBKGXAeDbz0vFAwji9B4pmM47YuMcNp3ldwCjZWfQI/+K86yWbNM8vB4qhtD588wa
 CWs9gCLXpZmw4+Af4PBp6JrXZnB+VFT7kEZTpqsy21T9jBUcI2Hzk7wc8pMVjCezoqPpVLL
 oHbEMWIwGUBcG5vVD8LAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239095>

On 2013-12-09 21.40, Thomas Gummerer wrote:
>  
> +test_expect_success 'git diff --no-index with broken index' '
> +	cd repo &&
> +	echo broken >.git/index &&
> +	git diff --no-index a ../non/git/a &&
                                           ^^
I'm confused: Does this work with the trailing && ?


(and when we use
"cd repo"
it could be good to use a sub-shell (even when this is the last test case)
