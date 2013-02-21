From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 4/4] t7800: "defaults" is no longer a builtin tool name
Date: Thu, 21 Feb 2013 15:31:01 -0800
Message-ID: <CAJDDKr6QCQQYHvXQesVKn0hz_kvjJbEXQ9fsqojhGOCLRNGhrQ@mail.gmail.com>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com>
	<1361419428-22410-2-git-send-email-davvid@gmail.com>
	<1361419428-22410-3-git-send-email-davvid@gmail.com>
	<1361419428-22410-4-git-send-email-davvid@gmail.com>
	<7vzjyyw9bi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:31:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8fbu-0001Hd-DL
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab3BUXbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:31:05 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:39999 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab3BUXbE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:31:04 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn17so276281wib.4
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 15:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Ol3lcclqx3FHZ8AfdNCPjTrKqSMLLmU4pbr2cX+RdTQ=;
        b=IfIaD2Vppx/DlIlTRHapJBLhMOjXaE8Ben71pAQ/tLgujETZVV59E5ncfdQAXplIem
         JmF4d05oZj88u3gZ7LMrI3adrnI3fTAQIuC/qkqVNqAZ/bf9qfOhQ6eV8KZjDoQTF7w3
         WcdRu3VL17d9AKZvC3DTy9tI1Nhun/WMoTw2QD0GvzBQ5BYLmwvXFYAsA1ag9Nu5hkd5
         CvBoLs4SMSdaioGhd7w6i7hPHgtk8i2mB+gEPGq1R5C7SmIZ2dJni9RZkAKNucvQjT0b
         M2tEVokc8yZfxYrkQpphwiLYRFW7excfxVJrFYrcCOckVeGrZRvjHdPVhHF2RAOYzBMZ
         06Yw==
X-Received: by 10.194.76.37 with SMTP id h5mr45478884wjw.21.1361489462266;
 Thu, 21 Feb 2013 15:31:02 -0800 (PST)
Received: by 10.194.13.129 with HTTP; Thu, 21 Feb 2013 15:31:01 -0800 (PST)
In-Reply-To: <7vzjyyw9bi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216808>

On Wed, Feb 20, 2013 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>> index fb00273..21fbba9 100755
>> --- a/t/t7800-difftool.sh
>> +++ b/t/t7800-difftool.sh
>> @@ -60,9 +60,9 @@ test_expect_success PERL 'custom commands' '
>>  '
>>
>>  test_expect_success PERL 'custom tool commands override built-ins' '
>> -     test_config difftool.defaults.cmd "cat \"\$REMOTE\"" &&
>> +     test_config difftool.vimdiff "cat \"\$REMOTE\"" &&
>>       echo master >expect &&
>> -     git difftool --tool defaults --no-prompt branch >actual &&
>> +     git difftool --tool vimdiff --no-prompt branch >actual &&
>>       test_cmp expect actual
>>  '
>
> Eek.
>
> $ sh t7800-difftool.sh -i
> ok 1 - setup
> ok 2 - custom commands
> not ok 3 - custom tool commands override built-ins
> #
> #               test_config difftool.vimdiff "cat \"\$REMOTE\"" &&
> #               echo master >expect &&
> #               git difftool --tool vimdiff --no-prompt branch >actual &&
> #               test_cmp expect actual
> #
>
> Running the same test with "-v" seems to get stuck with this
> forever:
>
> expecting success:
>         test_config difftool.vimdiff "cat \"\$REMOTE\"" &&
>         echo master >expect &&
>         git difftool --tool vimdiff --no-prompt branch >actual &&
>         test_cmp expect actual
>
> Vim: Warning: Output is not to a terminal
> Vim: Warning: Input is not from a terminal
>

Oh boy.  I botched the rebase.  I have a replacement.  I thought I
re-ran the tests!  I'll resend it.
-- 
David
