From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Document 'git bisect fix'.
Date: Wed, 16 Mar 2011 10:52:21 +0100
Message-ID: <AANLkTimAaL-C_oH9X3QFUc+JOaSi7xVe93KYJuL0VEyR@mail.gmail.com>
References: <20110311165802.GA3508@intel.com>
	<4D7A64670200007800035F4C@vpn.id2.novell.com>
	<AANLkTikG8wa1Em0bEUddbYpYs2TzFFTDb95qWFJ3xSbv@mail.gmail.com>
	<4D7DE39302000078000362E6@vpn.id2.novell.com>
	<20110314095534.GB18058@elte.hu>
	<20110314104131.GG6275@bubble.grove.modra.org>
	<20110314122342.GA26825@elte.hu>
	<20110314131623.119020@gmx.net>
	<20110314210001.GE4586@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Jan Beulich <JBeulich@novell.com>,
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@z
X-From: git-owner@vger.kernel.org Wed Mar 16 10:52:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PznP2-0000nf-Ks
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab1CPJwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:52:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47346 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab1CPJwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:52:22 -0400
Received: by wwa36 with SMTP id 36so1905793wwa.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=PN6h0n0GE2hunb0TvI2UNcVsOysIKHPSy1jVZY/1Qmg=;
        b=quP7y3g2yS4eh+IqxdLDAqG3+iCRLjsz3TjTreW8cQFYGDPT+pJtEPdaOjNGvFkHT+
         /3poiWJ7QBS31eJ6FCoHi+hC+FCpYRk9rkflsSwL+vpmIOFL1FzO2ujaLLGnihmg5Zbu
         n8d1r9isFHNMxrx8XhZKbtpNJpCNoDLF8hgw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=v1uiq3Xj9fUgg9zNTOIdiRR40qjEutzNoJyUaD3tQwESqHE8k2DIpQbnjbhYeI8S8/
         xqiesfG2H2MUQnRuoMdj0H6C2DPozhsWUHCL7QilLgOwqiBQadhvPsDa+wFueImQ4b2P
         xEo8RpnZiwpSYAckE0n/haYaIGAQMLj/M1aho=
Received: by 10.216.205.139 with SMTP id j11mr562668weo.28.1300269141491; Wed,
 16 Mar 2011 02:52:21 -0700 (PDT)
Received: by 10.216.17.211 with HTTP; Wed, 16 Mar 2011 02:52:21 -0700 (PDT)
In-Reply-To: <20110314210001.GE4586@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169129>

Hi,

On Mon, Mar 14, 2011 at 10:00 PM, Ralf Wildenhues
<Ralf.Wildenhues@gmx.de> wrote:
> git bisect is sometimes less effective than it could be in projects
> with long-lived but simple bugs (e.g., little-tested configurations).
> Rather than skipping vast revision ranges, it might be easier to fix
> them up from known bugfix branches.

It's already possible to deal with this problem by creating a new
branch where the bug is fixed, and then using "git replace", so that
the new branch is used instead of the old one.
Please search for "git replace" in this doc:

http://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html

> 'git bisect fix' teaches bisect about when some known bug was
> introduced and when it was fixed, so that bisect can merge in
> the fix when needed into new test candidates.

Perhaps some people would find it easier to use what you suggest but
using git replace may be nicer because you have to create the new
branch once, so you need to fix merge or rebase problems only once.
And the new branch may be useful not only for bisecting, for example
to recreate old versions.

Thanks,
Christian.
