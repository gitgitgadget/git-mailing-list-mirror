From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 1/2] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
Date: Sun, 8 May 2016 09:04:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605080858190.4092@virtualbox>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com> <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com> <1462546167-1125-2-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gitster@pobox.com, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 09:04:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azIlP-0006HW-Es
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 09:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbcEHHEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 03:04:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:60122 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbcEHHEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 03:04:23 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MELdk-1ash2y1nZ2-00FRPw; Sun, 08 May 2016 09:04:12
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1462546167-1125-2-git-send-email-pranit.bauva@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:o+mcmtddR9WGNvCijBs/xw1Ooh4kvjbgU7U6gT/oIYIbl7dj4At
 C+qTyweoaM4aP32RGz3BD57NLkO+3PY0t5SWB8875Fw5PKokKuQiUu7pRb1NbuMJ32e6Vfl
 gzEpwZy/2eoYFZCscUo/R4pXQsLCQMKQh1QKVSY80PnNg1musK/wTXlLN1h+zLcFs6Ue/ds
 l6VJOFPtxK6GnHLsGJwNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SvU54yzlm1c=:IEcs8n+8DzFcJKAmyQtg9K
 VwdNXZVhF0WbimXcq3pthJwE4mIvIFNebHDFxZ86YzHULoFf2c0qfNJ9VAWOGEkh317IJudla
 uG4Jg06V7oOSSEjFrjuvoXDSQmHGkZ1rIBQJvg+FnNapsAWYXRjKZdhtHjQmAExX7Wo9UDmXB
 lmKgfE14e21vYl5/eLejKCcuEP3Uz42Kt6zXTZ517r/Hyabd46YNp4PDwFqx3ej7zw7nDUzhP
 8QS+z/FwGDjxUOfV1sI0a7GYi4o4K88lcByEwn8WuadylAMXOHyA9acwSlc6TYvMehiuN3Jcf
 W7DGcmvc+0zXM4r6LJ1dcfJboRtQdGnB0dzx9bqZcWkOYs+A2gI9YxaljbpHQipbdzpT41jmi
 8h2+mVIqmCzF1Ap4POPeOGxUSEkO/MBdZqEq+9+NN+UGKDNaPcSH6oF8X2tdnymXVz7DBPQ+/
 TU5syNpAMDw88GbL4mzEmXbBv0suYCXigGAy8NX1F8ZJSG9ZoLulBr7IPE6d9RLp5ijHhZmCl
 bQCfXOPGsIh+kGseqtinMYqTd1/sVdVmHXgFTrxYcVzL3PMoBXXm/NJJqpJrvK9w301cFKLNd
 H7VDA4oqt8tBULXsr5r4zvsu0K2GrG+RoLVUR+1k4vdoFksrLfXOT67DB9TQN9ulb6AmuQazd
 nC7Z1rDheTckMbKJTehx3R6Nyp6ajmq3zRQQWCGkfDlCzvFY1AQcb7z5xUghr8R9P2k4MEGgP
 KFGDeCykr9hnZRpZdwdXtmMaKWy0AW9AyGKt3yBxQZTjIqwJSE3Fuop02fjI77V6fNVp57lV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293913>

Hi Pranit,

On Fri, 6 May 2016, Pranit Bauva wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3324229..d8de651 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
>  	NULL
>  };
>  
> +enum subcommand {
> +	NEXT_ALL = 1
> +};

I still do not think that this enum needs to have file scope. Function
scope is enough.

>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -	int next_all = 0;
> +	int subcommand = 0;

Since subcommand is not simply an integer, but wants to take on the values
defined in the enum above, the type should be changed accordingly. You
could do it this way (short and sweet, with the appropriate scope):

	enum { NEXT_ALL = 1 } subcommand = 0;

See https://github.com/git/git/blob/v2.8.2/builtin/replace.c#L423-L430 for
an example (which uses "cmdmode" instead of "subcommand", too).

Ciao,
Dscho
