From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strtoul_ui: actually report error in case of negative input
Date: Tue, 15 Sep 2015 18:17:03 -0700
Message-ID: <xmqqsi6ftb74.fsf@gitster.mtv.corp.google.com>
References: <1442181636-27821-1-git-send-email-max@max630.net>
	<vpqr3m1seap.fsf@anie.imag.fr> <20150914202647.GA7806@wheezy.local>
	<vpq4miwfa78.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 16 03:17:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc1LT-0004Ps-JE
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 03:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbbIPBRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 21:17:07 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33584 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbbIPBRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 21:17:05 -0400
Received: by pacex6 with SMTP id ex6so192399540pac.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 18:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fASBMpiol0eaNnSEO1WXLDfUzElo2hDJ+qrpz0xZZMw=;
        b=XxqiRJcnKZsUX6slUb91W16p7JadoIFP+J/wya/XeJYeixUkL4V2yd14ohNEpG8bRC
         Sx2fRTWpu4mAF1HYX4Vm0dTsB2/lCSFPRhr1LdOFL59uUqtke6mvwGq/vmiGrZ5BIZj/
         i8d0SMEXU3e5flrgLLrsjBtQ80YolEe5OMzjeAXcA4N1xITJb3x3c3539lWMVGnvlzHg
         pnySPaD8R8aeDOWdfZUO5KU1eEFNM8PhbByE1H23eBzYXRoqnhfwsCu+n21Vaz5WYgaR
         ZJ/4+gpxWQhvcC4XwxTIZWnSB7l5q8/Dpg+34XRsJ+1fF6E0uuht0TaIHhrVECNG0muL
         o9hA==
X-Received: by 10.68.194.73 with SMTP id hu9mr54862070pbc.146.1442366225369;
        Tue, 15 Sep 2015 18:17:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id gx11sm24281490pbd.82.2015.09.15.18.17.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 18:17:04 -0700 (PDT)
In-Reply-To: <vpq4miwfa78.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	15 Sep 2015 08:50:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277991>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Not just the return type (which is the error status), but also the type
> of the result argument indeed. It's not clear to me whether this is
> intentional (09f2825 (git-grep: don't use sscanf, 2007-03-12) introduced
> it, the commit message doesn't help). I first read strtoul_ui as
> "strtoul with a better UI (user interface)", but maybe the name was
> meant to say "a fuction that uses strtoul and returns an ui (unsigned
> int)".

Just for this part.  Yes, ui does not mean user interface but "we
are grabbing an unsigned int and as its internal implementation we
happen to use strtoul" is where the name comes from.

> I went through the thread quickly, my understanding is that there were
> more work to do, but no objection to merging.

Yes, there were some in-flight topics that interfered with it and
the topic quickly went stale without getting rerolled.  There wasn't
any fundamental issue with the topic itself.
