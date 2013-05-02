From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 21:33:21 -0500
Message-ID: <CAMP44s0zbb7GO2oFZ5LhSu3Xu_SMZcit5Yzqk+E=4XoO9Ju5Bw@mail.gmail.com>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4hq7fjy.fsf@alter.siamese.dyndns.org>
	<CAMP44s16X8c_5GgW=ZcA9wrd=oHAiVDZFWxqiGmysaUJckZ5wQ@mail.gmail.com>
	<7vsj264am4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0OysW1Rnc+Dk1R697zhtV+ubCMfDa+aWizOaHEcLbsJA@mail.gmail.com>
	<7v4nem488y.fsf@alter.siamese.dyndns.org>
	<CAMP44s0TtwBL=0MxU2C8QUkgA61KauPTcctH9TzQ_DdTaxh0eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 04:33:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXjL1-0008Re-8N
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 04:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759298Ab3EBCdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 22:33:24 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:43648 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221Ab3EBCdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 22:33:23 -0400
Received: by mail-we0-f179.google.com with SMTP id t9so95180wey.10
        for <git@vger.kernel.org>; Wed, 01 May 2013 19:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6h0MU0PQnwIWUobX1PphYJWK3FQ9O+QbRi6uZLszTEA=;
        b=p2g2DtMr8XCecBpjiBgbSq4JQYWopCI+bPQLgdAqyN/wrIH0WbxxTunK1VY4MtqMDw
         XQSw7X0b+0KzhemGf8qqhscwEUoSltpHVTThHsfS2Pru45eMrfzOqCORGbRX1Kjb/2Dm
         88R0vfBsf/nQcMRKIi+QLOKjdRj0IpaQcA6qi0tjTvAX67Z7Cp4AdGP7rZXTOYZBhdgD
         SlMs16NANvQeLSuK8Dnm9/2g06ce/23nMkpBgBpJMwZAHdRfug058iM9I9IQzMcqaod7
         s4oJ5BcTOnARwmXKCrWHWffJKkV23TAEs59Yni+oZbVPAG5ZzJBhGeA1gBi6coH/rhlw
         OshA==
X-Received: by 10.180.198.49 with SMTP id iz17mr5305631wic.19.1367462001533;
 Wed, 01 May 2013 19:33:21 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Wed, 1 May 2013 19:33:21 -0700 (PDT)
In-Reply-To: <CAMP44s0TtwBL=0MxU2C8QUkgA61KauPTcctH9TzQ_DdTaxh0eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223174>

On Wed, May 1, 2013 at 6:14 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 1, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> It is just the "strip this, strip that" explanation, which is not
>> technically correct, does _not_ have to be our justification for
>> picking '@' as a short-hand for HEAD.
>
> The point is that it follows from @something -> @.

So my proposal is:

---
Typing 'HEAD' is tedious, especially when we can use '@' instead.

The reason for choosing '@' is that it follows naturally from the
ref@op syntax (e.g. HEAD@{u}), except we have no ref, and no
operation, and when we don't have those, it makes sens to assume
'HEAD'.

After this patch, we can use 'git show @~1', and all that goody goodness.

Until now '@' was a valid ref name, but it conflicts with this idea, so lets
make it invalid. Probably very few people, if any, used this symbolic ref.
---

-- 
Felipe Contreras
