From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Thu, 6 Sep 2012 19:13:37 +0700
Message-ID: <CACsJy8Aq7Sodm1_k2kAmfajHG4wP76xHCshDGPfiLYfzuNwWaA@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-6-git-send-email-git@adamspiers.org> <CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
 <7vr4qhbt3d.fsf@alter.siamese.dyndns.org> <CACsJy8D23tDa3SJO6yegHFs2hT+bTr6mLTn16ZU3kiT1dtj4vw@mail.gmail.com>
 <7v627r7s5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:14:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9ayS-0005bT-7N
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 14:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab2IFMOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 08:14:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60463 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab2IFMOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 08:14:08 -0400
Received: by iahk25 with SMTP id k25so1959731iah.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=inVJ2yldoaqhYq8PeZ+LhkaPZ7t7Hwyy4OJIWTvMJEA=;
        b=Ly/kLZUKLWioNgUqKr+0AYJacaPvkw+K2BxLAgtZxlFd243ZTE+GKOUG98i54HOuTM
         AmuRg1viSRJHt8k5TbjywS8NzjlYAVUB4qyj5VN6y2M0vhl62V6klme3YnxgBkb5vfI3
         DwZD4lXngcH5xqWGOgzxeusPbLX1GPFKjA4hQ+PGXdvivSFCWrKQfH1rH3hNTXaZfUXi
         ckh+LH0SZwJaCf75GZK8KNa0HJyW+0ABAd5FyGf9rhhum1K9C3sQRjgZucd+kanuNHif
         fyJWZXrECNFwcw7IetnDfU9nZ0wkQymqQoJFkA8ynwSqVD1jxLBAA7i0xwbsor6Utn3y
         cV7Q==
Received: by 10.50.13.200 with SMTP id j8mr2505092igc.48.1346933647822; Thu,
 06 Sep 2012 05:14:07 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Thu, 6 Sep 2012 05:13:37 -0700 (PDT)
In-Reply-To: <7v627r7s5c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204877>

On Thu, Sep 6, 2012 at 10:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> We could introduce exclude_path() and kill path_excluded() then. There
>> are just about 5-6 call sites to replace.
>
> The name path_excluded(... path ...) sounds like it is asking a
> yes/no question "is this path excluded?", which actually is what is
> going on.
>
> The name exclude_path(... path ...) sounds as if you are requesting
> somebody to exclude the path.  Does that meaning match the semantics
> of the function?

I'm not great at naming. And path_excluded() cannot be reused to avoid
problems with other ongoing series if any. So path_is_excluded()?
-- 
Duy
