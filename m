From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 21:53:32 +0200
Message-ID: <CAHGBnuN+sBptYQo2T03-Ja1E_6Q3SdT7dBEVPOQXupvDU3Ot1Q@mail.gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<561B69AE.8050403@gmail.com>
	<BF182294-B896-4C2D-B371-74036BC522A2@gmail.com>
	<CAHGBnuOqVPHAhfN6qtt=VDODW9h+A1xMEnzaZfD61DCNyj_YOg@mail.gmail.com>
	<61B448FB-DB61-42B6-ACDF-181F76169061@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	tboegi@web.de, pw@padd.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:53:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZljA9-0003Zj-GG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbbJLTxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:53:33 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36995 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbJLTxd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 15:53:33 -0400
Received: by igcpe7 with SMTP id pe7so88177745igc.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JZOeHnqctmheICQjwR97J5JoQamSSbVV1hxSUlfEO0Y=;
        b=Ulf8q5LpSwj3gKJhl1A9S4A5TSj29Rn/5HrM7kXEN8m1yKt3OflxQcT77LO+WaxmqK
         m9j4sdXRtbT/uTgILlABvKDLqrWeNoS8dZwdnt809wQCmJpjlEZps0+N3MYkiXE2tVpy
         jLhjN/7roPQCWfCyefApblf4Vux1cGM4i3E8UGOE93qZY5y6IN4WDMh7lVswCVO3tL5W
         82KzskPK5j+x6/4VeqCjEZONETaKzrz+ogscIGJX0jOLn0M6MlaqRHRIxDro+cnIonxE
         jWi8pojihz2hZkxITyQyyCz999qpsRG0TgmK5m/hBcwEQTre2DeVbM2qvp9Op++l9D+1
         Tvmw==
X-Received: by 10.50.114.166 with SMTP id jh6mr15043867igb.47.1444679612281;
 Mon, 12 Oct 2015 12:53:32 -0700 (PDT)
Received: by 10.107.138.213 with HTTP; Mon, 12 Oct 2015 12:53:32 -0700 (PDT)
In-Reply-To: <61B448FB-DB61-42B6-ACDF-181F76169061@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279412>

On Mon, Oct 12, 2015 at 9:43 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:

>> Reading through Travis' docs [3] again, "before_script" is documented
>> to "return a non-zero exit code, the build is errored and stops
>> immediately", while "script" is documented as "returns a non-zero exit
>> code, the build is failed, but continues to run before being marked as
>> failed". As it does not make much sense to continue the build or even
>> start testing if the build failed, maybe it's indeed best to do:
>>
>> before_script: make configure && ./configure && make
>>
>> script: make --quiet test
>
> Ok, then I will make it so :-)

Also, this has the added benefit of being quickly able to see how much
time building vs testing took. As these two are the big blocks, we'd
want to optimize both steps for time, and it's easier to see what we
gain e.g. from a possible build-time improvement if these steps are
listed individually in the Travis log.

-- 
Sebastian Schuberth
