From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Wed, 01 Jul 2015 14:23:14 -0700
Message-ID: <xmqqr3or7et9.fsf@gitster.dls.corp.google.com>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
	<vpqk2ujoadw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 01 23:23:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAPTZ-0002XA-A3
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 23:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbbGAVXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 17:23:21 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33236 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbbGAVXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 17:23:19 -0400
Received: by igcur8 with SMTP id ur8so102732947igc.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hMC01MB+vbX6AVrBBnHbJSN7jvoOr+MYeKztLaFugiw=;
        b=Xv3McRwsMd4/w5G85UugJ/FczlCLdAgOMRSOzaNQtxMklAApVfjVaKOj4eRwS6skWL
         +V2ib4OuZXaPVcIMOKVOlvHeBVLBA/1bxFFOM+7zT8VGDd/zQy+SOYSg1OZSQinD4Jne
         txLjJNX+TikwzN390LJRdj5EAK/1W32jv8w1pVysImbb3IXN+UuEd2v5k1TV9Z2C28iy
         sz6/CoR9ToTldOIyzRym7zIQgaRVGBqBgeZbCXK7FxMQXZuNGJQwID79NVPz1mn2YMr0
         12n61HzafnQ9kE9dCWMG9A+7aSW5yQ4GT/o+qsqhUa7KXB2YxmtxOXh5IAiCBdSm7od1
         XZfg==
X-Received: by 10.50.142.9 with SMTP id rs9mr8487126igb.17.1435785798702;
        Wed, 01 Jul 2015 14:23:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id 137sm2287982ioo.29.2015.07.01.14.23.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 14:23:18 -0700 (PDT)
In-Reply-To: <vpqk2ujoadw.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	01 Jul 2015 23:06:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273206>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, we can do simpler: we still have the original line available,
> ...
>
> I took this (modulo s/line.len[0]/line.buf[0]/, and s/rtrim/trim/ to be
> robust to leading whitespace (not really important, but doesn't harm).

I'd prefer us to be more strict when we know we are reading our own
output; rtrim is sensible, as the log line has end-user subject
the end and the subject might have a trailing whitespace we want to
trim, but there is no valid reason to expect leading whitespace.

In any case, I wouldn't have much time during the remainder of the
day to requeue and/or comment; please check what I push out on 'pu'.

Thanks.
