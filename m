From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 2/2] git-p4: handle "Translation of file content failed"
Date: Tue, 15 Sep 2015 23:12:32 +0100
Message-ID: <55F897D0.9000100@diamand.org>
References: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com> <1442249728-89494-3-git-send-email-larsxschneider@gmail.com> <55F7BE2A.80609@diamand.org> <5FF97F9B-E2FB-4919-BCAF-5462ED9D1EEE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 00:12:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbySq-00083w-9f
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 00:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbbIOWMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2015 18:12:32 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34551 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbIOWMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 18:12:31 -0400
Received: by wicfx3 with SMTP id fx3so47982514wic.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3YTiKpFVnkVqo01f77m7s7Tb7UFaFcGbmDwyHrXWQdg=;
        b=fRwVl6Ho6BxKCyBvsu0AmMQXESHGqSyTgRTU5aaByWqwxgE2dn8ULvQj7ssJmMnbys
         sjOthIg+mERWTzfiOMJKQfvzX0G6Q5Lq7OJK04zGIYV20PPrwX/TuMEZ5aZOHZ1q2rcg
         s4wo+4P2HzMcN8M4AgFV3wcgD5cWXiiruHN4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3YTiKpFVnkVqo01f77m7s7Tb7UFaFcGbmDwyHrXWQdg=;
        b=War3OzPuLyjkdC1Co/PwPeFc4DnDpG8yZ1qy2pxDSETdle3WslvyahS+oxCkUd/4eR
         zRo9y+L7/D1XMGM8ySKtD1d5ugM9Ps33Lm2aMDaw4gkgggy8HG6QNi3ia4RE25dOn8Lf
         Rv+4vW/8CAKkf6aj5lgIpq/nrKONrQ/lfwByGQMMFQ99cBharNoHrstLCQCLQ1bUHJa0
         uZbj8T//lpKKn5MqRFXu9rwArhy2NxFcCkukUjNQPW7sEFmT62G+iRIs28vJHV1WTUED
         FOdk1i/Q8am8pjvk3DlbphuqFOEbmP9jF8g82S6g1P5i954pSCqmWH6k6NPzJFpxj2K8
         OdRA==
X-Gm-Message-State: ALoCoQnFBMpLNrxddUFioPVfQiCyu3kfekpcyblT5+PG1q/zdjmBVXEMNClBeDaW95ma3Gdc3mm4
X-Received: by 10.180.92.225 with SMTP id cp1mr11866771wib.2.1442355150291;
        Tue, 15 Sep 2015 15:12:30 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id cx3sm23216945wjc.27.2015.09.15.15.12.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2015 15:12:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <5FF97F9B-E2FB-4919-BCAF-5462ED9D1EEE@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277986>

On 15/09/15 16:38, Lars Schneider wrote:
>
> On 15 Sep 2015, at 08:43, Luke Diamand <luke@diamand.org> wrote:
>


>> Do we know the mechanism by which we end up in this state?
> Unfortunately no. I tried hard to reproduce the error with =93convent=
ional=94 methods. As you can see I ended up manipulating the P4 databas=
e=85
>
> However, it looks like this error happens in the wild, too:
> https://stackoverflow.com/questions/5156909/translation-of-file-conte=
nt-failed-error-in-perforce
> https://stackoverflow.com/questions/887006/perforce-translation-of-fi=
le-content-failed-error

It's described in the Perforce FAQ here:

http://answers.perforce.com/articles/KB/3117

i.e. it looks to be caused by mixing old and new P4 clients.

>>>
>>> Known issue: This works only if git-p4 is executed in verbose mode.
>>> In normal mode no exceptions are thrown and git-p4 just exits.
>>
>> Does that mean that the error will only be detected in verbose mode?=
 That doesn't seem right!
> Correct. I don=92t like this either but I also don=92t want to make h=
uge changes to git-p4.
> You can see the root problem here:
> https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a87=
d6d/git-p4.py#L110-L114
>
> Any idea how to approach that best?

I guess what we have is not ideal but probably good enough.


>>> +            try:
>>> +                text =3D p4_read_pipe(['print', '-q', '-o', '-', '=
%s@%s' % (file['depotFile'], file['change'])])
>>> +            except Exception as e:
>>
>> Would it be better to specify which kind of Exception you are catchi=
ng? Looks like you could get OSError, ValueError and CalledProcessError=
; it's the last of these you want (I think).
> I think it is just a plain exception. See here:
> https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a87=
d6d/git-p4.py#L111

OK, you're right (probably less than ideal behaviour from read_pipe()=20
and die() but let's not try to fix that).


>>> +                if p4_version_string().find('/NT') >=3D 0:
>>> +                    text =3D text.replace('\r\n', '\n')
>>> +                contents =3D [ text ]
>>
>> The indentation on this bit doesn't look right to me.
> I believe it is exactly how it was:
> https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a87=
d6d/git-p4.py#L2397-L2399

OK.

>
>
> In general, what is the appropriate way to reference code in this ema=
il list? Are GitHub links OK?

I'm not an expert, but it feels possibly a bit ephemeral - if someone i=
s=20
digging through email archives in a future where that github project ha=
s=20
been moved elsewhere, the links will all be dead.

Luke
