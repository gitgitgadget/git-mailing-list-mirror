From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 03/83] builtin/apply: avoid parameter shadowing 'linenr' global
Date: Wed, 27 Apr 2016 19:07:39 +0200
Message-ID: <CAP8UFD09L3i0RjghK7O8xQOK-_PfKZesUC_piUukrBOMDOJxbg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-4-git-send-email-chriscool@tuxfamily.org>
	<xmqqtwin9fus.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:08:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSwT-0007Cy-9K
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 19:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbcD0RHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 13:07:43 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37399 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbcD0RHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 13:07:40 -0400
Received: by mail-wm0-f50.google.com with SMTP id a17so24846789wme.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=L8nBp+OQOGEhy3Frw2lUqC0yU2neCsiljpGQvy7GcaE=;
        b=h+57ilw6Li69pz6cf3B2r5N3xcfPJWCWQCCL3LwF7BGAYfBJHuInR/VHWjOdGUb2Ye
         WG3af6ZREpCYTpuviRjqvkeyVWggzujXsBmJH0nXLqArn9EtoiVDFKED2da5FqGlg+sQ
         Wye/slWeU4RqjAfU19LVQpuxIpqSTcaeLKF5JhBsdSEJd0tsLGUBK9kalHbzovLteBLV
         f/dApS2bQqXqGTwAMHouJ3tls1WItgeznjqecG4L+R54dlpIwF4W0jBhOl75GOMlYMMk
         2XUu1kD44RVXR7GsPcFV+1OnWJuaSYfTXlM6R8O5N0vHVfadpt+mrVMDbQLpoDwtdILn
         N6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=L8nBp+OQOGEhy3Frw2lUqC0yU2neCsiljpGQvy7GcaE=;
        b=W25nN/zGCo9QMJD+yZl2Ck50KW+J1bRllahZDZZF8/Tx9xD+vcKF+XfTPltuacy0TJ
         /NQX8S/LqnGazyJcpeZPRug7fGpnJG71/M9h33iUBL4+KMY6+ZTEY5/OHI4RH2fXKyRm
         RUP+mNr39/tFqyI61GyoLSSkc4ziVoOQxz2tvgtQHKi6+33xohZMd9+NU4p5lMWCCRLk
         XL2aviMA6760qN0h5vFURWgYwDR/aEd+T1+eJkqtSekQKYNZEGXxxTGUdenmwcSY8dCn
         fcWycpT3UoIsqcFyh2VR/LKPLgG/ETr81XdCmmB+k/aP+so6QiEbe682oLyCXOVvl+6s
         aDGA==
X-Gm-Message-State: AOPr4FUtQzicoWUVwLjuN2SfiMQq4NWqaQYsLbFdJVOCvf5mDtcbDb3ob55rQNbkvskb9kocwUWnQ4PYlxVw2g==
X-Received: by 10.194.235.39 with SMTP id uj7mr10344876wjc.78.1461776859206;
 Wed, 27 Apr 2016 10:07:39 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 27 Apr 2016 10:07:39 -0700 (PDT)
In-Reply-To: <xmqqtwin9fus.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292774>

On Wed, Apr 27, 2016 at 6:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think 02/83 that renamed the global-to-be-moved-to-state to
> state_p_value was brilliant, and this should follow suit; you would
> be moving linenr into the state eventually in later steps, right?

Yeah, ok, I will do the same thing to this patch as I did to 02/83.

Thanks.
