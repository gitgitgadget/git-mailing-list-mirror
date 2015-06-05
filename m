From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 0/2] make commit --verbose work with --no-status
Date: Sat, 6 Jun 2015 00:48:35 +0800
Message-ID: <CALUzUxrFvE-SDW0q2P08vR7rc4GHdpm24y7dk+kUdyGGwmqwOQ@mail.gmail.com>
References: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
 <xmqqd21buxla.fsf@gitster.dls.corp.google.com> <CALUzUxqeadRii1o0-yo=QaZCqoAzGk+aVq=y1-11dJvK=em0qw@mail.gmail.com>
 <xmqqbnguta69.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:49:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0unl-0001rq-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423178AbbFEQs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:48:58 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32986 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbbFEQs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:48:56 -0400
Received: by iebgx4 with SMTP id gx4so61630982ieb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K5tWAYilvXVaX2FxPlhHzKMVZRI7Ibmhp4WGcYUTjAM=;
        b=TeuuSEuBls97ucsoNffbXyLgXwQZqJyemcYu4ktZWS3rlOefvx1l8hNBSvo0TaDWDQ
         YHlSbi1POf2KSphhBYiE4m5k0ue2rk7Zr8+UVDu0ssnsTZE3gecXDYCWczT+ATxtkMNi
         jQWl0UPcZNw1fnVRT3GwoW2rOXl3desGxVGu46kv2bE+MnvDg3pHSPN6Dy9QvS0PQqVw
         DX5/jVoce3hB6jodYM3ZUf7RKdbMFFjqAmGJ/odkbzfixstIp/UIS6t0Rk7UYAS4OJWS
         5uaxN0xomd2/12KijWqVRZa0ltqj+IebJOYlWb9LRmtRUPkLzwSVoT5DP8BbktAGtdq1
         olFA==
X-Received: by 10.107.135.78 with SMTP id j75mr4314588iod.67.1433522936224;
 Fri, 05 Jun 2015 09:48:56 -0700 (PDT)
Received: by 10.64.246.103 with HTTP; Fri, 5 Jun 2015 09:48:35 -0700 (PDT)
In-Reply-To: <xmqqbnguta69.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270857>

On Sat, Jun 6, 2015 at 12:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> Would it be a good idea to have a --diff-only option to include diff,
>> but not status output? Or perhaps a --diff option, while leaving it to
>> the user to specify if status output is to be included with
>> --no-status, which would open the doors for mixing and matching status
>> formatting control, eg. with --short.
>
> The name "--diff-only" does not sound right, as people would wonder
> what should happen when you give "--status --diff-only".
>
> Perhaps you would need to do some careful thinking, similar to what
> we did when deciding the "diff" and "log" options.
>
> We originally had "--patch" and then "--patch-with-stat" to "diff"
> and "log", but soon after that people found that "show only stat
> without the patch text" is a useful thing to do.  We retrofitted the
> command line parser to take "--patch" and "--stat" as orthogonal but
> inter-related options, which was a successful conversion that did
> not break backward compatibility (These days people would not even
> know that these strangely combined forms "--patch-with-stat" and
> "--patch-with-raw" even exist).
>
> All of the above assumes that showing only the patch and not other
> hints to help situation awareness while making a commit is a useful
> thing in the first place.  I am undecided on that point myself.

Hmm, perhaps such functionality should be off-loaded to a third-party
wrapper. (I'd not be surprised if most wrappers already have this.)

-- 
Cheers,
Ray Chuan
