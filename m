From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Mon, 29 Aug 2011 14:56:02 -0700
Message-ID: <CA+55aFzk+hn9wMAp3H92SHAGO8CQVBpTsmR41FgCy32T7muUzA@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 23:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9pS-0008UZ-4N
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab1H2V5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:57:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46346 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755267Ab1H2V4v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 17:56:51 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7TLuM9b015133
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 14:56:23 -0700
Received: by wyg24 with SMTP id 24so4440990wyg.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 14:56:22 -0700 (PDT)
Received: by 10.216.188.17 with SMTP id z17mr1799022wem.70.1314654982108; Mon,
 29 Aug 2011 14:56:22 -0700 (PDT)
Received: by 10.216.187.66 with HTTP; Mon, 29 Aug 2011 14:56:02 -0700 (PDT)
In-Reply-To: <1314653603-7533-1-git-send-email-gitster@pobox.com>
X-Spam-Status: No, hits=-103.51 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180364>

On Mon, Aug 29, 2011 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Before and after applying this series, looking for changes in the kernel
> repository with a fairly narrow pathspec gets a moderate speeds up.

"moderate speeds up"?

Looks like a big win to me. Admittedly it's already a pretty fast
operation, but script it and repeat it a million times, and that will
matter a lot more.

I guess the "--raw" diff part means that you are hiding the time to
make a real diff, which would otherwise swamp everything else. Even
so, this looks like a good improvement.

                    Linus
