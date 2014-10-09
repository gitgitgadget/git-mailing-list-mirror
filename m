From: Brandon Turner <bt@brandonturner.net>
Subject: Re: [PATCH v4] completion: ignore chpwd_functions when cding on zsh
Date: Thu, 9 Oct 2014 17:30:22 -0500
Message-ID: <CAMUzdXkWNxW8Py6ATwtvqJ7s75dsP8vz6gMjk6tQa6gTGvcdWw@mail.gmail.com>
References: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
	<1412881298-64117-1-git-send-email-bt@brandonturner.net>
	<xmqqk34955we.fsf@gitster.dls.corp.google.com>
	<CAMUzdX=SmeEFmxd_LPPaB9qkwqXfkiC=CU7DnMf_gR=007xcbQ@mail.gmail.com>
	<xmqqbnpk6ggl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 00:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcME8-0000qW-65
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 00:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896AbaJIWaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 18:30:25 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:53091 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbaJIWaX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 18:30:23 -0400
Received: by mail-ig0-f171.google.com with SMTP id h15so499554igd.10
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brandonturner.net; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BV9POMywaSvPSLT6LbpiHCyeNI1z+wRQdCRm/HCXbPM=;
        b=Ou49tGSArP059hP25X6IfE9rlPYYZotqjj9jDUYtiUgXdOEB3ZeRLz9CWf+xUg5RBF
         FGoihXd3LG7+EjXbi4jdKXwS04/Sb6KrWUNGd7UL7Yvldy/VzskPFcNz+43chJyPHVj3
         q42X6Rw1Ju12SoA7GCkS85aZI0l3WhqN/x1cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BV9POMywaSvPSLT6LbpiHCyeNI1z+wRQdCRm/HCXbPM=;
        b=gy11vdrtLFmVxIr8MYeP7VZBTcow3s1I+B6FJ49lNo0KAW1UWFqz6/BTbk/+7iR70w
         bjK/IxRGoQIebutomAnOHWImPYNjkEANWNXu6QtQyN1faCdpNdMNBGEADDlAz7mg4Ue2
         PE7ZjS2D9tnnlbQCtMl2Q+cY6IJ9IAyefqG3KOnWVxHRH4JtIz3TIKOuWIsAqLrA7uja
         cAVfefKb4ZjH2Hl6wg873VDI4DqU0+R+1uzOUYlYGenfdV2YAPRciZdto61+JySY8677
         yjSykC2thW4bYvLW5CF4Mpc1WNbfwEaCRvgB6J9K/glRW5PLJP+pJhplIQigpNeiBY49
         V/OA==
X-Gm-Message-State: ALoCoQl+p/DiLl96BFled/mXEOnrkshL4lSJv8AGoPHdSIkrVVOa4aZULn9CAE6wdxHcCINyeoYK
X-Received: by 10.50.18.69 with SMTP id u5mr1304748igd.19.1412893823043; Thu,
 09 Oct 2014 15:30:23 -0700 (PDT)
Received: by 10.64.230.66 with HTTP; Thu, 9 Oct 2014 15:30:22 -0700 (PDT)
X-Originating-IP: [128.177.65.10]
In-Reply-To: <xmqqbnpk6ggl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 9, 2014 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Actually the patch was slightly wrong.  It did not quite matter as
> "cd ''" is a no-op, but "git -C '' cmd" is not that lenient (which
> may be something we may want to fix) and breaks t9902 by exposing
> an existing breakage in the callchain.
>
> Here is a replacement.

I did some more testing on this iteration as well - looks good. :-)
