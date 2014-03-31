From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git am oddity
Date: Mon, 31 Mar 2014 15:38:16 -0700
Message-ID: <CAGdFq_hM11bqhPsJqmx6x9wA-KcHvA=RJU+wQWWEuEQR1EU8GQ@mail.gmail.com>
References: <CAGdFq_gZoiE_ah0VT5ZfQwg-zHNj6Q-RSB80f=BTf=U6+9L5UA@mail.gmail.com>
 <xmqqbnwm2ex1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Mario Ferraro <fadinlight@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkrD-0004oT-0h
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbaCaWi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:38:58 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:37491 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaCaWi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:38:57 -0400
Received: by mail-ie0-f175.google.com with SMTP id to1so8403494ieb.34
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 15:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yHT5ALF/Djr9ylnR1OlVoro7bgz9IB2rMlipVfI9vTg=;
        b=kCyPLBMkIgkTOri/DqDEaAPbnRnPQ095tr3s86Z76dd+Vl4nDNWEi5daeK5UEiPCu6
         P5zT3NEqH/4+4FJnM4CBnW6pyUjHdYze2hhS7IuCDQ8O/HD+U0VGW7PE2OlYjUP4pnaf
         7EnZmXV2rIHGw0I6L1ZL18RYGAjzme2n8EIfDw3zQqVE//BbfnHrD7cNzmPq3kFL+K57
         /a+zZyCmC5PN1Q1nQ31VsI1+4tcPMFkmr4lELfBm8bUWA6JB8MdlwFEMRkw/YaivpJqp
         L8dAQVLaCoqp1bWUErL2YmVv1u3lb1t8D/gss9cpRMQ3MrXhYkqbqXFnuvanowy6EmSe
         Fylg==
X-Received: by 10.42.88.79 with SMTP id b15mr18238213icm.65.1396305536906;
 Mon, 31 Mar 2014 15:38:56 -0700 (PDT)
Received: by 10.50.7.236 with HTTP; Mon, 31 Mar 2014 15:38:16 -0700 (PDT)
In-Reply-To: <xmqqbnwm2ex1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245564>

On Mon, Mar 31, 2014 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As you are doing -3 (not the -p3), it would have:
>
>  * noticed that the patch is trying to update "baz/file";
>
>  * noticed that there is no "baz/file" but it could salvage the
>    patch by doing a three-way merge, in case that the patch was
>    prepared against a tree that moved path "foo/bar/baz" to "baz";
>    and
>
>  * such a three-way merge succeeds cleanly for a path whose movement
>    was detected correctly.
>
> So it does not look odd at all to me (the use of "-p 3" does look
> odd, but I know this is an effort to come up with a minimum example,
> so it is understandable that it may look contribed ;-).

Ah, we were thinking that 'git am' (when run from a subdirectory),
would apply the patches "from the current directory". So the right
solution was to instead do:

$  git am --directory=foo/bar/baz -p 3 0001-my-test.patch

Thank you,

-- 
Cheers,

Sverre Rabbelier
