From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v3 1/6] git-fetch.txt: document fetch output
Date: Mon, 6 Jun 2016 10:24:28 -0400
Message-ID: <5755879C.3030602@xiplink.com>
References: <20160603110843.15434-1-pclouds@gmail.com>
 <20160605031141.23513-1-pclouds@gmail.com>
 <20160605031141.23513-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 16:24:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9vSF-0003ht-3j
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 16:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbcFFOYb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 10:24:31 -0400
Received: from smtp82.iad3a.emailsrvr.com ([173.203.187.82]:47432 "EHLO
	smtp82.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914AbcFFOYa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 10:24:30 -0400
Received: from smtp19.relay.iad3a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp19.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id D422C18053A;
	Mon,  6 Jun 2016 10:24:27 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp19.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A7CA1180469;
	Mon,  6 Jun 2016 10:24:27 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Mon, 06 Jun 2016 10:24:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160605031141.23513-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296514>

On 2016-06-04 11:11 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> This documents the ref update status of fetch. The structure of this
> output is defined in [1]. The ouput content is refined a bit in [2]
> [3] [4].
>
> This patch is a copy from git-push.txt, modified a bit because the
> flag '-' means different things in push (delete) and fetch (tag
> update).
>
> PS. For code archaeologists, the discussion mentioned in [1] is
> probably [5].
>
> [1] 165f390 (git-fetch: more terse fetch output - 2007-11-03)
> [2] 6315472 (fetch: report local storage errors ... - 2008-06-26)
> [3] f360d84 (builtin-fetch: add --prune option - 2009-11-10)
> [4] 0997ada (fetch: describe new refs based on where... - 2012-04-16)
> [5] http://thread.gmane.org/gmane.comp.version-control.git/61657
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>   Documentation/git-fetch.txt | 46 ++++++++++++++++++++++++++++++++++=
+++++++++++
>   1 file changed, 46 insertions(+)
>
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.tx=
t
> index efe56e0..a0d0539 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -99,6 +99,52 @@ The latter use of the `remote.<repository>.fetch` =
values can be
>   overridden by giving the `--refmap=3D<refspec>` parameter(s) on the
>   command line.
>
> +OUTPUT
> +------
> +
> +The output of "git fetch" depends on the transport method used; this
> +section describes the output when fetch over the Git protocol (eithe=
r

s/fetch/fetching/

> +locally or via ssh).
> +
> +The status of the fetch is output in tabular form, with each line
> +representing the status of a single ref. Each line is of the form:
> +
> +-------------------------------
> + <flag> <summary> <from> -> <to> (<reason>)
> +-------------------------------

(<reason>) should really just be <reason>, as the () are part of the=20
reason string.

> +
> +The status of up-to-date refs is shown only if --verbose option is

s/if/if the/


Also, thanks for putting so much effort into this!

I think having a fetch.output configuration setting is perfectly fine.=20
This sort of thing is really a matter of personal taste, so having=20
choices is good.

		M.
