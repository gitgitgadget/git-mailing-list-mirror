From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 1/7] push: return reject reasons via a mask
Date: Mon, 26 Nov 2012 21:00:14 -0600
Message-ID: <CAEUsAPaPPZPR3VM1w=nFhdRG_enKwRpiW2X29z0731VdEMezMg@mail.gmail.com>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
	<1353644515-17349-2-git-send-email-chris@rorvick.com>
	<7vobikryrc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 04:00:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdBPW-00059m-OM
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 04:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053Ab2K0DAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 22:00:17 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52617 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732Ab2K0DAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 22:00:16 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so6276651lbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 19:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=xMXcvVrWINw0d/JbRNqobrVoFqJ9Q9Pzd6WPz/rQEUc=;
        b=tg4nSNACxyKboh7aWSjWjK4BiQiMH2x9ujHeWF5yGzNa/tDwhPj+R8RU0E4fv08iZz
         G8xdpG5LvGnRQQ0SaGlRiwvIaLux4WkDI2oMHpyejvzX45zj5voBcyzaDUuY8ZzmjZ1H
         89+Px/KJuIBgtydMwJDjy0vTytONO8vBpaCoyMfqrpuWMjZvO6WbfZrIchAddZl8yAVS
         onrZqx7ryw7PQjjvIx2QaEZ7s5nBSUg5/eh5TBa1/aJfgU6OguJf8yVUr5i+07Q/kAGx
         WDYsNqKWDZ4OtgIuEPAR711YzYoqvfgXJhe9z32nEOWuxEsHYS2BUDt1kwb/crehA65B
         +P2Q==
Received: by 10.152.109.145 with SMTP id hs17mr13298225lab.5.1353985214166;
 Mon, 26 Nov 2012 19:00:14 -0800 (PST)
Received: by 10.114.13.2 with HTTP; Mon, 26 Nov 2012 19:00:14 -0800 (PST)
In-Reply-To: <7vobikryrc.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: lGpfC-UKhGybNp0tWPBrpIuMUCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210527>

On Mon, Nov 26, 2012 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Rorvick <chris@rorvick.com> writes:
>
>> Pass all rejection reasons back from transport_push().  The logic is
>> simpler and more flexible with regard to providing useful feedback.
>>
>> Signed-off-by: Chris Rorvick <chris@rorvick.com>
>> ---
>
> In any case, naming it as "reject_mask" is like calling a counter as
> "counter_int".  It is more important to name it after its purpose
> than after its type

Agreed.

> and because this is to record the reasons why
> the push was rejected, "rejection_reason" might be a better name for
> it.

Yes, that is better for all the reasons you mention.  I will fix this up.
