From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 1/3] git-fetch.txt: document fetch output
Date: Fri, 3 Jun 2016 10:33:55 -0400
Message-ID: <57519553.10106@xiplink.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 16:34:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8qAj-0000gO-VE
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 16:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbcFCOd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 10:33:57 -0400
Received: from smtp106.ord1c.emailsrvr.com ([108.166.43.106]:34647 "EHLO
	smtp106.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932489AbcFCOd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 10:33:57 -0400
Received: from smtp22.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 8727A1803F2;
	Fri,  3 Jun 2016 10:33:54 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp22.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CE72B1803C3;
	Fri,  3 Jun 2016 10:33:53 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Fri, 03 Jun 2016 10:33:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160603110843.15434-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296331>

On 2016-06-03 07:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> This documents the ref update status of fetch. The structure of this
> output is defined in [1]. The ouput content is refined a bit in [2]

s/The ouput/The output/

> [3] [4].
>
> This patch is a copy from git-push.txt, modified a bit because the
> flag '-' means different things in push (delete) and fetch (tag
> update). We probably should unify the documents at some point in
> future.
>
> PS. For code archaeologists, the discussion mentioned in [1] is
> probably [5].
>
> [1] 165f390 (git-fetch: more terse fetch output - 2007-11-03)
> [2] 6315472 (fetch: report local storage errors ... - 2008-06-26)
> [3] f360d84 (builtin-fetch: add --prune option - 2009-11-10)
> [4] 0997ada (fetch: describe new refs based on where... - 2012-04-16)
> [5] http://thread.gmane.org/gmane.comp.version-control.git/61657
> ---
>   Documentation/git-fetch.txt | 46 ++++++++++++++++++++++++++++++++++=
+++++++++++
>   1 file changed, 46 insertions(+)
>
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.tx=
t
> index efe56e0..18e733c 100644
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

What a mysterious statement!  Does this tabular format actually change=20
when fetching over HTTP?  Maybe it's worth documenting the differences?

> +section describes the output when pushing over the Git protocol

s/pushing/fetching/

> +(either locally or via ssh).
> +
> +The status of the push is output in tabular form, with each line

s/push/fetch/

> +representing the status of a single ref. Each line is of the form:
> +
> +-------------------------------
> + <flag> <summary> <from> -> <to> (<reason>)
> +-------------------------------
> +
> +The status of up-to-date refs is shown only if --verbose option is
> +used.
> +
> +flag::
> +	A single character indicating the status of the ref:
> +(space);; for a successfully fetched fast-forward;
> +`+`;; for a successful forced update;
> +`x`;; for a successfully deleted ref;

I did a double-take here, until I remembered --prune.  Maybe add "(when=
=20
using the --prune option)"?

		M.
