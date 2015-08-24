From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 15:34:12 -0700
Message-ID: <xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<vpqzj1hkc5q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:34:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU0K4-00075A-GP
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 00:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbbHXWec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 18:34:32 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35088 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbHXWeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 18:34:14 -0400
Received: by pdob1 with SMTP id b1so58279180pdo.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fJLcIx0f5WYEZvPioFIDO6VyWmXLYVznQQa8afGegQs=;
        b=XHXyy8e6sFEFunawfn7nYJ2jnS4r37AoSpRoMwxR2o+3nU9/wA19teoUQFUYZmZwXT
         b80KBor6peIL2submDzXauvcw6/SKaZNTMrhu5fAAybHAXc2Ay0YYKnWo/R4N7sfEngt
         Vqega6mGg7WC5HeWa5ivo9lPGaZvA823nF2b5qqwGNCImN3TBg/i3SS4pZIx4mz93ox6
         mialTFOrNhDuOxWShQTRjjN2r4J38Yxe5dB7QC1/PREvahpfiN5fMPaHrl07jI6u6ENA
         A00jnLPf326kzgCoZp4FikAYBp1IT7YpZ4DftqJ7V6YKABWErYdEKVAC2P3HwQy9nBBc
         Wm7A==
X-Received: by 10.70.140.139 with SMTP id rg11mr49762906pdb.34.1440455653534;
        Mon, 24 Aug 2015 15:34:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id fs13sm18584187pdb.29.2015.08.24.15.34.12
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 15:34:12 -0700 (PDT)
In-Reply-To: <vpqzj1hkc5q.fsf@anie.imag.fr> (Matthieu Moy's message of "Sun,
	23 Aug 2015 22:00:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276494>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 1997657..06d468e 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -133,7 +133,8 @@ align::
>>  	`<position>` is either left, right or middle and `<width>` is
>>  	the total length of the content with alignment. If the
>>  	contents length is more than the width then no alignment is
>> -	performed.
>> +	performed. If used with '--quote' everything in between %(align:..)
>> +	and %(end) is quoted.
>
> There's no --quote, there are --shell, --python, ... (well, actually, I
> would have prefered to have a single --quote=language option, but that's
> not how it is now).
>
> I had already commented on a preliminary version of this series
> off-list. I think all my previous comments have been taken into account.

Thanks, both.  I think this is pretty close to being satisfactory
;-)  There may probably be a handful of minor nits like the above
that need to be addressed, but I do not think I saw anything
glaringly wrong that makes the series unsalvageable.  It was a very
pleasant read.

It's almost there, and I am very happy to see how this and other
series evolved so far ;-)
