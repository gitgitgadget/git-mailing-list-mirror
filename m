From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Revert "git am/mailinfo: Don't look at in-body
 headers when rebasing"
Date: Tue, 16 Jun 2015 11:47:11 +0200
Organization: gmx
Message-ID: <e9f6878d93bc7946be9116f02f023d64@www.dscho.org>
References: <1434445392-6265-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Lukas_Sandstr=C3=B6m?= <luksan@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 11:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4nSz-0003bo-FT
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 11:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000AbbFPJr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 05:47:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:63076 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757285AbbFPJrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 05:47:16 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MK17F-1Z3QY935bJ-001O8I; Tue, 16 Jun 2015 11:47:12
 +0200
In-Reply-To: <1434445392-6265-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:TDpy8nO3laHgd0K2cUmUvzCyr0Z0DhmA9kTZuLLjm8xWalg6Xvx
 BotFb5Re//26231fboA2xXsKhisLSdSxSpmUvdqD9N0+e+4kwMbFsnbvk3S1qv9WCbeYL4Z
 OEY9cbnbudurwoangRDRHHH9F/KBA2d/O+wJbcknZ28TZfmgOHQEhwpKaT2jCzPEPR0A8a+
 jfzE5PmWGZeuMBDZvewGw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271746>

Hi Paul,

On 2015-06-16 11:03, Paul Tan wrote:
> This reverts commit d25e51596be9271ad833805a3d6f9012dc24ee79, removing
> git-mailsplit's --no-inbody-headers option.
> 
> While --no-inbody-headers was introduced to prevent commit messages from
> being munged by git-mailinfo while rebasing, the need for this option
> disappeared since 5e835ca (rebase: do not munge commit log message,
> 2008-04-16), as git-am bypasses git-mailinfo and gets the commit message
> directly from the commit ID in the patch.
> 
> git-am is the only user of --no-inbody-headers, and this option is not
> documented. As such, it should be removed.

Makes sense to me.

> Notes:
>     The other direction, of course, is to turn --no-inbody-headers into a
>     supported, documented option in both git-mailsplit and git-am.
>     
>     I do also wonder if we should just ensure that git-format-patch does not
>     generate a message that start with "From" or "Date".

In case we need this option for anything in the future, we can easily resurrect it from the commit history, so removing the option the appropriate course of action, methinks.

Ciao,
Dscho
