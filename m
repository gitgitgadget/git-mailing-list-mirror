From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 20:50:53 -0600
Message-ID: <AANLkTinQYfpWYJ8Lr3=VX+x2Xj+eQfYztT1GHh2AQKff@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
	<AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
	<AANLkTi=02T+60AjJON8MFt7DSbtA=bx39YKigZHq_b_u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 04:51:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoSYV-0002R0-KO
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 04:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab0HZCu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 22:50:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57782 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0HZCuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 22:50:55 -0400
Received: by fxm13 with SMTP id 13so919890fxm.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 19:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=pKlfrRyfUAIaf3JgA26aZ940xBJEEUI+Y7o9+pTR2Ac=;
        b=bFJ5qRupHOPQ72Rd/kNhUl7aCzkxzW8U7qM0l0bmMvOXFuRR9Wfl2S6oAPkUjUkvet
         HG0mWNtEY2gWIK3o/N1tY3TCcKANoMZlPhwvo+Aazl47StSIz+qRCTATaspN3ufetA6/
         Ms96mxEpONlyN6Y6he5Bp33i+29sdBzVYt+AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f9/K8M0vrwkeSCP8WGsDkBSWV/JLFOBBei4i4UC8oPQza9/Isdt++QajvK+gqAyfgB
         FSiH+yxN4LPmEWluZohLyncOocyB/V47qPRrzWCh/iQxRi74IzGUlr2WL1muvR9ywuIq
         cvqZa2M8K1aPkaBGhkfWe74xOwIocpjl+LqTU=
Received: by 10.223.109.7 with SMTP id h7mr2249132fap.100.1282791053396; Wed,
 25 Aug 2010 19:50:53 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 25 Aug 2010 19:50:53 -0700 (PDT)
In-Reply-To: <AANLkTi=02T+60AjJON8MFt7DSbtA=bx39YKigZHq_b_u@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154503>

On Wed, Aug 25, 2010 at 4:13 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Wed, Aug 25, 2010 at 3:31 PM, Elijah Newren <newren@gmail.com> wrote:
> I remember it!
>
> So there are two points: the "no changes outside narrow tree from
> "you"" assumption and whether it is trivial to do a merge outside
> narrow tree without whole trees.
>
> The first point. That assumption holds if user clones, starts working,
> then does "pull origin". But if user merges another branch, say "next"
> into "master", the common commit may be somewhere down in history and
> there may be changes outside narrow tree from both "you" and
> "upstream" (though user does not make those changes).

Yes, I agree; you can't merge with the data you have in such a case.

> The second point (probably not needed if the above assumption is no
> longer true, but I post anyway in case I forget it again). Without
> whole trees, it's impossible to determine a trivial merge reliably. If
> "you" adds a file and "upstream" adds another file, predecessor trees
> will look different but merging them is trivial (at file level). If we
> miss some trees that lead to those new files, the best thing we can do
> is to claim it non-trivial.

I'm not following this one.  Could you provide more detail?
