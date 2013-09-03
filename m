From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v3 8/8] update-ref: add test cases covering --stdin signature
Date: Tue, 03 Sep 2013 08:15:53 -0400
Message-ID: <5225D2F9.8000908@kitware.com>
References: <cover.1377885441.git.brad.king@kitware.com> <cover.1378142795.git.brad.king@kitware.com> <9457f5c046a0fb420f4fd730c7b02c2a75ee7e0d.1378142796.git.brad.king@kitware.com> <CAPig+cRZFAaa1WVUa9V3jC9Oiy+ucSvyRAc0jdgwQASmhZm6eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 14:17:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGpYL-0001pd-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 14:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759832Ab3ICMRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 08:17:46 -0400
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:37746 "HELO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752353Ab3ICMRp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Sep 2013 08:17:45 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]) (using TLSv1) by na3sys009aob135.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiXTaL1ci0Kgp3XF+/2znhRloeJAkA3c@postini.com; Tue, 03 Sep 2013 05:17:45 PDT
Received: by mail-oa0-f48.google.com with SMTP id o17so6458233oag.21
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 05:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=G/01rsH0gKQ/5nzEuQ5RA0+igE0Pbfc+8vSLW6GJ0KI=;
        b=Ch71i1FHN9o8GIY5TV1c38WtxAKFtp0gONTAJ7whxzklJf0xNahxdX7iwNU4Gl5jz7
         e66V1jQ2asokzYfBMhPaTuXbwd2b1ds0HjaAOeLPbDtFMY9h/I1fnWLcFOGfejkwB6T/
         e0toOWVzUwb7eQ3d2jZBOS6AySmhTLW4qA2SYGKLgLPdhTwtL+CixscQ6okuFnbPqN4A
         pJrxuNnU6oVDerx0tqtx1YFbAlb/wRpQcvF0ekHyKzAYCF61PGI0ZzeZF+ZzbwXnCW84
         fmchBsxB+ydm7UKpfP6vBRxfqV/wK62xF5Ak5FJc6N2Ceoa9xE+ffU6Nc31VXqD2Hirz
         Lqhg==
X-Gm-Message-State: ALoCoQmXWhPeJTaKICR6R3n4PdgBmTpRF0UybQpEztVe3fBca6g0j9J+0ytQyw1Tu1EsPuj+LSm5Y/Bho5OXwINtmaPlEwDy4P4Qp+E9Q+Wr4Kjs/W0PWMPiGYhDexJ4Z1FGAh1EFAl1slNVUZd4IPnHXC3OUk1BFQ==
X-Received: by 10.60.102.237 with SMTP id fr13mr20086265oeb.20.1378210664218;
        Tue, 03 Sep 2013 05:17:44 -0700 (PDT)
X-Received: by 10.60.102.237 with SMTP id fr13mr20086256oeb.20.1378210664132;
        Tue, 03 Sep 2013 05:17:44 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id d3sm18827659oek.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 05:17:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <CAPig+cRZFAaa1WVUa9V3jC9Oiy+ucSvyRAc0jdgwQASmhZm6eA@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233721>

On 09/03/2013 04:16 AM, Eric Sunshine wrote:
> When you decomposed the monolithic test from v1 into individual tests,
> you dropped a couple cases ("fatal: unknown option'" and "fatal:
> unterminated single-quote"). Was this intentional?

Yes.  The v3 patch 7 changed the set of error messages to be covered.

> The leading '-' on '-EOF' allows you to indent the content of the
> heredoc and the terminating EOF, which makes the test read nicely:

Very nice.  Fixed for next iteration.

Thanks,
-Brad
