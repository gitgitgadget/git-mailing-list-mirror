From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] t5528-push-default.sh: add helper functions
Date: Mon, 23 Apr 2012 09:42:59 -0700
Message-ID: <xmqqzka2jt64.fsf@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqipgqlass.fsf@junio.mtv.corp.google.com>
	<vpqobqil9ml.fsf@bauges.imag.fr>
	<xmqq8vhml8z7.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:43:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMMM0-0007hj-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab2DWQnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:43:01 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:64387 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2DWQnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:43:00 -0400
Received: by yenq2 with SMTP id q2so1353038yen.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 09:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=+FUxhshwvePuFUnZ4fYXl9IEyzp4FIaJ/eOUfU42E+k=;
        b=L11gIkAcjbNCEaAY3F1WW+RdYtntFhFaFfbp948VTrA33J9PQGRbcPH7MSFDlUgpMH
         cMO8Gz6aI71gZ8yfZJ6CVI0TtIVXxQYxRO3FUCb6WGTPp57AtNX0G0yUaHnJqj3RscfS
         Jc4wcgwBaOrI3i1gRgUwxMv2D92727WRidu8qnW+dfGoqj2fNLa4KwV9mTEAtKUzDg14
         p8ie0Kf1N4FcsQKJPEuY4pX2HG88hlAUHG/6jIbvaKJqw2QgqHdELT/JyerIoF9dm999
         coWrPMTPl3JkxjvgoAVI4ZbWW91ZLAci5jNp0FfX4jWFAWPtv49/X1vaYDDIsaQceWj2
         zV/A==
Received: by 10.236.155.102 with SMTP id i66mr20337234yhk.9.1335199380290;
        Mon, 23 Apr 2012 09:43:00 -0700 (PDT)
Received: by 10.236.155.102 with SMTP id i66mr20337213yhk.9.1335199380203;
        Mon, 23 Apr 2012 09:43:00 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id y36si76205yhg.2.2012.04.23.09.43.00
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 09:43:00 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 1CDFB10004D;
	Mon, 23 Apr 2012 09:43:00 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id BEADBE120A; Mon, 23 Apr 2012 09:42:59 -0700 (PDT)
In-Reply-To: <xmqq8vhml8z7.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Apr 2012 09:16:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlxEb4HjLFFFHHhTv8OZVNsYCjJG9ESeOFRoVlZveuHUL2TzsqSI/u2Lsa/Ehp544VqjLI1xBJ7gyVUeBJMwx7ZRCCx4r3tVN1+eynM0S7a4E5tkvAt0iuZHmSzQeun5cO4wLsecwokC3xxn1zwb/C6jTa9yt797YKQ5QOAoMK0Z++LwVo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196146>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> ... and we can use --all not master here, right?
>>
>> Actually, we can even use --all everywhere. And then, we don't even need
>> the second argument, and we can simplify greatly the function:
>
> That did cross my mind but I suspected that the reason to have the
> argument was because you would want to use the helper also to test
> 'matching' case where you want to make sure ones that the pusher does
> not have are left alone.

In any case, here is the summary of my comments in patch form (I am not
squashing them myself).

-- >8 --
Subject: [PATCH 1/3] fixup! push: introduce new push.default mode "simple"

compilation fix; this should be static and needs type.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7a845a8..913ac7a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -76,7 +76,7 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
 	return remote->url_nr;
 }
 
-NORETURN die_push_simple(struct branch *branch, struct remote *remote) {
+static NORETURN int die_push_simple(struct branch *branch, struct remote *remote) {
 	/*
 	 * There's no point in using shorten_unambiguous_ref here,
 	 * as the ambiguity would be on the remote side, not what
-- 
1.7.10.376.g4eb25
