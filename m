From: Matthew Mendell <matthew.mendell@gmail.com>
Subject: Re: git-p4: planned view wildcard support
Date: Mon, 7 May 2012 08:19:51 -0700
Message-ID: <CAF0RQx_0EYGiTd36WMtjeBwJL1cxsGTe44=P+btEfWn+5Hq5yg@mail.gmail.com>
References: <CAF0RQx-0M4iUHgGdH=RE_UFmLLZH8uy4kkMW=XspNzGm-vsyEg@mail.gmail.com>
 <20120507104443.GA20372@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon May 07 17:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRPjY-00036E-Hv
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 17:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab2EGPUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 11:20:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53941 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585Ab2EGPUM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 11:20:12 -0400
Received: by obbtb18 with SMTP id tb18so8406131obb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rLQmhyMX39QqlMvP1argmxRaJey3/blnFWP0DtvKNl4=;
        b=yMeNhqMwoFYdQYrjw3aakvRv+o4m2+FfpIaqexVoLSX/bVF7u3YeG/aZ1ZO7fbExXt
         V7XJUy6XQp3UHCEqVutBaAHmch+JZeNsqIAd8ZhrVsAHgUxen5D03QflHBSwsaybp4Fw
         A0eRgx4PjpgZMTpo/nEeoBdhGKOng1jhWO4bofHc/qYuk03WezXfe3+IFmTqUpWgbijo
         WKypjbtJBl6Qy6F8E0T84BUDS4Vc5akdoiG/MJTAVXWFJPJS8JYvliH5KqPfzXIoXXpk
         7eOY92k+mILS5h9qRP4HMgTEsN0B2ijfFdSekjxD/UGlk0goQ6cYg7YGEpg70eIAZ2WS
         dRNw==
Received: by 10.182.115.74 with SMTP id jm10mr19987490obb.71.1336404011592;
 Mon, 07 May 2012 08:20:11 -0700 (PDT)
Received: by 10.182.36.67 with HTTP; Mon, 7 May 2012 08:19:51 -0700 (PDT)
In-Reply-To: <20120507104443.GA20372@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197276>

On Mon, May 7, 2012 at 3:44 AM, Pete Wyckoff <pw@padd.com> wrote:
> matthew.mendell@gmail.com wrote on Sun, 06 May 2012 16:46 -0700:
>> Is there any plan for the git-p4.py script to support the "*" wildca=
rd
>> in a p4 client?
>>
>> The specific test that exposes this unsupported feature:
>> ./t9809-git-p4-client-view.sh
>> ...
>> ok 4 - unsupported view wildcard *
>
> It hasn't been on anybody's priority list so far that I know, but
> this would be not too hard to implement in theory.
>
> The code changes would need to alter just one class. =A0In
> View.Path, functions Path.find_wildcards, match_wildcards and
> fill_in_wildcards, if you're interested in giving it a try.
>
> Can you constrain your use of "*" a bit? =A0What makes these
> wildcards difficult is all the edge cases. =A0For instance, is
> there ever more than one "*"? =A0Is it combined with "..."? =A0Are
> there multiple lines in the client spec with wildcards? =A0Some
> abstracted examples would be interesting.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Pete

Hi Pete,

Yeah, I have been perusing the code and would like to give it a shot.
Is it ok to initially add partial support for the easy cases?
My usage of "*" is straight forward:

//depot/project/* //my_clientspec/depot/project/*

Thanks,
-Matt
