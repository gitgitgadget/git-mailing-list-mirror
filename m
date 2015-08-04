From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: Re: fetching from an hg remote fails with bare git repositories
Date: Tue, 4 Aug 2015 17:27:13 -0400
Message-ID: <CAKfKJYshy58eQMXTusUTf0dc2B7uVU+=rzdSicSG0JAuODSBug@mail.gmail.com>
References: <CAKfKJYuuO+eak-L2SUVUEmoOj16bgV6LL0S=g-LzFjTxZUcRzQ@mail.gmail.com>
 <CAGZ79kawh0himmR+DuvcQB0O1rRVBhkg9ycCLvPdbp1m0sHKtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:27:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMjkL-0001bU-03
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 23:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbbHDV1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 17:27:37 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36000 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbbHDV1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 17:27:36 -0400
Received: by igbij6 with SMTP id ij6so83233851igb.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8g3K4+FwSfaxafSD+pq5S9RNenLP+THBL6AJC1z7wG0=;
        b=eCDXUYHsrGS4foNhlE3kj0G/owKd7ZmkS+EOHcC3BF7wl5SU5PgW24S+iV8frIpzt0
         go1IEY5oclye87+E6lfMzHWsaGYa4cn9j9Iq7kKX1vJSFWMW3q8szOXgY34pSpOs3l1y
         ZxID1YpQXTvySMCaUd8rttyleHr+7dwj2Jw1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=8g3K4+FwSfaxafSD+pq5S9RNenLP+THBL6AJC1z7wG0=;
        b=Va59iQLXHkWCzg9qGAYAh1O66RrbI7SHTthMVZ2xcHt8cNWXG5eED7+YVzo4qWCfOU
         CY9ztfrgy/L8RMfcECXdsyDkdr3SzLeg+mFAVsjjyu7btmBOlbLl+KagfDZbetA9zBOJ
         x3RPiDLuMhhysBlkc+LxQ9DI6PiSzM+Et5E194TCXGu68uNA/AvEXr57BQ+ABM4HGPtm
         6iNqDA0lI9e61hPXBYut+EjP7ZolAK8ExLmhAXKog/MHCItNxzHb9yj+HYUCriBta7dK
         xCVl5m3dOenQY/xxMjPltByi/Lc6K7G93YtkG6unubxcwYmX7GsXi2cDEWvhuUZqqe1T
         Z5MA==
X-Gm-Message-State: ALoCoQmTS6b+IOiyZ9cnfZc5gJ3MI/vOuj2u1AByNeDuvFrZoVw7wXUEY156E7+XE23vShF4C/9f
X-Received: by 10.50.61.197 with SMTP id s5mr6449011igr.51.1438723655554;
        Tue, 04 Aug 2015 14:27:35 -0700 (PDT)
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com. [209.85.223.178])
        by smtp.gmail.com with ESMTPSA id q12sm2001236igr.2.2015.08.04.14.27.33
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2015 14:27:34 -0700 (PDT)
Received: by ioeg141 with SMTP id g141so30600081ioe.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 14:27:33 -0700 (PDT)
X-Received: by 10.107.153.5 with SMTP id b5mr7172241ioe.143.1438723653382;
 Tue, 04 Aug 2015 14:27:33 -0700 (PDT)
Received: by 10.107.8.37 with HTTP; Tue, 4 Aug 2015 14:27:13 -0700 (PDT)
In-Reply-To: <CAGZ79kawh0himmR+DuvcQB0O1rRVBhkg9ycCLvPdbp1m0sHKtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275336>

On Tue, Aug 4, 2015 at 2:56 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 4, 2015 at 10:45 AM, Taylor Braun-Jones
> <taylor@braun-jones.org> wrote:
>> Fetching from an hg remote fails with bare git repositories. Non-bare
>> repositories work fine.
>>
>> Steps to reproduce:
>>
>> mkdir /tmp/hgrepo
>> cd /tmp/hgrepo
>> hg init
>> echo foo > foo.txt
>> hg add foo.txt
>> hg commit -m "add foo.txt" foo.txt
>> git clone hg::/tmp/hgrepo/ /tmp/gitrepo
>> cd /tmp/gitrepo/
>> git fetch # WORKS
>> git clone --bare hg::/tmp/hgrepo/ /tmp/gitrepo.git
>> cd /tmp/gitrepo.git/
>> git fetch # FAILS
>>
>> The error message from the last line is:
>>
>> fatal: bad object 0000000000000000000000000000000000000000
>> error: hg::/tmp/hgrepo/ did not send all necessary objects
>>
>> Taylor
>
> Which version of git did you test this with? Does it also happen on
> the latest version?

Sorry - forgot that detail. This is using git 2.1.4 from Ubuntu 15.04
x86_64. I haven't tried the latest version of git yet.
