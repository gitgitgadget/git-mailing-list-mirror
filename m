From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] Added tests for reset -
Date: Tue, 10 Mar 2015 14:05:37 -0400
Message-ID: <CAPig+cSqJcfNRXmLdHXvHvUiv1NFgXA6cZ4YFyxoWuyivjWUEQ@mail.gmail.com>
References: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
	<1425984728-27996-2-git-send-email-sudshekhar02@gmail.com>
	<vpqa8zlx9td.fsf@anie.imag.fr>
	<CAODo60p_2deueOS5nYfHPTMas=GcHR4n8dNs8HJt-ZR+2SifzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 19:05:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVOXH-0003Dd-6C
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 19:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbbCJSFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 14:05:39 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:34089 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbCJSFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 14:05:38 -0400
Received: by yhaf73 with SMTP id f73so1742352yha.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pP33W9dUOirB8MeOLqXQTfo76lcJwP9dhpV0VWWo8WQ=;
        b=e7k+hPhLXVgIqZ+1jFx+p1Fjg+lsOt0EfIoYAZAIOD2n004dwfuAIsIqSNgYfqdC8y
         A/ubxunFDbV5U5kNJ7OK93iY8ZacJJlrw133uAPLdXK4Y19/iuwpAaIePzqjMlFD0j5p
         nYieEQrt4HlLgQuYXvPEJAhjkCFAGphGArmf+LoocamGUjd1eUKgzXwQvtGpAHS0HYqz
         RIFOlT/OlPOGFclF7hWRORQlt6ITYv53cyi9YJ4brTIYOrIKHUSNuCuM99Wy4o5Fpwqf
         GGZKErnzHT8UoWPvQDwuMNMyJWjksYOqqUtdM610CBKaRgFEt+Je4deRqTcx8NY0ePLW
         karA==
X-Received: by 10.236.10.5 with SMTP id 5mr32638924yhu.148.1426010737457; Tue,
 10 Mar 2015 11:05:37 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 11:05:37 -0700 (PDT)
In-Reply-To: <CAODo60p_2deueOS5nYfHPTMas=GcHR4n8dNs8HJt-ZR+2SifzA@mail.gmail.com>
X-Google-Sender-Auth: -2Pgg6i12gihn0CjpUYnzpNN1Xs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265251>

On Tue, Mar 10, 2015 at 1:52 PM, Sudhanshu Shekhar
<sudshekhar02@gmail.com> wrote:
> On Tue, Mar 10, 2015 at 6:56 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:
>>> +test_expect_success 'reset - in the presence of file named - with previous branch' '
>>> +     echo "Unstaged changes after reset:" >expect &&
>>> +     echo "M -" >>expect &&
>>> +     echo "M 1" >>expect &&
>>
>> Here and elsewhere: why not
>>
>>         cat >expect <<-EOF
>>         Unstaged changes after reset:
>>         M -
>>         M 1
>>
>> ?
> I was confused whether to use cat or echo. I thought using cat will
> disrupt the indentation as the EOF needs to be on a single line. This
> is why I chose echo. Please let me know your thoughts on this.

Here-docs are easier to compose and read than individual 'echo'
statements for multi-line content.

The '-' in front of EOF allows you to indent the entire body. Even
better, use -\EOF to signify that you don't expect any interpolation
to occur within the body.
