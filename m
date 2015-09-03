From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] t9821: use test_config
Date: Thu, 3 Sep 2015 17:13:54 +0200
Message-ID: <1C0CF9F4-29EA-4EE0-9DD1-071D57BCFD8B@gmail.com>
References: <1441272887-72633-1-git-send-email-larsxschneider@gmail.com> <1441272887-72633-2-git-send-email-larsxschneider@gmail.com> <CAPig+cTzeUKiFVvdsGBvvUg+9qOw6RWHdzuTgQRTWm5w0CeRcQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>,
	=?iso-8859-1?Q?Galan_R=E9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 17:16:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXWFt-0000cg-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 17:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbbICPQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 11:16:44 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34558 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbbICPN6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 11:13:58 -0400
Received: by wicfx3 with SMTP id fx3so23467464wic.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cksyEQDhXLa87Qu4yW8izFnhaz8XeQ578rOil3gFv8Y=;
        b=qaehbPwnI7s0lINeS1oMaTGqlIZjDWEvIGykhiiweDLYYlYLotG7C8PYdWTys5/GB9
         6WkHxEviM31NVsOpY9NTL9Jsg+b8ztJFsWQkcfI6KjY3PKtPDlDj70iMNWsje2NL07pH
         T9to7STdyW7a4pmndYJ1BMbcg/AoslWyRBto9lal7en8TX6lHZi8YoOTUQd09pB+c8/8
         LyIyW29uAZl3rmiUMe336TfUY8g1Air4NzTc/lm38gTYDCG947uwvuIpDxL8MAeBOfBV
         OQXlFemoAODo9uB7PyR4jvBhxDzUyseVdt92e96784i18AkLyp3xhKZgxy7PiizU9Nkp
         bzBw==
X-Received: by 10.180.92.201 with SMTP id co9mr15499028wib.35.1441293237212;
        Thu, 03 Sep 2015 08:13:57 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id fz5sm9466286wic.18.2015.09.03.08.13.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 08:13:56 -0700 (PDT)
In-Reply-To: <CAPig+cTzeUKiFVvdsGBvvUg+9qOw6RWHdzuTgQRTWm5w0CeRcQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277211>


On 03 Sep 2015, at 15:04, Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Thu, Sep 3, 2015 at 5:34 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
>> index 81e46ac..5a26fec 100755
>> --- a/t/t9821-git-p4-path-variations.sh
>> +++ b/t/t9821-git-p4-path-variations.sh
>> @@ -45,7 +45,7 @@ test_expect_success 'Clone root' '
>>        (
>>                cd "$git" &&
>>                git init . &&
>> -               git config core.ignorecase false &&
>> +               test_config core.ignorecase false &&
> 
> test_config ensures that the config setting gets "unset" at the end of
> the test, whether the test succeeds or not, so that subsequent tests
> are not affected by the setting. However, in this case, since the $git
> repository gets recreated from scratch for each test anyhow, use of
> test_config is superfluous. In fact, it may be slightly
> contraindicated since it could mislead the reader into thinking that
> state is carried over from test to test. (Not a big objections, but
> something to take into consideration.)
OK. Do I need to do anything to take the PATCH suggestion back?
I thanks for the explanation!

Cheers,
Lars
