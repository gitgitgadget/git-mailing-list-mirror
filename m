From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Fri, 11 Sep 2015 17:43:25 -0400
Message-ID: <CANoM8SUGmb=fSFqF4DTuW2F5oPVaim-=SP76rqwwqtzcsNQf=g@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
 <1441402769-35897-3-git-send-email-rappazzo@gmail.com> <xmqqk2rx0w54.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:43:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaW6n-0002Zc-I9
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 23:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbbIKVnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 17:43:46 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33016 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbbIKVnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 17:43:45 -0400
Received: by vkgd64 with SMTP id d64so32947956vkg.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HBmEfRyF6B0db8AaN0LZcSiIIE0Ukr19c79rxBSGYbA=;
        b=Wz0iNFk3hMEm4nDECIZnWDLMOvlIFIg+yWXhxOvnMXgvK7nPZfRPXAfeQsANZep1ir
         K9f42sROIH2n5IaaTgyuzAUKZKGkNOKKMcbK1oFXODzMJ7xaW3QXz34tiajdyIr5eO1V
         g6euTfnP8pYnbztSaPjGTCuP7u4vZuqdaCghKGs0EcW3uTRhr1SeY2wc8vZJ7siBaKZz
         idI6cUyCue7all1rc8fmkwx5Wxk6q3VX1Vl7v8DDnjqFz9hs3d7a3LfJE+uEA01TN8Lc
         zw1O9PMRqvj3mh2QIX4KSX194bN80lxSKElqnMq9O043ZpFp/mSc158Jl+RQBXLeprPJ
         EEng==
X-Received: by 10.31.149.143 with SMTP id x137mr563925vkd.17.1442007824491;
 Fri, 11 Sep 2015 14:43:44 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Fri, 11 Sep 2015 14:43:25 -0700 (PDT)
In-Reply-To: <xmqqk2rx0w54.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277699>

On Fri, Sep 11, 2015 at 12:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> The code formerly in branch.c was largely the basis of the
>> get_worktree_list implementation is now moved to worktree.c,
>> and the find_shared_symref implementation has been refactored
>> to use get_worktree_list
>>
>
> Copying the bulk of the function in 1/3 and then removing the
> original here made it somewhat hard to compare what got changed in
> the implementation.
>
> I _think_ the code structure in the end result is more or less
> right, though.

Should I squash these first two commits together in the next series?
