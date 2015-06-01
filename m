From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH v4 1/8] for-each-ref: extract helper functions out of grab_single_ref()
Date: Mon, 01 Jun 2015 07:39:37 -0700
Message-ID: <xmqq1thva3x2.fsf@gitster.dls.corp.google.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-1-git-send-email-karthik.188@gmail.com>
	<xmqqvbf8abwi.fsf@gitster.dls.corp.google.com>
	<vpqvbf8jxbr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 16:39:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzQsT-0003v4-82
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 16:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbbFAOjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 10:39:41 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38718 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbFAOjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 10:39:39 -0400
Received: by igbjd9 with SMTP id jd9so63010874igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6Q80/ZIJe64C2TMQMm4CmhzL5hQyYjp4yIdtydTmPTU=;
        b=goMIfBc4Rr5yz2O2YHtIxMbS/JbLTxOZcsJ+G8ILtLsWB9DtKlitQE518cg8FtoMxp
         hvYk98WTPTcSCehdZbGzjsDpmDtkIX+BzKJ0ugkehI5bu/xWe1TscGxqLuzKGbKTVOot
         7BZk/rxcVXnPsQ19wuyNxX+foARLS4hwPIqoD79b8CV6la2ia/g1K3i/hJk0vuCMWO2o
         pEm6oBfiD3r87YwukMTxYclzO4r/NQds+wkWXwHPA8aB2twKsU+uTDw3Hwq54FtB6zvz
         yfYGJzKqd/Wz3MPJ8jFTbmyf9MO0zgbFp8463GAhcEkILamGAdmA3oCF+y33tTm0T9CI
         za/A==
X-Received: by 10.107.132.138 with SMTP id o10mr27474339ioi.52.1433169579032;
        Mon, 01 Jun 2015 07:39:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id z195sm10520679iod.33.2015.06.01.07.39.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 07:39:38 -0700 (PDT)
In-Reply-To: <vpqvbf8jxbr.fsf@anie.imag.fr> (Matthieu Moy's message of "Sun,
	31 May 2015 22:39:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270417>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Just match_refname may not carry all the semantics of the function,
> which matches a prefix up to the end of string, or up to a / (but you
> can't just be a prefix stopping in the middle of a word). To me, the
> "_as_path" helped understanding the overall behavior of the function.

Yeah, Karthik explained that the plan is to add different kinds of
matching later, and in that context _as_path is a good way to tell
them apart.

Thanks.
