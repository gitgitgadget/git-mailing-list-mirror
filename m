From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned integer
Date: Mon, 10 Aug 2009 13:12:02 +0200
Message-ID: <40aa078e0908100412l3c2afd1bnda9b10aaf1de383f@mail.gmail.com>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
	 <7v3a81a13z.fsf@alter.siamese.dyndns.org>
	 <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>
	 <200908100724.53345.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ryan Flynn <parseerror@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 13:12:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaSnx-00067l-5x
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 13:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbZHJLMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 07:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbZHJLMD
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 07:12:03 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:51416 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbZHJLMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 07:12:01 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1119368qwh.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MvfEH3SI5QHrBStquMQCkc14Ql9MOKMYe1HYJVeKuIQ=;
        b=BvHYbdKNRcWEdxgXQBUatcfyEueW2tTAcCUG35qjRe+ydKwFNJFl5gkJ3yeu2ZxdsP
         UmmNSEvrIyw66XS0ntWuZvVn5rl7jUZVRo3Sx1bmE/Wnhix0HdK1Ti4u+SjCFWV5FC68
         6gJclya4XS+VnbH3ELqyNh61NF43vl41vvDjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RalJy6NBlHVkICtBPqqKpmf/WPKrYofjjrz3xHadhB7eP0/YV4lCXKc08pLDVI8lbu
         40Yv2qiXtWRehssbdvOZ/y7iIPZxbCLufynXmkTk+RXojp0aejvqpyu0t4f+LMGWMpTD
         r1EjERRThhm9oPGf6oxo2oJPbbRYCTfnQHQD0=
Received: by 10.224.11.1 with SMTP id r1mr2943338qar.174.1249902722174; Mon, 
	10 Aug 2009 04:12:02 -0700 (PDT)
In-Reply-To: <200908100724.53345.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125433>

On Mon, Aug 10, 2009 at 7:24 AM, Christian
Couder<chriscool@tuxfamily.org> wrote:
>> log10() appears to be C99, but can be emulated on earlier C-versions by
>> doing #define log10(x) (log(x) / log(10.0))
>
> That would mean linking with -lm?

I guess so. Are we currently trying to avoid linking to the math-parts of libc?

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
