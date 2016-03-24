From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 3/3] commit: add a commit.verbose config variable
Date: Thu, 24 Mar 2016 15:52:54 +0530
Message-ID: <CAFZEwPN2+RwrE583XHOv9=05XQaWZnL=cK6wa0rMC-3AU275yg@mail.gmail.com>
References: <01020153a7ba4ec2-1fb668c3-9dc6-4137-8d92-c6a5825a156c-000000@eu-west-1.amazonses.com>
	<1458813876-10591-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 11:23:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj2Ps-00089G-JW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 11:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbcCXKW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 06:22:57 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34337 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbcCXKWz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 06:22:55 -0400
Received: by mail-yw0-f195.google.com with SMTP id f6so4905081ywa.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=HAyE/DNd5YD/fDIkBBcvI6I3SUgdbuWxrghnija98bw=;
        b=iFEoDrRoA6nEGdDCY1pw+lsZ42GHwm4mCVKfWc+NtBtUyVjcGrfv0v7uL53LjEF9jd
         9Te7ERViDDDhOjHROy+KYnjQes4RSwixLQLlJKDQNE2pLS2TA0Ki1e2BdNqAPb7y+U8s
         oMH61F7h42QBr0evczD805C1UFyaz46x06rjtLi95+NX0Mq/Zy4m5tXwIRtLE9FuLaeK
         0NYP36m8bi/SULIprp7c/adqp48dIGSpY4H+mpK8HlTc/vf+fr2/r3ZNukvUQH0gqyNp
         Nb/hfqjPtGHWk4BNf6Gjpu+Ts18fOQiy+K566O9NvxlNsud4hUdqRowoy7/bpvbwO6ea
         YeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=HAyE/DNd5YD/fDIkBBcvI6I3SUgdbuWxrghnija98bw=;
        b=m3uCFV99p38EqQmlxwdt8Go6IqaZGJ0cewKYnYWVD1zfBYusZ0nXEsX9dHonOMT8sP
         MpUGyurPMBVDNH5rM6DPfYW4xVj5mq+5hYCHtgMnJ+3VAO8cS8q7j5EPhHYC/fIVdXgC
         YfUbwCUajGZNdwrm0Lo4ZdopSNr+Hh5Bj0BbanXPRXAjpZRyaiZUe+dwMplzH5oz4K9I
         0S6Lu4ixH/Tj8Sut9q17RMrZtLnnvXHfZGSEoUnb3aXwVGaQrUWpUU5oKSamXpjNge0w
         q3ZjdLVWKj3+yI1sd6nR0Ae9tAFN2MkOdZdTSxpqas3IpFvXkFaupQE3d8vBBIJMC4eF
         DxPA==
X-Gm-Message-State: AD7BkJIvS5IP7Qnp+MQ/zQ2pz+pSmd1d65aM0rJtSw6N21AffyXPK4FCQA4Oqr+Of7XzRUizedjiyO0aOLclUQ==
X-Received: by 10.129.91.6 with SMTP id p6mr3692506ywb.325.1458814974263; Thu,
 24 Mar 2016 03:22:54 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 03:22:54 -0700 (PDT)
In-Reply-To: <1458813876-10591-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289731>

On Thu, Mar 24, 2016 at 3:34 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>> Add commit.verbose configuration variable as a convenience for those
>> who always prefer --verbose.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>
>> ---
>> The previous version of the patch are:
>>  - [v8] $gmane/288820
>>  - [v7] $gmane/288820
>>  - [v6] $gmane/288728
>>  - [v5] $gmane/288728
>>  - [v4] $gmane/288652
>>  - [v3] $gmane/288634
>>  - [v2] $gmane/288569
>>  - [v1] $gmane/287540
>>
>> Changes with respect to the previous patch:
>>  - Compare with -1 as only -1 value is used for unspecified behavior=
=2E
>>  - Write clean tests
>> ---
>>  Documentation/config.txt     |  4 ++++
>>  Documentation/git-commit.txt |  3 ++-
>>  builtin/commit.c             | 13 ++++++++++-
>>  t/t7507-commit-verbose.sh    | 51 +++++++++++++++++++++++++++++++++=
+++++++++++
>>  4 files changed, 69 insertions(+), 2 deletions(-)
>
> Please always run the full test suite before submitting patches to
> make sure that your changes do not inadvertently break something.
> This patch breaks several tests in t7512-status-help.sh,
> t7508-status.sh and t7060-wtstatus.sh.

Sorry for that. I will make sure I do run the complete test suite. I
currently ran only commit based tests. But now that I think about it
that since status and commit share a lot of things, it might be
possible to break parts of status. I will investigate further as to
what cased this problem though I kind of get a hint that it is because
of verbose being the parent and others consuming it. There are a lot
of tests failing.
