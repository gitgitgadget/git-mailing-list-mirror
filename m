From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] git submodule: Teach add to accept --group
Date: Wed, 20 Jan 2016 16:16:05 -0800
Message-ID: <CAGZ79kYY950Ob252ob=sqCkEh_48geBi-a9t-p0jPCn6naCWxg@mail.gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-2-git-send-email-sbeller@google.com>
	<xmqq1t9c54qz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaHLkQpaHOY2aqPgdNvWjmpbuMZSogqzPkkVHRUXyibYw@mail.gmail.com>
	<xmqq37tr3ibb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 01:16:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM2vB-0000uu-7a
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 01:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbcAUAQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 19:16:09 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36261 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcAUAQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 19:16:06 -0500
Received: by mail-ig0-f178.google.com with SMTP id z14so114186067igp.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 16:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XAWxzpowKBBFMMNzEl7Td4KqQv25VOaXHLkjAwsb3VM=;
        b=OUKOM137rtpQGxFDRTiESfX0tQmCMLkBiJzXHQCSVpae5UKSQWcw5Lg1YpbaVFmlKE
         iiEX1+r43JGrRE/+aIUzj+YfIzv1L8m/za1YtkGmagTz/f0Zmuc99g7ZTWnyJ11YZDSa
         fzWgsByPpk9i8Uvas5K/FYjatIiI80p4jcanGwKi4wD2ritaNr+tIuzByucTUJiCzCgC
         NnsU0rBBzN7kzcsJNA3ajXyVthZxseF5ZPz0g09bNHB5WMGp5d6k1fzEPsKRD4QWzzd6
         6nQhYriJOpjwRTKb0qJVbSxrZYg3yJvoHXE2tyPs8gK7LA3nHRZ0uyiuTrH1C+Qqp4Bq
         w3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XAWxzpowKBBFMMNzEl7Td4KqQv25VOaXHLkjAwsb3VM=;
        b=EZAFELC9zESg8fJZ5YNsPSW9yBMg6HMDSfupwacRCGnX6Jo+1Wx5HQnTpKg4cAQATO
         M+W8HQU9pZ44TI1Bxff6nHHmGyT9gFWjHPapuwHiFaw2LHZOPh/A9rYfhfe4PI/6DSEw
         DEOnxZ6qsonRninIoZfu3uBKim09iLF5JBu0tqI4JopbJKhdNCdMo0M8Yx6HOpfPFbaK
         OHX50IddNpEnBSXb+OSrt5fvHYGPDcazztuO8EBmxwEMjAzoLvCnS2XPSLrulVoTWakE
         QTn418LdFov87T4r75U8jbJke8eOCV0rZrLKd/H9pxgR6kwKaU1PmajBg0/LAJXM6ilm
         XryA==
X-Gm-Message-State: AG10YOTegUIzJ2jTZrEyayB1D6AmZ9Kt/9UKhcv9YELw17EwPhzhlip2DafZsj88tGA7Iv8l9Yl+gR97m3GShyfv
X-Received: by 10.50.138.76 with SMTP id qo12mr6398826igb.85.1453335365759;
 Wed, 20 Jan 2016 16:16:05 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 20 Jan 2016 16:16:05 -0800 (PST)
In-Reply-To: <xmqq37tr3ibb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284490>

On Wed, Jan 20, 2016 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>> @@ -165,6 +166,10 @@ cmd_add()
>>>>               --depth=*)
>>>>                       depth=$1
>>>>                       ;;
>>>> +             -g|--group)
>>>> +                     submodule_groups=${submodule_groups:+${submodule_groups};}"$2"
>>>> +                     shift
>>>> +                     ;;
>>>
>>> You would want to accept "--group=<name>" as well, just like
>>> existing --reference and --depth do.  It won't be much more code,
>>> and when you move to C (hence parse_options) you'd get it for free
>>> anyway.
>>
>> I am not sure, if I will to move `add` to C any time soon. Sure I desire
>> less shell and more C[1], but I'd think my time could be spent better than
>> just converting scripts to C. Sometimes I have to though, such as in the
>> case of `init` as the the call out from C to shell is too ugly and the effort to
>> do that is not that much less.
>
> You can do so in less time than you spent making the above 5-line
> excuse.  It won't be much more code, and it is not ugly at all.
>
>         --group=*)
>                 group=$group ${1#--group=} ;;
>
> or something, right?

Right, that's what I have here now. I should have said that.

I was not trying to excuse anything, but more explaining the situation
when reading the second sentence. (You seem to assume I'd want to rewrite
all the shell scripts. Which I am not)
