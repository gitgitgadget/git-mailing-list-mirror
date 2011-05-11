From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] magic pathspec updates
Date: Wed, 11 May 2011 19:11:19 +0700
Message-ID: <BANLkTi=dk9mHK+cncCz_vuYXPH9uyzcsGg@mail.gmail.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com> <BANLkTimLsNU0rLHRxxPmzFH_-1U5m3GoCw@mail.gmail.com>
 <7vvcxijxhi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 18:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCCB-0004pf-2d
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434Ab1EKQXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:23:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37010 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab1EKQXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:23:08 -0400
Received: by fxm17 with SMTP id 17so489424fxm.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2et794CojLx8NOkPvdSVSvEJvTQ5FDvf9r46uxRIWqk=;
        b=l1/aXWrd+obC1U8yVvoAPnWR+MEzneDkbCLZuig7Ybr/ilayj/MvgJsM4TXFDqC5TH
         QR4S/bA2jVf3FDYeXHE0o+qNruRapjpPLUfw88IX1Wa/KA8lEYs20vZQj2l+RthZfbG/
         ZthdM6zo4VR8SekLqkRkMmopYxY1pujMz5mDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bx4XMuvCXh9yYUT6wCh9skTA0qlYOukJrKQhabwSl7TuUfCYy3tYZvZGMLv5fveF6g
         MJiS9XDUZpzl0hi0RLYqwYvu9r3Bzxk7n08n8L26xhHp34TraRMddPRcsKXhx61ckEuz
         buBkdP9utwWKDavZuUgcAJIs/jg7EN6VwqJK0=
Received: by 10.223.134.75 with SMTP id i11mr3114894fat.39.1305115909703; Wed,
 11 May 2011 05:11:49 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Wed, 11 May 2011 05:11:19 -0700 (PDT)
In-Reply-To: <7vvcxijxhi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173403>

On Wed, May 11, 2011 at 12:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Note that no such command exists in our vocabulary today, so you need
> to imagine "git local-log" that acts like "git log" but by default
> shows history simplified to explain only the subdirectory you are
> currently in, or something.
>
> Such an application can easily notice that argv[] has only a lone ":"
> left and do the same thing it does when there is no pathspec, without
> affecting other (existing) users of get_pathspec().

Hmm.. if ":" (the semantics) is only used in few commands, perhaps an
option would be better than the cryptic ":".

> I am leaning toward ripping the lone ":" support from the code in
> "next". I would also remove ":(icase)" from "next". It was only meant
> to be a POC to show how far we could go only by futzing get_pathspec()
> function, and was never meant to be a serious implementation of the
> feature. It should be re-done after we do deeper conversion and use
> the "struct pathspec" interface not "char **" interface.

OK. But reserve the lone ":" syntax. It's precious. We may have a use
case for it some day.
-- 
Duy
