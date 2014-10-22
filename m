From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] fetch-pack: don't resend known-common refs in find_common
Date: Wed, 22 Oct 2014 17:07:31 +0700
Message-ID: <CACsJy8B7nOZCjdF_hki5amv-uCY17hz59oPDvx-ufbRrdvTweQ@mail.gmail.com>
References: <1413884908.4175.49.camel@seahawk> <20141021144838.GA11589@seahawk>
 <xmqqd29l1f3p.fsf@gitster.dls.corp.google.com> <1413963706.11656.5.camel@seahawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 12:08:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgsps-0001KH-Me
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 12:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbaJVKIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 06:08:04 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:62773 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546AbaJVKID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 06:08:03 -0400
Received: by mail-ig0-f177.google.com with SMTP id a13so584045igq.10
        for <git@vger.kernel.org>; Wed, 22 Oct 2014 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AS2SCt8cEim4pkr30B+qiWZwiyBcDnu3T45rRi423/A=;
        b=MrFb0Nx4dtA/YDaYWrlrEJRIExdorpcTYPLE6whUgKIbPq/8vXr2ggRdKXj5plB5F5
         TFS810G8sWKT/GErw8U9aFXBXujJaxc6OESl5CZBo5zW7LYjVWWeLl/UksW61KtjYgH1
         0skLnvfCivcI5ZVsB0E0Vm4oxHeqqOLULdZj7u3Urr9nm2RwiHXWzaTBmJNH+0Eom2Ip
         mLWlfEOFeQJ3RF+TAsp/7MKQvG7ZH4R8y9SgC/Y0tTWrTLxvNA/cKF8eEhgNRqo4e9vY
         yKz3+y1+ENtMHTf7qQsW/tUhZdmU8lkdHtVlvdRWDTOk+PlaQ+z3R0ZO9ddffZasFTCh
         +9Jw==
X-Received: by 10.50.85.101 with SMTP id g5mr4258220igz.40.1413972481780; Wed,
 22 Oct 2014 03:08:01 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Wed, 22 Oct 2014 03:07:31 -0700 (PDT)
In-Reply-To: <1413963706.11656.5.camel@seahawk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 22, 2014 at 2:41 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> I see two options:
>
> * Turning that interaction into a more cooperative process, with a
>   select/poll loop
> * Make upload-pack buffer its entire response when run in stateless_rpc
>   mode until it has consumed all of the request

Or add a helper daemon and support stateful smart http. Or maybe
that's what you meant in the first option.
-- 
Duy
