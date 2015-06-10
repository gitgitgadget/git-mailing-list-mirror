From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/19] pull: teach git pull about --rebase
Date: Wed, 10 Jun 2015 09:13:56 -0700
Message-ID: <xmqqk2vbmth7.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-16-git-send-email-pyokagan@gmail.com>
	<xmqqk2vcuy10.fsf@gitster.dls.corp.google.com>
	<CACRoPnR5shi800KZ_Do5V469ZgZYAzUZKy9mNYNNRPF6HFqs_w@mail.gmail.com>
	<xmqqmw07oc72.fsf@gitster.dls.corp.google.com>
	<CACRoPnSgVPVDTC=nY6FQHoVRPF1HZhRYXaKoQ1oJrJCoG1W8xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:14:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2idi-00016U-FP
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbbFJQOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:14:01 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36360 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbbFJQN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 12:13:59 -0400
Received: by igbpi8 with SMTP id pi8so39368132igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NdvN6hggyCPzdj6owVlvQ7Vv7bQpFwtowRYFdwT+XyI=;
        b=sbsdC4km77y82peUeOgFG4r4yFKI/8PyTKnWD98DPHb6Kn03Z624P1m1y/NijmZ16N
         TEXT3EJT1VHOUroMkk12RquRSBrx40AX+cqRcU+PL/FKozq7zxnDFQFI7VZJQEM/y/hw
         dwM1qJoYQC5HesCwHDKLdDYn5bPOKd+ghHRZHCXbIgqw4EYbkLdVd977ytBy4ipmenWO
         U+4+mPngxlsU73I0dY/xpXYhRogddfx9w3zVkb+5Wj9i7hiXSl/N3B9RGpzYkjCGJMNy
         JfJhqoGYj2pgC4P17OFoeXXWsS/LpuHOa66ui+Y12qhmljbm1d/phaIsP5/AauiXQUD9
         LRfA==
X-Received: by 10.43.19.131 with SMTP id qk3mr5773925icb.15.1433952839032;
        Wed, 10 Jun 2015 09:13:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id j5sm6284754ioo.8.2015.06.10.09.13.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 09:13:58 -0700 (PDT)
In-Reply-To: <CACRoPnSgVPVDTC=nY6FQHoVRPF1HZhRYXaKoQ1oJrJCoG1W8xg@mail.gmail.com>
	(Paul Tan's message of "Wed, 10 Jun 2015 23:35:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271318>

Paul Tan <pyokagan@gmail.com> writes:

> so it's more or less a direct translation of the shell script, and we
> can be sure it will have the same behavior. I'm definitely in favor of
> switching this to use remote_find_tracking(), the question is whether
> we want to do it in this patch or in a future patch on top.

Ah, OK.

I then agree that the topic should be a straight-forward literal
translation of the current scripted Porcelain.  Switching
implementation detail to share more code can and should come on top
with more careful consideration, as that step can change the
semantics by mistake.

Thanks.
