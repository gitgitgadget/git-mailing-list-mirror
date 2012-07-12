From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Thu, 12 Jul 2012 14:39:21 +0200
Message-ID: <87mx35rw5i.fsf@thomas.inf.ethz.ch>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
	<1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 12 14:39:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpIg6-0005NN-30
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 14:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab2GLMjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 08:39:25 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:10198 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab2GLMjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 08:39:24 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 12 Jul
 2012 14:39:21 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 12 Jul
 2012 14:39:22 +0200
In-Reply-To: <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Thu, 12 Jul 2012 14:04:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201359>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> When $HOME is unset, home_config_paths fails and returns NULL pointers
> for user_config and xdg_config. Valgrind complains with Syscall param
> access(pathname) points to unaddressable byte(s).
>
> Don't call blindly access() on these variables, but test them for
> NULL-ness before.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>> This patch causes valgrind warnings in t1300.81 (get --path copes with
>> unset $HOME) about passing NULL to access():
>
> Indeed. The following patch should fix it.

Thanks!

Tested-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
