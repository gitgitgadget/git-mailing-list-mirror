From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Mon, 15 Jun 2015 09:08:13 -0700
Message-ID: <xmqq1thdar9u.fsf@gitster.dls.corp.google.com>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqy4jq2rjr.fsf@anie.imag.fr>
	<1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<835646176.485512.1434310200681.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqoakh74fw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 15 18:08:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Wvx-00072s-DO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 18:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbbFOQIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 12:08:19 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36420 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918AbbFOQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 12:08:17 -0400
Received: by iecrd14 with SMTP id rd14so34202162iec.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=D2O/5B1hQEup/HCUBwe2JOqO6ux8YpV51hcUGe3hxfw=;
        b=oZuBz17fa4nshoeMTLkEFpJ+KMyN4NYtwof8/LRTSKnybXieFN9ZWGTZP1BMrxMq8+
         77iMJ3N1HoVPSaouJnzs1Aj+MfdXt0kdhUO8BMq8vGUn5lyxjV5XTrQR8ntPIFUJee5c
         +C8Q1wOLP/T1oCuqaikmtNp22uEnyIUH8aATqOJPDjek5K3nak2NXBS8IlZnUy72Tm5P
         0PHfbGK9tp2B20AsulyOWXBc+swO+gswp889En/XF1KBS9kQl8Ej9+tUyH5ePHRNbo3B
         EdoCLtQBD4g01eXLH3qyHHlAp7f9XRBPxJT6RFOxH2Wn2M3kqZlQOdkX/U+SJl9uzdRz
         hETg==
X-Received: by 10.107.169.234 with SMTP id f103mr3002448ioj.42.1434384496846;
        Mon, 15 Jun 2015 09:08:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id j192sm9118940ioe.27.2015.06.15.09.08.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 09:08:14 -0700 (PDT)
In-Reply-To: <vpqoakh74fw.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	15 Jun 2015 10:37:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271687>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I would say terms_defined is OK even if only the first patches get
> merged. The reason why you need this variable is because you need to
> know whether the terms have been defined or not, and to me that's the
> most important.

Well said.  Thanks.

>
> I'd suggest something like this:
>
> # terms_defined is 0 when the user did not define the terms explicitely

s/citely/citly/;

> # yet. This is the case when running 'git bisect start bad_rev good_rev'
> # before we see an explicit reference to a term.
> terms_defined=0
>
> Then PATCH 7/7 can add a mention of 'git bisect terms' just in the
> comment.
