From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] Change sed i\ usage to something Solaris' sed can handle
Date: Mon, 28 Oct 2013 21:10:46 +0000
Message-ID: <CAP30j15+E4cz_kwJwaSH7-3agwC5J3jGNfaixSUg2=8xAzZoQg@mail.gmail.com>
References: <1382909208-7716-1-git-send-email-bdwalton@gmail.com>
	<877gcx1eho.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:10:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vau5M-0004ll-Ot
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab3J1VKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:10:47 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:46188 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3J1VKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 17:10:47 -0400
Received: by mail-qa0-f42.google.com with SMTP id w8so2437768qac.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rzPj4j7zZL8HicHIESu9k5ye7H8mVzF0CVRnQi2ViaI=;
        b=pf4hoO+M4ywi2OekAEtOoDBHfiPSeXyFP0+MSYgPrq+u359prjcTKiLcawKXKo6+5b
         ymjxlox6Ha6YWjBKsU1bF2mAIuiyA5WaXI1eHJtChBjfaL6rgDbjTTuqQTcRkKQ7lK1S
         3W4QpYqoDbV74rzfL44y4F0cNfBgb98H/mgNgVuQfQ+WVkVD46KHTURubnlJACtchwVn
         KOa3IMQGjjynkCPayyyzyj4MCsM+fLKRo/+DFt0CrqVgszL706GDG8KmdiJu9CClhhS+
         OlgppcykCYRBI6HgVz/w60SmSPCgZceRQTtvzZOTB7MmaJn2N2rXqfvp8Wl5fhxSsCV+
         wcSQ==
X-Received: by 10.49.59.70 with SMTP id x6mr19440460qeq.17.1382994646272; Mon,
 28 Oct 2013 14:10:46 -0700 (PDT)
Received: by 10.224.189.12 with HTTP; Mon, 28 Oct 2013 14:10:46 -0700 (PDT)
In-Reply-To: <877gcx1eho.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236862>

On Mon, Oct 28, 2013 at 5:39 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Ben Walton <bdwalton@gmail.com> writes:
>
>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index 3fb4b97..0126154 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -145,7 +145,8 @@ test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect
>>  test_expect_success 'ignore-blank-lines: only new lines' '
>>       test_seq 5 >x &&
>>       git update-index x &&
>> -     test_seq 5 | sed "/3/i \\
>> +     test_seq 5 | sed "/3/i\\
>> +\
>>  " >x &&
>
> Why do you need the \<nl>?  Since it is inside double quotes the shell
> will remove it during expansion.

It's an escape. Without it, sed throws:

sed: -e expression #1, char 5: expected \ after `a', `c' or `i'

Thanks
-Ben
-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
