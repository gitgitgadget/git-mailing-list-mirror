From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 12/12] t3901: test git-am encoding conversion
Date: Tue, 14 Jul 2015 17:43:06 +0800
Message-ID: <CACRoPnTZap1bn99kB37eJ3N61EprSa9oyXozRJ5qmN9JPTDVkw@mail.gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
	<1435861000-25278-13-git-send-email-pyokagan@gmail.com>
	<559D8BA0.5090701@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 11:43:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEwkU-0007K4-3G
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 11:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbbGNJnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 05:43:11 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:32805 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbbGNJnH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 05:43:07 -0400
Received: by laem6 with SMTP id m6so2768476lae.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wjEQfNgExvzl3CwROHoxY0ZIfhPHjeik9mriq2mMkNU=;
        b=lA6Q3ntuIruwAvwSc2uTHIMUFco4F5wtF/N3CdtdoVoXUD1GVXHtckgkROtsXaLrzL
         QiHm96Z99ZjKvF/38M7ZNSV4wgZQbh8Gf0vAhpjysCRRQJRlAgxcgDcf7dgi9+MKwLdw
         nfKDnyFFLzw1QoNW+TGGS43BeNmKBK+OtFu4VDUc3HCjtkQuhOW/yaEx3A2hoqUAf1j6
         GVOnkXIRbzAYCl9Qs1+0xSpZYIq2/ochYzn58dewwwHl75E99GMy2xmhQ0bLQiE7EVf5
         YssErEz4Ci61rpioJHJndBs6M5iIdpXHF8vSEzg+gTJbJ4WXx8A8Aa3p6lG0b4xPGcPh
         ebsA==
X-Received: by 10.152.22.99 with SMTP id c3mr37509990laf.32.1436866986238;
 Tue, 14 Jul 2015 02:43:06 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 14 Jul 2015 02:43:06 -0700 (PDT)
In-Reply-To: <559D8BA0.5090701@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273944>

On Thu, Jul 9, 2015 at 4:44 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 02.07.2015 um 20:16 schrieb Paul Tan:
>> diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
>> index 75cf3ff..b49bdb7 100755
>> --- a/t/t3901-i18n-patch.sh
>> +++ b/t/t3901-i18n-patch.sh
>> @@ -251,4 +251,66 @@ test_expect_success 'rebase --merge (L/U)' '
>>         check_encoding 2 8859
>>   '
>>
>> +test_expect_success 'am (U/U)' '
>> +       # Apply UTF-8 patches with UTF-8 commitencoding
>> +       git config i18n.commitencoding UTF-8 &&
>> +       . "$TEST_DIRECTORY"/t3901-utf8.txt &&
>> +
>> +       git reset --hard master &&
>> +       git am out-u1 out-u2 &&
>> +
>> +       check_encoding 2
>> +'
>> +
>> +test_expect_success 'am (L/L)' '
>> +       # Apply ISO-8859-1 patches with ISO-8859-1 commitencoding
>> +       git config i18n.commitencoding ISO8859-1 &&
>> +       . "$TEST_DIRECTORY"/t3901-8859-1.txt &&
>> +
>> +       git reset --hard master &&
>> +       git am out-l1 out-l2 &&
>> +
>> +       check_encoding 2 8859
>> +'
>
>
> This test case must be protected by !MINGW, just like the last case below
> and other cases that are already in the file. See 32f4cb6cee for details.

Ah, OK.

Thanks,
Paul
