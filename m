From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: Re: [PATCH v3 2/2] Added tests for reset -
Date: Tue, 10 Mar 2015 23:22:07 +0530
Message-ID: <CAODo60p_2deueOS5nYfHPTMas=GcHR4n8dNs8HJt-ZR+2SifzA@mail.gmail.com>
References: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
 <1425984728-27996-2-git-send-email-sudshekhar02@gmail.com> <vpqa8zlx9td.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVOKY-0004wS-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 18:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbbCJRwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 13:52:31 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:34412 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbCJRw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 13:52:29 -0400
Received: by labgq15 with SMTP id gq15so3512907lab.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0IOKUUiqpEjzYsXOmdKJ6yAsXvcKAQa4JQ0UDMO0908=;
        b=jPwo8+n4mVxno09JiFXyy17AcDDjRnqjK0+7K7Iy7r8vpXjtcbshEqX9usrYFZR/UE
         ttgofy6a+36gpMje7OhzKd9o9xlx4/FxBrIwnfVLKbSLrCfJGZxjYMIpkb+efy5EyFTn
         exmbU/9qWnN1rWW7F9VLIwJUF8y8Vwbgl1idtH1Halw1B9mypeghS1GDPE6jEvjgfLNM
         ddtf7vz7lpVU/wHcG3ySoLhyFbakpDYHP/c95ESj98//+bx7IVHiUR1dtZ0IWwaIuvZ7
         wYTlAFmx0iXJSqFlDrizsz1CqpJAsRxWZ/q/PlBUpLwvafXNpk+1lTd0gjIwgCKzWYDf
         ohuA==
X-Received: by 10.152.88.99 with SMTP id bf3mr30735641lab.37.1426009948329;
 Tue, 10 Mar 2015 10:52:28 -0700 (PDT)
Received: by 10.152.43.138 with HTTP; Tue, 10 Mar 2015 10:52:07 -0700 (PDT)
In-Reply-To: <vpqa8zlx9td.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265250>

Hi,

On Tue, Mar 10, 2015 at 6:56 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:
>
>> +test_expect_success 'reset - while having file named - and no previous branch' '
>
> I like having the expected behavior in the test name too. e.g. add
> "fails" at the end of the sentence.
>
Sure. I will update this in the next patch.

>> +test_expect_success 'reset - in the presence of file named - with previous branch' '
>> +     echo "Unstaged changes after reset:" >expect &&
>> +     echo "M -" >>expect &&
>> +     echo "M 1" >>expect &&
>
> Here and elsewhere: why not
>
>         cat >expect <<-EOF
>         Unstaged changes after reset:
>         M -
>         M 1
>
> ?

I was confused whether to use cat or echo. I thought using cat will
disrupt the indentation as the EOF needs to be on a single line. This
is why I chose echo. Please let me know your thoughts on this.

>> +     rm -rf no_previous &&
>
> That would be best done in a test_when_finished, so that the directory
> is removed regardless of whether the test failed before this line or
> not.
Thanks for pointing this out. I will update this accordingly.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Regards,
Sudhanshu
