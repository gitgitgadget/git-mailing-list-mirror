From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 18 Mar 2015 17:15:10 -0400
Message-ID: <CAPig+cTaQAnWoz7=v9tOPZoeE3LTV+H6KD_tAzmOXi3Tjay_WA@mail.gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-4-git-send-email-pyokagan@gmail.com>
	<vpq3852dzry.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:15:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLJ7-0002Kn-2V
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbbCRVPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:15:12 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:33157 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbbCRVPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 17:15:11 -0400
Received: by yhpt93 with SMTP id t93so19560423yhp.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NbFetL19w6bffjdTUJXyyMe+WQA5z2Q2iSnnqoIrFVg=;
        b=hCbpr2U9FsGLUzdwrvgtSsBMx3dDTpQTyV0MCl+VDxjygxy78RHSgXc8iDzVJ9lzMm
         sqaYbOfFp/464+mJB3Lc7FBPAmEW3ciQ4eu3QZKgl0tDuVY8nBaLa5t6PXanuXdWnSFA
         6fOawEdpBgMlN40s4NdKZz2fOCx28wozGUF62iETweYbRHSxyTV9k8PQFgqdT4qS0uE8
         nKNQiN3pdPfFGzB/zZFg1XplrRT/jWvYXh5eqLK0r24I62VG5WHwO8JqmUBPQ3Xy2Pm1
         LiBg1HlENhFBnzWk51BtY4PJ0yk+MZ9pS/LRWDowKalIF182pM0JyQIn9rBBKOeLb0fo
         Laww==
X-Received: by 10.170.194.7 with SMTP id l7mr50092892yke.91.1426713310991;
 Wed, 18 Mar 2015 14:15:10 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Wed, 18 Mar 2015 14:15:10 -0700 (PDT)
In-Reply-To: <vpq3852dzry.fsf@anie.imag.fr>
X-Google-Sender-Auth: 4fh-tJJEgVSiabJ9nvYefsZvpbc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265759>

On Wed, Mar 18, 2015 at 12:41 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Similarly to the "merge doc and code", I personally prefer seeing code
> and tests in the same patch.

In this case, the patch introducing the tests is already quite long
and intricate, almost to the point of being a burden to review.
Combining the patches would likely push it over the edge. I'd elect to
keep them separate.

> Actually, my preference goes for a first patch that introduces the tests
> with test_expect_failure for things that are not yet implemented (and
> you can check that tests do not pass yet before you code), and then the
> patch introducing the feature doing
>
> -test_expect_failure
> +test_expect_success
>
> which documents quite clearly and concisely that you just made the
> feature work.

I also tend to favor adding "failure" tests which are flipped to
"success" when appropriate, however, as this is an entirely new
feature, this approach may be unsuitable (and perhaps overkill).
Generally speaking, these new tests don't really make sense without
the feature; and, more specifically, due to their nature, several of
them will pass even without the feature implemented. As such, the
current patch organization seems reasonable.
