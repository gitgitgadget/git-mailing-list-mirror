From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git Bug report
Date: Thu, 6 Oct 2011 08:56:40 +1100
Message-ID: <CACsJy8CZT7=b69mPyLPuggH3QPH5cQfbJXD0PWZopKQ03D6MXQ@mail.gmail.com>
References: <1317763443.17036.15.camel@skyplex> <20111005072235.GA12600@kolya> <7vlisz8jur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:57:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZSm-0008Fv-9f
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935409Ab1JEV5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:57:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63044 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934884Ab1JEV5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:57:11 -0400
Received: by eya28 with SMTP id 28so2070325eya.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XiEUcGT2N4FSrdKC63SUQ4hOmBG8SwYzY71SVer0nbQ=;
        b=cC8th0rjtrTYiBWB1FqJV0NheuMjmEoer4FH9ZxYgJlM56Ef9jD9W2E0Nt5J+4w8iE
         vdwunIu4+d3l0p06HgT0q1huXFWGIe/kaQQkxSw1t8kD2l72qd6vWLC2g4y4UBVqNWbF
         vkAY/uNin/HVjopcWnT4Yf1gC+c/FFVd/jg7Y=
Received: by 10.204.133.92 with SMTP id e28mr1693273bkt.407.1317851830145;
 Wed, 05 Oct 2011 14:57:10 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 14:56:40 -0700 (PDT)
In-Reply-To: <7vlisz8jur.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182893>

On Thu, Oct 6, 2011 at 3:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> So if:
>> .git/ is a directory with not enough permissions.
>> ../.git/ is a directory with enough permissions.
>>
>> git would today use ../.git. You suggest that git instead would die
>> because a .git/ exists? (I'm not saying this is wrong or right).
>
> For that matter, if you have .git/ that is a directory but is not a
> repository, and ../.git/ that is, the same situation would arise. I do not
> think we should die because .git/ is not a git repository. I do not know
> if we should even warn about it.

Probably not. On the other hand we should show user how we ignored
.git if we find no good repository in the end. So maybe it's a good
idea to queue up warnings and only print before git calls die("Not a
repository").
-- 
Duy
