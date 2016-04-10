From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC/PATCH 00/18] Add --index-only option to git merge
Date: Sat, 9 Apr 2016 22:33:24 -0700
Message-ID: <CABPp-BHrsRXu8_9oj=srATO51yaDBVUMUUGKqgL16_b6HN+-Yw@mail.gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 07:33:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap809-0007Mf-0b
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 07:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcDJFd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 01:33:26 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33177 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbcDJFdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 01:33:25 -0400
Received: by mail-io0-f195.google.com with SMTP id g185so21842982ioa.0
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 22:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=64OsGwsdCkDndZ64OrpEyQlShN6aKuC+iwtHs/h1mJ8=;
        b=cYuZD/cygVVFGqxstaW6SmA3adjTXOxnnJJJQdxvxf93MOp8pqu+5yPYjbYV5hTQ7V
         6B+czcooDYxpTtem8CBV5u18E9OKKFLzMmulRqWLC5qouyA22I1nw5hBL+hcpFkU+h4e
         8KaLDaOx3wN44MKgOb3b7rixdtmK8Ta9wIQ0DR7Ww8BfSfbjDh2VOys9Uqamrsyevpug
         wvFym6oiQ9ZA5FwxAwTrTYqs3gHYy7PA5fddjSDWnXvdgxV+tXGAFeTp703oVEXDoLrf
         KW5zn+AyTjKCEkHmZih+/pLxHbrHbPDl3wbxM8qhXxkt9m0hQVeR0hvM2Sd8z5UN8xct
         OggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=64OsGwsdCkDndZ64OrpEyQlShN6aKuC+iwtHs/h1mJ8=;
        b=gAk+yKEA4UpiKJsC1l992ClvETj9sGdpzw++WW51UkFnEd2/eznBYheLVyQPG9AHcg
         fpn/MdaU9hO+nBQUkGAUMrapJopZRZbRnIc6Eg6QY3miADqjsRF7gXI2lLwq5v2R/mCz
         hjc2PjKs7zdLosE5Mumd4m7tjhj+aKHKCiZyc5/Z2wLvPvO8gGFLsGukG29PrZcSkRZN
         XbMHHYE43UZ7O+SFTsQeY/rFylNLGemJQIHjfprxGSUpcanPfMlPaxQbph7RiSpU+7QF
         3ihv/m9Y4Dg9dpmYoJ92mvYj/WA0UGqSZEY5SpSm23odllwAd+tgqRYfhl71ahDY6SO9
         8sfQ==
X-Gm-Message-State: AD7BkJK0BMyDuomc/YJdmqio9HqgXHu35mWk41BVCIzrlqqmtCOZ5+YV8cnpnxiZ2EdiLGEe1ifa/D/BqfPSjw==
X-Received: by 10.107.15.159 with SMTP id 31mr16672925iop.3.1460266404658;
 Sat, 09 Apr 2016 22:33:24 -0700 (PDT)
Received: by 10.64.0.173 with HTTP; Sat, 9 Apr 2016 22:33:24 -0700 (PDT)
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291139>

On Thu, Apr 7, 2016 at 11:58 PM, Elijah Newren <newren@gmail.com> wrote:
>   Luckily, I figured out that bug.  So, that leaves just one case left
>   that I can't seem to figure out: read_tree_trivial.  So much better,
>   right?  Even it's name is sitting there, mocking me.  "Ha ha, I'm
>   read_tree_*trivial* and you can't figure me out."  read_tree_trivial
>   is a jerk.

It turns out this wasn't a bug in my index-only handling of the
trivial merge case; it was a pre-existing bug in git handling of
trivial merges that probably no one else had ever triggered before.
I'm submitting a fix with my other miscellaneous merge fixups...
