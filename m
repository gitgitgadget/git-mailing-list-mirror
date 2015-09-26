From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sat, 26 Sep 2015 18:40:41 +0200
Message-ID: <D5E16E1E-A2A7-4C05-B590-CF62ED3BA08D@gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com> <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com> <1443150875.3042.3.camel@kaarsemaker.net> <699c08632232180166145f70c7f16645@dscho.org> <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 18:41:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfsXU-0008PB-TY
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 18:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbbIZQlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 12:41:00 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33033 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbIZQk7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2015 12:40:59 -0400
Received: by wiclk2 with SMTP id lk2so56343179wic.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n/GWKMV1fu8r/TbD3vq88j5A4zC2iZBYCMNSz5i0GxQ=;
        b=qT27qrzlCVVBTMb7s/jL25+ZRlUt7yUX6ISFh5hNMzIkuB4er3aWwERJ1/EHu3DJ8c
         UUshJM0NA0sWFWjhsN22m6Qg8cE28wM3A+cGvbe5a/c2+nNrRq4Wj+28Sgf0O5d4/Aqx
         P3aBtA42TwlvilDkfXQ8wkPTczOk5h7ejXXH/VPhpsthq3vKxhKdEUAMvufDFyWMoJhE
         x6qqSkeWzq2PAVFF46wVY7fnqBh5nQszMgqb7qnf+X2x7yK4/CV+LJKMOA8F3aI/4GzV
         H2k4eUCx2KHgPNcscUCFPnhtQo2z/YV/qYnVfWMr4l2y3X/BtfQhyhjezDP9f5d4QzUE
         fZaw==
X-Received: by 10.180.39.193 with SMTP id r1mr9031554wik.57.1443285658140;
        Sat, 26 Sep 2015 09:40:58 -0700 (PDT)
Received: from [192.168.43.187] ([82.113.99.208])
        by smtp.gmail.com with ESMTPSA id fn4sm9038477wib.11.2015.09.26.09.40.45
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Sep 2015 09:40:57 -0700 (PDT)
In-Reply-To: <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278695>


On 25 Sep 2015, at 10:05, Luke Diamand <luke@diamand.org> wrote:

> On 25 September 2015 at 08:27, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Hi,
>> 
>> On 2015-09-25 05:14, Dennis Kaarsemaker wrote:
>>> On do, 2015-09-24 at 17:41 -0700, Junio C Hamano wrote:
>>>> larsxschneider@gmail.com writes:
>>>> 
>>>>> My idea is that the owner of "https://github.com/git/git" enables this account
>>>>> for Travis (it's free!). Then we would automatically get the test state for all
>>>>> official branches.
>>>> 
>>>> The last time I heard about this "it's free" thing, I thought I
>>>> heard that it wants write access to the repository.
>>> 
>>> It does not need write access to the git data, only to auxiliary GitHub
>>> data: commit status and deployment status (where it can put "this
>>> commit failed tests"), repository hooks (to set up build triggers),
>>> team membership (ro) and email addresses (ro).
>> 
>> If that still elicits concerns, a fork could be set up that is automatically kept up-to-date via a web hook, and enable Travis CI there.
>> 
>> Junio, if that is something with which you feel more comfortable, I would be willing to set it up. Even if the visibility (read: impact) would be higher if the badges were attached to https://github.com/git/git proper...
>> 
> 
> It would be less intrusive for the CI system to have a fork. Otherwise
> other people using git with the same CI system will get annoying merge
> conflicts, and we'll also end up with a repo littered with the control
> files from past CI systems if the CI system is ever changed.
> 
> From past experience, if it's configured to email people when things
> break, sooner or later it will email the wrong people, probably once
> every few seconds over a weekend.
> 
> Automated testing is a Good Thing, but it's still software, so needs
> maintenance or it will break.

I completely agree with your argument about emails and that software needs maintenance. We could setup this CI to not send any emails. We still could inspect the build/test state of each branch on the Travis CI website. I believe this is valuable because not everyone has e.g. a Mac system at hand to run all tests. This is no theoretical example because t9819 is broken on maint using a Mac.

Lars