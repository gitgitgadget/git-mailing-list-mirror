From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Sun, 04 Oct 2015 10:21:55 -0700
Message-ID: <xmqqsi5q1rd8.fsf@gitster.mtv.corp.google.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-2-git-send-email-Karthik.188@gmail.com>
	<vpq8u7kb89o.fsf@grenoble-inp.fr>
	<xmqqpp0v3mzo.fsf@gitster.mtv.corp.google.com>
	<vpqr3lb6oy7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 04 19:22:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zimz4-0002Sm-7I
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 19:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbbJDRV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 13:21:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36113 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbbJDRV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 13:21:57 -0400
Received: by pablk4 with SMTP id lk4so151958981pab.3
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xWr58RwmSD82hAWnNDqRKkpSOmmUqiyK/wuiut/xo/Q=;
        b=xY2SztGk8kd+Ji6kRxx7HplEZQrB7G6NQ5NWvlJOPA2F+r3x+QwaORI8ZIm4AkdGH9
         ZiOp6csm8Pi2dAoy2cSLFhra6ZjYT6iHHkDTLHf/qDPrPWiNOGKEygXvfgreI9ABTGAu
         RzSkazpmAn9kgeGtH5fYqPYyi4Q2kQDZM3Ug073478mritWrQbGwIXbJ/ySrVLxD0ql9
         Ag77knjXTK5vyQw8dzSFHjYzbcoAWcCsDlhXhbdCDx9dZhHnb7iOTrNZUAYg580m4MzH
         Vy/VBapofdpTGhF/Q+VTvK6zD6xj/Ju8Sw/KKj8ibIkTK0T2Qo8nD3d2vaEVt/Gq27sd
         qX+A==
X-Received: by 10.66.147.104 with SMTP id tj8mr34070298pab.125.1443979316701;
        Sun, 04 Oct 2015 10:21:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id hq8sm23125870pad.35.2015.10.04.10.21.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 10:21:55 -0700 (PDT)
In-Reply-To: <vpqr3lb6oy7.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Sun, 04 Oct 2015 10:02:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279005>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I found all the suggestions very good, except that the distinction
>> between "expands to" and "is printed" bothers me a bit, as they want
>> to mean exactly the same thing (imagine this whole thing were inside
>> another %(if)...%(then)).
>
> True. Then let me try again:
>
> Implement %(if), %(then) and %(else) atoms. Used as
> %(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
> format string between %(if) and %(then) expands to an empty string, or
> to only whitespaces, then the whole %(if)...%(end) expands to the string
> following %(then). Otherwise, it expands to the string following
> %(else), if any.

Nice.  Thanks.
