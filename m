From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests
 with timeout
Date: Tue, 17 Nov 2015 23:40:01 +0000
Message-ID: <CAE5ih78ma-71xVgA52LDiWNyPq+tCmXb3GgocO=dF81=yZXuWw@mail.gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
	<1447592920-89228-4-git-send-email-larsxschneider@gmail.com>
	<CAPig+cQkNB3VzbC_R_T=ppkgvmTbOWnK22hFxyMzJH1DZ_iVhQ@mail.gmail.com>
	<52A9F66D-12C4-4BB5-A2D4-C476A1E12DC5@gmail.com>
	<CAPig+cR8igO1bWNgma_yZqrcru_jnKchpRH+i2_AaNj8Atcb9g@mail.gmail.com>
	<564AF48C.9040406@diamand.org>
	<CAPig+cT2aBrL6Qh3W3d-ODjj7S0GORkTZMyQ6PBfHCLVqeKBvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:40:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zypr9-0006Mp-4n
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 00:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbbKQXkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 18:40:04 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33064 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbbKQXkD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 18:40:03 -0500
Received: by obbww6 with SMTP id ww6so20324636obb.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QO+TkeNXGBGGA4qWufEG6eRv910ijOSVuo/4wTBmbrg=;
        b=Q1BqA+mygbgNLS6yIwjwJhejy5OanfCeQQyTFrCkwnYiK4QeXZyczvZXzxvEPRmCWh
         yPVGjZDU25purt+7kn52/+oz0Zdnccn7ecNTAC1T+zkwT/XEWCqvBOkVDHW1D0K+K7A/
         /fn64JP8Ir09CeZREbo/NiOXG/YbWbpt8EFrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QO+TkeNXGBGGA4qWufEG6eRv910ijOSVuo/4wTBmbrg=;
        b=TnQX+KKv2vxbaZmHtXnf0COunNLry1PEzrw00CKtARBJ8ikRhisBDY0BnHbcsl4vXl
         XvFx8N6DccqgfyO32d3TmspLbphGONFuE/Y2eH6+C5M21Svte+02yw7DgPHOd2u1fme4
         jwzABm2zDroMFasdYTPq5InWHL2ImcSYb0PJJFaXZyZJQywV+Xy7OftTwH2THnsiZpyD
         W5YS/9ukzmOaG5hd7oa2Uy7TS3SFJ7cXtp3DpEKJvWwzwleYubUM4JYPCzNlalEh1Ooa
         40OElVL07MhsVVMZOKa5MP0y9tsTzYDxVgZFTkwrUxWJxq7ad2b5Tzdz8mTSgYmrYcPr
         1KJA==
X-Gm-Message-State: ALoCoQkc9mNScpwV6eW2wDLr53iEC8vcZgG0TQCXq5ObI/GUtN1tPXxkiLqSYoQUqDJikJugOKPE
X-Received: by 10.182.33.98 with SMTP id q2mr29253650obi.20.1447803601842;
 Tue, 17 Nov 2015 15:40:01 -0800 (PST)
Received: by 10.60.141.40 with HTTP; Tue, 17 Nov 2015 15:40:01 -0800 (PST)
In-Reply-To: <CAPig+cT2aBrL6Qh3W3d-ODjj7S0GORkTZMyQ6PBfHCLVqeKBvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281431>

>>
>> Which other platforms are we talking about here?
>>
>> https://www.perforce.com/downloads/helix
>>
>> From there, you can get Solaris10, HP-UX, AIX and various flavours of BSD.
>> Solaris supports "date +%s".
>
> The question about "date +%s" portability arose with a suggestion to
> employ it in git-filter-branch[1]. Apparently, the concern about
> Solaris was raised in response to a Stack Overflow question[2] which
> claimed that +%s was not supported by that OS. Unfortunately, however,
> [2] did not indicate to which (older?) versions of Solaris that
> shortcoming applied. If Solaris 10 does support +%s, and the Perforce
> product is only available for Solaris 10, then perhaps concern about
> +%s a non-issue(?).
>
> [1]: http://git.661346.n2.nabble.com/FEATURE-REQUEST-Filter-branch-extend-progress-with-a-simple-estimated-time-remaning-td7638200.html#a7638504
> [2]: http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-in-any-posix-compliant-shell

Rereading the man page more carefully, you're right, Solaris 10
doesn't do "%s". Using python to get the seconds should work though.
