From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t3401: modernize style
Date: Fri, 9 Dec 2011 14:07:03 -0600
Message-ID: <20111209200703.GA21280@elie.hsd1.il.comcast.net>
References: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <CALkWK0mip_pzUDQO=YLxaVwsWEAUdrk_EKcNG94Xr5+N+kzBtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:07:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6j1-00036c-Fc
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab1LIUHM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 15:07:12 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39475 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1LIUHL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 15:07:11 -0500
Received: by ghbz2 with SMTP id z2so2832742ghb.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2aSBgog3PcnsHw6o4pAtG9rfYQaQY4At4d/E9raEZvI=;
        b=cn47sBrK2B4h6NuYZ0MqCppAgh5BJm2AZFHUljUT/sKbxh4zLyTYgMSpx/FEv2cBAg
         YZGRAYid6sq2stP/7hLMCyU+wxG1XS5WjD/VoU1YtAZAlT4XMGh2FIcsV6jhk3bZ3O/7
         NFNcfeSqW0LcT56MSq/hkld4k5ASiPydVn0k0=
Received: by 10.236.190.130 with SMTP id e2mr14047497yhn.107.1323461230722;
        Fri, 09 Dec 2011 12:07:10 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id u47sm16740664yhl.0.2011.12.09.12.07.09
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 12:07:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mip_pzUDQO=YLxaVwsWEAUdrk_EKcNG94Xr5+N+kzBtw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186678>

Ramkumar Ramachandra wrote:

> The motivation is unclear: lazy afternoon? :P

Perhaps he was reading the list and after noticing a few patches in
the same vein, realized that this test script could be made easier to
read, too.

[...]
> Martin von Zweigbergk wrote:

>> + =C2=A0 =C2=A0 =C2=A0 echo First > A &&
>> + =C2=A0 =C2=A0 =C2=A0 git update-index --add A &&
>> + =C2=A0 =C2=A0 =C2=A0 git commit -m "Add A." &&
>
> Style nit: >[^ ] is prevalent FWIW.

At first it wasn't clear to me what you meant here.  Was it that
quoted text in an email should start with a non-space character, like
a tab?

=46inally I caught on that you mean that redirection operators tend to
be flush against the filename they are redirecting to.

[...]
>> + =C2=A0 =C2=A0 =C2=A0 test ! -d .git/rebase-apply
>> +'
>
> While at it, why not change this "test ! -d" to
> "test_path_is_missing"?

Sounds like a useful hint.  The benefits are that it would catch
failures that make .git/rebase-apply into an ordinary file, and more
useful output from "sh t3401-* -v -i" when the test fails.  The
main downside I can think of is that the test script would not run
against versions of the test harness before v1.7.3.3~5^2~1 (test-lib:
user-friendly alternatives to test [-d|-f|-e], 2010-08-10).

The patch looks good to me, too.  Thanks, both.

Sincerely,
Jonathan
