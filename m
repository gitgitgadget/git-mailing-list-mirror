From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/8] t3305: fix ignored exit code inside loop
Date: Wed, 25 Mar 2015 09:40:47 +0100
Message-ID: <CALKQrge+KKHg3GtGz=rg3YQEnzN_tthqW4hrTDjFt96vnuGk9Q@mail.gmail.com>
References: <20150325052456.GA19394@peff.net>
	<20150325052856.GC31924@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 10:06:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YahH2-0006eh-FI
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 10:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbCYJGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 05:06:47 -0400
Received: from mail14.copyleft.no ([178.255.144.193]:56804 "EHLO
	mail14.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbbCYJGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 05:06:45 -0400
X-Greylist: delayed 1549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2015 05:06:45 EDT
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail14.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Yagrt-0007Ue-TM
	for git@vger.kernel.org; Wed, 25 Mar 2015 09:40:53 +0100
Received: from mail-pd0-f174.google.com ([209.85.192.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Yagrt-0009Vj-Kf
	for git@vger.kernel.org; Wed, 25 Mar 2015 09:40:53 +0100
Received: by pdnc3 with SMTP id c3so21715498pdn.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 01:40:47 -0700 (PDT)
X-Received: by 10.66.241.36 with SMTP id wf4mr15522427pac.8.1427272847319;
 Wed, 25 Mar 2015 01:40:47 -0700 (PDT)
Received: by 10.70.83.67 with HTTP; Wed, 25 Mar 2015 01:40:47 -0700 (PDT)
In-Reply-To: <20150325052856.GC31924@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266274>

On Wed, Mar 25, 2015 at 6:28 AM, Jeff King <peff@peff.net> wrote:
> When we test deleting notes, we run "git notes remove" in a
> loop. However, the exit value of the loop will only reflect
> the final note we process. We should break out of the loop
> with a failing exit code as soon as we see a problem.
>
> Note that we can call "exit 1" here without explicitly
> creating a subshell, because the while loop on the
> right-hand side of a pipe executes in its own implicit
> subshell.
>
> Note also that the "break" above does not suffer the same
> problem; it is meant to exit the loop early at a certain
> number of iterations. We can bump it into the conditional of
> the loop to make this more obvious.
>
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
