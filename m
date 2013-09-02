From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 3/8] refs: factor update_ref steps into helpers
Date: Mon, 02 Sep 2013 13:19:25 -0400
Message-ID: <5224C89D.3050002@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <d327c12d90c0c2500e51fb07c06f516f94438ff0.1377885441.git.brad.king@kitware.com> <xmqqvc2lul9g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 19:21:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGXoW-0000DX-0r
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757123Ab3IBRVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:21:16 -0400
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:35187 "HELO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755333Ab3IBRVP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 13:21:15 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]) (using TLSv1) by na3sys009aob137.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiTJCjjAN/T5TmhCeE3eLQovkVHaWqr6@postini.com; Mon, 02 Sep 2013 10:21:15 PDT
Received: by mail-oa0-f42.google.com with SMTP id n12so1528881oag.15
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 10:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7ECrRviUZ659GNHoy0wUN24JMJL6+DaLN5AxGJ1pRjg=;
        b=k4JKn/pW8Tux8sF8/1lZXdMiv+u0aMDF7U+83FA0du2fGCVP0R9kdS/iwI3GfSkb0z
         vphJAbT6oOtVuc6pHl0SSemUjXS6y28xKO3jd+LMa8LXmkY8T9yR+KVxn6/kMx4YqEpI
         ibVfhMUI0W4lDHTc9+PB2A2oLmy3IwuKajP5URh9ajvbMWz9fhxPwBfR0y2KxUzRzGzC
         5KOyd2MD2tB60+MdC+9aOzuyGiB5J5eyfcwIQ8tPEo5o8ZEaBuWCW/nmjYbFR48k19+J
         LwUjJjPr6EOnE6RlVHyQFZbalgerYOEnahtc6vDj1bYMq+TeAwe2gsE5PMikL4N4xo0O
         icow==
X-Gm-Message-State: ALoCoQkO3gStNfp0zEPxmHuXE0Ctj6n2haa11YbFY1pfZsgpVH20S6S1/pdyqwtF11je4ZxyRXjh6Xt8Xn7y1ClBDn1NhRIN2g+bbLofTFpxI5zavyjQixH6eaBB/ujlp/zM5UAFWgpH5wRxxzpBPUg/BbPhFveqsw==
X-Received: by 10.60.102.66 with SMTP id fm2mr18175074oeb.21.1378142474344;
        Mon, 02 Sep 2013 10:21:14 -0700 (PDT)
X-Received: by 10.60.102.66 with SMTP id fm2mr18175067oeb.21.1378142474275;
        Mon, 02 Sep 2013 10:21:14 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id d3sm14604849oek.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 10:21:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqvc2lul9g.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233637>

On 09/01/2013 02:08 AM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
>>  	static struct ref_lock *lock;
> 
> Not the fault of this patch, as the original update_ref() had it
> this way, but it is not necessary to keep the value of this variable
> across invocations.  Let's drop "static" from here, and also the
> corresponding variable in the new update_ref().

Fixed in next revision.

Thanks,
-Brad
