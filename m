From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: What is the default refspec for fetch?
Date: Sat, 08 Nov 2014 15:35:25 +0100
Message-ID: <545E2A2D.2040205@gmail.com>
References: <CAENte7inZ5fm2SzNPq=HNPKnPco9tM4T_es5Dphnpbia-uiLdg@mail.gmail.com> <20141108105221.GA20750@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 15:35:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn779-00010W-5C
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 15:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbaKHOfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 09:35:39 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48480 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaKHOfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 09:35:39 -0500
Received: by mail-wi0-f179.google.com with SMTP id h11so6827704wiw.6
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HPIDdqnFwlf8IBS6QcGkiVDCcta055YVT9jycqcpenQ=;
        b=H7T/Je8bJd3tWTGcCq0KT/f1jbvOiOxj7MTz3uwu2mClWvYMQ6ZQwWaGB4iGlG/LRM
         uiVaGhJ66VF8fWj2olCkFhTSfKUXauoWsJYrIYZcOrQBmq8ZfDn5ND4xKPIm9A0Ku/YR
         ENb6fxszBT/l/VohSs7DsuRbw4pBTQEwvtkavcFmbTFrozfEDC0TJL2L51Sh0qQ0+VT+
         7qwa8lFrNLiRzisZPXAab2RxChc/ShjB27atGZnZwVAf+Q+n3CHuEOjazaLI+nZodiZ8
         Vy1kB1Iij3qwAdD1766uB/qswC3TIsQ6jMpWfbQaop7zwkXTkLorbnSK4mGlEd9Usoy/
         qWQg==
X-Received: by 10.180.39.8 with SMTP id l8mr14715180wik.19.1415457338039;
        Sat, 08 Nov 2014 06:35:38 -0800 (PST)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id 10sm15660933wjs.21.2014.11.08.06.35.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Nov 2014 06:35:37 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20141108105221.GA20750@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 2014-11-08 11:52, Jeff King pisze:
> On Fri, Nov 07, 2014 at 04:31:08PM +0100, Christian Halstrick wrote:
>
>> In a repo where no remote.<name>.fetch config parameter is set what
>> should a "git fetch" do? My experiments let me think it's
>> "HEAD:FETCH_HEAD". Right?
>
> Basically, yes. We always write FETCH_HEAD, regardless of the refspec=
=2E
> We choose "HEAD" if no other refspec was provided. So it is really mo=
re
> like
>
>    git fetch $remote HEAD
>
> This is what makes one-off bare-url pulls work, like:
>
>    git pull git://...
>
> It runs fetch under the hood, which writes into FETCH_HEAD, and then =
we
> merge that.

Actually FETCH_HEAD consists of multiple lines, one per ref...
but only top ref is merged.

--=20
Jakub Nar=C4=99bski
