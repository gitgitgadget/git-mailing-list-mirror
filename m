From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Sat, 20 Nov 2010 08:14:01 -0500
Message-ID: <AANLkTikKeGz=Wc4fBDO6NyNQgpJ9qu3zUKzVqWW+yzPN@mail.gmail.com>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<20101113095140.GH8911@home.lan>
	<AANLkTin+3FuuX_pavZQMrbi4qxjTRvM7nHk1PXcFbeiZ@mail.gmail.com>
	<20101119211533.GA18942@sigill.intra.peff.net>
	<AANLkTikWYVyCf9mueoAHjGcQuNOdPFyQrmtW79As4RG-@mail.gmail.com>
	<20101120041011.GA20725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 20 14:14:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJnGc-0002HZ-9P
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 14:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0KTNOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 08:14:04 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33305 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354Ab0KTNOC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 08:14:02 -0500
Received: by qyk1 with SMTP id 1so444355qyk.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 05:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=RhIjJQsWo2j1f+MalzIkbpexxKq9fOGiI17TMHKMo/M=;
        b=tIXhCiwRTxHWo11jdHNuuErjLAX79HnOS4cJD5cbPwaM3lJW7yCifJ/CcYxbqbWQEP
         Yi/w002owYlRZpj/HCvmbzc1wfrNI83Pq1PbvRx0yb8RRRqlUcyijyA502UqBJcW4PBR
         XZvUhRqSfbWwhk+aPMRUpIK9s3z0aB6KK3rEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b1EoDDgptm3F1bXMoNhYZ0bWNcOAdDA9HmmJp8s+bIYU/y6dT6I1RkPRO2cJb1RJ27
         ELT9F9a2bouqZEF49Ofs12EliZWXYFQQg0Kzo8AR2CTQUN4WdlSolBgAjCIduHBE/CgF
         UzH2gKHSwlTUdFMpT7a6NQUTqDntY/wp8v7MA=
Received: by 10.224.135.227 with SMTP id o35mr3035589qat.75.1290258841330;
 Sat, 20 Nov 2010 05:14:01 -0800 (PST)
Received: by 10.224.80.202 with HTTP; Sat, 20 Nov 2010 05:14:01 -0800 (PST)
In-Reply-To: <20101120041011.GA20725@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161826>

On Fri, Nov 19, 2010 at 11:10 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 19, 2010 at 07:26:57PM -0500, Martin von Zweigbergk wrote:
>
>> Yes, I did try that and I noticed that it worked, but it helps to know
>> that it is not just by accident. I realize I was not very clear, but
>> what I really was wondering if there is any advantage to using
>> "git for-each-ref --format='%(upstream)' ${branch_name}" (as used by
>> git pull) as compared to "git rev-parse @{upstream}" as suggested by
>> Yann. ($branch_name in this case would be the current branch.)
>
> No, I don't think there is a reason to prefer one over the other these
> days. When the instance in git-parse-remote was written (e9460a6,
> 2009-06-12) @{upstream} did not yet exist (it came in 28fb843,
> 2009-09-10). So for-each-ref was the only way to get the informationa

Ah, I see. Now it is all clear. I should not have assumed that
'%(upstream)' and '@{upstream}' were introduced at the same time.
Thanks.
