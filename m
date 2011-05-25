From: Elazar Leibovich <elazarl@gmail.com>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 14:40:19 +0300
Message-ID: <BANLkTimWymFNC7hP=X2w0RMwdLPjGC07Aw@mail.gmail.com>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
	<SNT124-W39164C74A457129811245DC4740@phx.gbl>
	<BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>
	<SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
	<BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
	<SNT124-W15FA6D1CACA43B253810FAC4740@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 13:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPCRs-0007WP-S2
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 13:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab1EYLkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 07:40:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43800 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab1EYLkU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 07:40:20 -0400
Received: by gxk21 with SMTP id 21so3044193gxk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PeK7n793N3f4s0vuzH9oS/m1eWgNdBY5Y2fAIH6H78s=;
        b=eikJuM/F9QmCyoQ9lPlCxXPwuR8SFrHpSRmtQr+0ft5idP66th007a9mFNkYmPZwnb
         sFBHUvECdw2AG9De1lLTCL2Bav8p3tMWguqLIN46+/pq/PFP6CdmCulYE/rk0l2KiHzx
         DMnq3Gho3JDzVeNFRzMg8ey+AuJ14AEWuTzww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EYU6H/reY8R2EQfuokdBeX2zAuduQW8tOE7zAFnG+NPp1JVUXRbUmLpD265Z7ZvhLp
         lkiqCGYwLBMyBzR85l5ES/3fL9izALNDIeElc6niMTNHBCJS3wLuQz79SCcmMpxx/7cD
         Le7GMtsuux10Cek2hSh4qGurCGdsSkGY5qbM4=
Received: by 10.236.72.225 with SMTP id t61mr6675076yhd.227.1306323619450;
 Wed, 25 May 2011 04:40:19 -0700 (PDT)
Received: by 10.236.208.134 with HTTP; Wed, 25 May 2011 04:40:19 -0700 (PDT)
In-Reply-To: <SNT124-W15FA6D1CACA43B253810FAC4740@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174387>

On Wed, May 25, 2011 at 2:35 PM, Tim Mazid <timmazid@hotmail.com> wrote:
>
>> git log --all --not --grep A --grep B
>>
>> Would mean find all commits without A and with B, in SQL "SELECT *
>> FROM COMMITS WHERE message NOT LIKE '%A%' AND message LIKE '%B%'".
>
> But how do you know which "--grep" the "--not" applies to? Does it have
> to go directly before the "--grep" option?

Exactly, just like the ! operator in C.

> Can it be a few options before
> as long is it's still before?

No, only directly before the --grep, like the ! operator.

> If you want to find commits not matching two
> patterns, do you have to do "--not --grep A --not --grep B"?

Yes, we can add a --negate-all option if you think it's usefull.

>
> I can see this as being a possible source of confusion; people doing
> "--not grep A --grep B" and expecting it to mean NOT A AND NOT B.

You can add another option --negate which negates everything. But this
is a price to pay for being extra expressive.
