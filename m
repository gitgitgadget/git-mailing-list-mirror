From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 22/32] checkout: support checking out into a new working
 directory
Date: Mon, 22 Sep 2014 17:00:49 -0400
Message-ID: <54208E01.2060205@xiplink.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1410388928-32265-1-git-send-email-pclouds@gmail.com> <1410388928-32265-23-git-send-email-pclouds@gmail.com> <5411B98C.1090905@xiplink.com> <20140921024101.GA6275@lanh> <CAPig+cRbfxUHmxbxxXLw=WKuV3JvBPEhuT4CvrZEOhWR-fbMHQ@mail.gmail.com> <CACsJy8CH8mQjexFU1jO1orzajiwTXy4wJ022nq1PEY2GLUGAZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:00:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWAio-0002l2-9m
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 23:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbaIVVAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 17:00:30 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:38867 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbaIVVA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 17:00:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 81C8418023A;
	Mon, 22 Sep 2014 17:00:28 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 23CFA180246;
	Mon, 22 Sep 2014 17:00:28 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Mon, 22 Sep 2014 21:00:28 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <CACsJy8CH8mQjexFU1jO1orzajiwTXy4wJ022nq1PEY2GLUGAZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257381>

On 14-09-21 05:50 AM, Duy Nguyen wrote:
> On Sun, Sep 21, 2014 at 10:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Would it make sense for this "rule of thumb" summary to be presented
>> first, and then the explanation of that rule after, rather than the
>> reverse as is currently the case?
> 
> You mean like this?

*shrug*  To me it seems better to leave it at the end here.

If we really want people to follow this advice, it should appear where
GIT_DIR is officially documented.  I think this is the Environment Variables
section of the Documentation/git.txt file.  Probably GIT_COMMON_DIR should
also be documented there.

(Sorry, I don't have time to whip up a patch right now.)

		M.


> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index c101575..fd77631 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -420,6 +420,11 @@ $GIT_COMMON_DIR is set to point back to the main
> working tree's $GIT_DIR
>  (e.g. `/path/main/.git`). These settings are made in a `.git` file located at
>  the top directory of the linked working tree.
> 
> +See linkgit:gitrepository-layout[5] for more information. The rule of
> +thumb is do not make any assumption about whether a path belongs to
> +$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
> +inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
> +
>  Path resolution via `git rev-parse --git-path` uses either
>  $GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
>  linked working tree `git rev-parse --git-path HEAD` returns
> @@ -429,11 +434,6 @@ rev-parse --git-path refs/heads/master` uses
>  $GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
>  since refs are shared across all working trees.
> 
> -See linkgit:gitrepository-layout[5] for more information. The rule of
> -thumb is do not make any assumption about whether a path belongs to
> -$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
> -inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
> -
>  EXAMPLES
>  --------
> 
> 
> 
