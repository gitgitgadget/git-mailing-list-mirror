From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Thu, 6 Sep 2012 22:05:45 +0700
Message-ID: <CACsJy8CoBvxg9SWFFXbuDJM7Lu74Jw6LVc=7cNwu24h7pijeXQ@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-6-git-send-email-git@adamspiers.org> <CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
 <7vr4qhbt3d.fsf@alter.siamese.dyndns.org> <CACsJy8D23tDa3SJO6yegHFs2hT+bTr6mLTn16ZU3kiT1dtj4vw@mail.gmail.com>
 <7v627r7s5c.fsf@alter.siamese.dyndns.org> <CACsJy8Aq7Sodm1_k2kAmfajHG4wP76xHCshDGPfiLYfzuNwWaA@mail.gmail.com>
 <CACnwZYe19r9mefDmAQtuE5NU4jw033fc_i4JvMZUgtMUkNgEOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:06:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9dey-0002sO-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 17:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab2IFPGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 11:06:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44446 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab2IFPGR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 11:06:17 -0400
Received: by iahk25 with SMTP id k25so2143535iah.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DrbnO03LYNiHXWkvrthiiez4pVrakTKjR3IBKUbzXOs=;
        b=TH313LvDj40e4fDbSAEwNTimbPkwnsH2yTcGEMVK5wyTC+v4+Z0rD+HUKaQz1quTiH
         nNYferZEnW2kfcKhCg7FnVjKTzKLVVWivTo+JgTogq8GmjEF1Adj+vfUx8IdYagtl3y3
         v4VxILHBZTrq1ijSFN/H+/IM5KLq1KHU4DDL0l0JMjHfrYiEJDOS5YZKzzucIMLcvsvJ
         IVeVOwxaxvMGTjVD+Z0FITrHSzV6MRpBhuaoKMzKBTMGLWj7McOxarDjEJc7d/4iJT/6
         esCyvNn33bJnkEuI+yfnHidwsYkFSZ/FYC7U+c+sdAI/LGq5Qk7wgCzNfW90QdxO+IBn
         ChVg==
Received: by 10.50.85.134 with SMTP id h6mr15295383igz.2.1346943976327; Thu,
 06 Sep 2012 08:06:16 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Thu, 6 Sep 2012 08:05:45 -0700 (PDT)
In-Reply-To: <CACnwZYe19r9mefDmAQtuE5NU4jw033fc_i4JvMZUgtMUkNgEOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204894>

On Thu, Sep 6, 2012 at 9:59 PM, Thiago Farina <tfransosi@gmail.com> wrote:
> On Thu, Sep 6, 2012 at 9:13 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Thu, Sep 6, 2012 at 10:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>>
>>>> We could introduce exclude_path() and kill path_excluded() then. There
>>>> are just about 5-6 call sites to replace.
>>>
>>> The name path_excluded(... path ...) sounds like it is asking a
>>> yes/no question "is this path excluded?", which actually is what is
>>> going on.
>>>
>>> The name exclude_path(... path ...) sounds as if you are requesting
>>> somebody to exclude the path.  Does that meaning match the semantics
>>> of the function?
>>
>> I'm not great at naming. And path_excluded() cannot be reused to avoid
>> problems with other ongoing series if any. So path_is_excluded()?
>
> is_path_excluded()?

Good too.
-- 
Duy
