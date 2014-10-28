From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 18/19] update-index: test the system before enabling untracked
 cache
Date: Tue, 28 Oct 2014 18:37:56 +0100
Message-ID: <544FD474.3050805@web.de>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com> <1414411846-4450-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 18:38:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjAia-0002Yx-5H
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 18:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbaJ1Rh7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 13:37:59 -0400
Received: from mout.web.de ([212.227.17.12]:61706 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbaJ1Rh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 13:37:59 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lm4lR-1YHxVE0zZJ-00Zj8n; Tue, 28 Oct 2014 18:37:57
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1414411846-4450-19-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:VH0eJHtnCNGy8tRqdqe4AszjMPB8HsNjyL0bLhe6RJQqNMJlURr
 4N0QKIAF5vW0Rrfft19AOYQKMGTXpI/I83IpQhEyqlw2KoNVXsVgzGwVdEzisH9AAr7yqDQ
 5zhvx1UubmnalGJ5GJkvXRSrZtS8CHJwEdLXwkeIvQVAamO82nGAvHBXM9odAI9IiHGUYTn
 5VJ/b5CW08Kox/8uiUNow==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-10-27 13.10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
[]

> +static void xmkdir(const char *path)
> +{
> +	if (mkdir(path, 0700))
> +		die_errno(_("failed to create directory %s"), path);
> +}

Does it makes sense to ignore EINTR and do a "retry" ?
Another question is if the function could be called mkdir_or_die() inst=
ead?
=20
I realized that there are 2 families of xfunc() in wrapper.c, some die,=
 some retry.
