From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Implement git remote mv
Date: Wed, 22 Oct 2008 11:52:54 -0500
Message-ID: <JQScKsOjmj-C7kmMPApAxZ3UDmaTZ1j0HkObQuCveJ9n4G-4o6Zxbw@cipher.nrlssc.navy.mil>
References: <1224634994-1664-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 18:57:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksh18-0003qi-1t
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 18:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYJVQzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 12:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYJVQzw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 12:55:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48203 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbYJVQzv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 12:55:51 -0400
Received: by mail.nrlssc.navy.mil id m9MGqtZf009435; Wed, 22 Oct 2008 11:52:55 -0500
In-Reply-To: <1224634994-1664-1-git-send-email-vmiklos@frugalware.org>
X-OriginalArrivalTime: 22 Oct 2008 16:52:55.0448 (UTC) FILETIME=[A1506980:01C93466]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98883>

Miklos Vajna wrote:

> +static int mv(int argc, const char **argv)
> +{
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	struct remote *oldremote, *newremote;
> +	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
> +	struct string_list remote_branches = { NULL, 0, 0, 0 };
> +	struct rename_info rename = { argv[1], argv[2], &remote_branches };

I think some non-c99 compilers would have issues with this run-time
initialization from function arguments. Plus, what if argv doesn't have
3 elements? I see you have a check for that below...

> +	int i;
> +
> +	if (argc != 3)
> +		usage_with_options(builtin_remote_usage, options);

-brandon
