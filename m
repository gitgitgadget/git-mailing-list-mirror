From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v4 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Wed, 9 Mar 2016 01:25:11 +0100
Message-ID: <56DF6D67.9040103@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de> <56D401C2.8020100@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 01:25:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adRwF-00007T-Nx
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 01:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbcCIAZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 19:25:16 -0500
Received: from moritzneeb.de ([78.47.1.106]:57565 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbcCIAZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 19:25:14 -0500
Received: from [141.23.78.21] (wlan-141-23-78-21.tubit.tu-berlin.de [141.23.78.21])
	by moritzneeb.de (Postfix) with ESMTPSA id 370191C04F;
	Wed,  9 Mar 2016 01:25:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1457483112;
	bh=K2z9eLR8Y96ex0GbUq9TvEWYKXDpsLw+pXy2ZFQw/tQ=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=Cs8h7txz0HsxeqMv3b6M9W6BIzBqlsUHrMWSpZ+yjXi3GYL2C/NxhejrzTtINkKMx
	 RyN+OMwDuNW846Z4oMXi9jzKGtUHWHcV6pniX/7HNE2VXWEgf982m8JZuqfd8J3mmP
	 GQxFczqp5RIy5zLteXneXeOm1CaFZ7o/qvxjy7f4=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288464>

Hi,

how to deal with patches during the v2.8.0 rc freeze? Will they wait on
the mailing list until the feature release cycle is finished?

Or if it's me who should act on this series, because it got below the
radar during the rc freeze?

To my knowledge there's only minor points that have to be discussed:

On 02/29/2016 09:30 AM, Moritz Neeb wrote:
> 
> Moritz Neeb (7):
>   quote: remove leading space in sq_dequote_step -- as in v2

in patch 1/7: How many spaces should be removed, cf.:

	http://thread.gmane.org/gmane.comp.version-control.git/285118/focus=287911

>   bisect: read bisect paths with strbuf_getline() -- refined commit message
>   clean: read user input with strbuf_getline() -- simplified commit message
>   notes copy --stdin: read lines with strbuf_getline() -- switched with below
>   notes copy --stdin: split lines with string_list_split() -- switched with above

in patches 4/7 and 5/7: Which commit should remove the trimming of
"split[0]", cf.:

	http://thread.gmane.org/gmane.comp.version-control.git/285118/focus=287894

>   remote: read $GIT_DIR/branches/* with strbuf_getline() -- as in v3
>   wt-status: read rebase todolist with strbuf_getline() -- as in v2
> 
>  bisect.c        |  5 ++---
>  builtin/clean.c |  6 +++---
>  builtin/notes.c | 22 ++++++++++------------
>  quote.c         |  2 ++
>  remote.c        |  2 +-
>  wt-status.c     |  3 +--
>  6 files changed, 19 insertions(+), 21 deletions(-)
> 
