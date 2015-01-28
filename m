From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH 21/21] t3080: tests for git-list-files
Date: Tue, 27 Jan 2015 20:44:30 -0800
Message-ID: <CAO2U3QhA1bGAKmM4OL0VVuOfwaocqmFEsQdZNhSqf_7tkJ+=WQ@mail.gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
 <1422189476-7518-22-git-send-email-pclouds@gmail.com> <CAPig+cQ8AuoA=ZNaOiZ_JQb-fKtXa-mFhoYQg+eWJxF3eFy9FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGKUt-0008Gf-5p
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 05:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761787AbbA1Eox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 23:44:53 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:65364 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761776AbbA1Eov convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2015 23:44:51 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so17339641obc.6
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 20:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=78YYgoMC6l/wIMvHCLiY3lsRQcrEo1I6P/1+k7NKWqs=;
        b=W9hkdaFHYXRiOaPbseurD2aGZl05J/nqbEKJLCu2tsdt+DFD1sfXiXImL86N3mBJrZ
         HucUKT1HcA/ZQ1vRfqyRo+nYspEzflHOHvP/ud+feqy2mStkpqv8R/s6ebBDPRr+BFai
         0toXz9xdYawlNW3RB2dehGr8nBFcDc9nVmcTiBnnW4LrOMLys36R/emlxys/OBcQI/a5
         KFLSA4r0H6C+/AZHWd+3/1jxL3KF5E0oTMOM6/iP0lIJis/nwNLZurigAlQU6AUD36hv
         8sIXoR5ALavr/AFCspnrQggkQQ+d0FmjU6iQ1abVNY14UaY4AR1oirTvOKdcZCYIoNJS
         9tJg==
X-Received: by 10.202.197.206 with SMTP id v197mr872545oif.54.1422420291288;
 Tue, 27 Jan 2015 20:44:51 -0800 (PST)
Received: by 10.202.86.136 with HTTP; Tue, 27 Jan 2015 20:44:30 -0800 (PST)
In-Reply-To: <CAPig+cQ8AuoA=ZNaOiZ_JQb-fKtXa-mFhoYQg+eWJxF3eFy9FA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263098>

Test 3 is failing on my mac:

expecting success:
test_config color.ls.file red &&
test_config color.ls.directory green &&
test_config color.ls.submodule yellow &&
git list-files --color=3Dalways >actual &&
test_cmp "$TEST_DIRECTORY"/t3080/color_ls actual

--- /Users/michael.blume/workspace/git/t/t3080/color_ls 2015-01-28
04:40:23.000000000 +0000
+++ actual 2015-01-28 04:42:59.000000000 +0000
@@ -1,3 +1,3 @@
-dir
-file
-gitlink
+dir
+file
+gitlink
not ok 3 - color.ls.*
#
# test_config color.ls.file red &&
# test_config color.ls.directory green &&
# test_config color.ls.submodule yellow &&
# git list-files --color=3Dalways >actual &&
# test_cmp "$TEST_DIRECTORY"/t3080/color_ls actual
#

On Sun, Jan 25, 2015 at 11:20 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Sun, Jan 25, 2015 at 7:37 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/t/t3080-list-files.sh b/t/t3080-list-files.sh
>> new file mode 100755
>> index 0000000..6313dd9
>> --- /dev/null
>> +++ b/t/t3080-list-files.sh
>> +test_expect_success 'no dups' '
>> +       echo dirty >>file &&
>
> To leave a clean slate for subsequent tests, would it make sense to
> restore 'file' to a clean state via test_when_finished()?
>
>> +       git list-files -m file >actual &&
>> +       echo "file" >expected &&
>> +       test_cmp expected actual &&
>> +       git list-files -cm file >actual &&
>> +       echo "C file" >expected &&
>> +       test_cmp expected actual &&
>> +       git list-files -tcm file >actual &&
>> +       test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'diff-cached' '
>> +       echo dirty >>file &&
>> +       git add file &&
>
> Ditto here?
>
>> +       git list-files -M >actual &&
>> +       echo "file" >expected &&
>> +       test_cmp expected actual
>> +'
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
