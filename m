From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test for '!' handling in rev-parse's named commits
Date: Thu, 04 Jun 2015 10:09:21 -0700
Message-ID: <xmqqy4jzv1ry.fsf@gitster.dls.corp.google.com>
References: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
	<1433364854-30088-2-git-send-email-wmpalmer@gmail.com>
	<xmqqbngwwjbd.fsf@gitster.dls.corp.google.com>
	<CAAKF_uYrjBsVY8YOmRtMU8jB5rA57r+-N_KboqwWL3YRRqeKAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:09:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Ye8-0006gM-Ff
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbFDRJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:09:27 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33138 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbbFDRJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:09:24 -0400
Received: by igbpi8 with SMTP id pi8so20312529igb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NmcXCEmyizA8hb5V+J1HROPr4MLMsQVonzC2JT4nsz4=;
        b=SJ7zh+Jttw9CpB9/Z4e1gde1fO2XwTrI37V7mQlIZYB9UubjFxTez6nphMSFL6V0eh
         zlpCGUkqD7Kf2TZ+DiSn9gb1cbulQAVMgpPONcwd3j7CnsV2jO4cWom9mVOebXBeGuSB
         S3eOnTW+8EKP0aB1A86sfyvaRPBDsJkdN3j6N9PORVZ5MF5IxJl4tEjX2Bse7rONFt0K
         DP4fAxOnCoaFhOETpALe83lWYj7QBvd+rD4l8oOKDw3xkljw03QcbkSLHiRwVOdA0093
         BaHPgij0QR1pQ9ilDwW7qHjUcwZ3I4P9UdAGPyp5TaiieJm0vUMnAOtN9Qk8AWfZcE6y
         U1cA==
X-Received: by 10.50.56.104 with SMTP id z8mr5098781igp.45.1433437763770;
        Thu, 04 Jun 2015 10:09:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id 191sm1559543iof.18.2015.06.04.10.09.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 10:09:23 -0700 (PDT)
In-Reply-To: <CAAKF_uYrjBsVY8YOmRtMU8jB5rA57r+-N_KboqwWL3YRRqeKAg@mail.gmail.com>
	(Will Palmer's message of "Wed, 3 Jun 2015 23:44:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270784>

Will Palmer <wmpalmer@gmail.com> writes:

> What I'm thinking now is that "@^{/foo}" can be thought of as a
> potential "shorthand-form" of what could be "@^{/!(m=foo)}", in which
> case "@^{/!-foo}" could similarly be thought of as a potential
> shorthand-form of what could be "@^{/!(m-foo)}".

Ah, our messages crossed, it seems.  Yes, I think we are on the same
page, and it is sensible to think of "/!-string" as a short-hand for
the more complete syntax that uses descriptive word, not mnemonic,
e.g. "/!(unmatch=string)", that the old thread envisioned.

I think it is OK (and probably preferrable) to start with only
"/!-string" without the long-hand, as we do not know how multiple
long-hand instructions should interact with each other.

Thanks.
