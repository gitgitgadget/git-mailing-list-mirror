From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/8] revert/cherry-pick: add --quiet option
Date: Wed, 29 May 2013 08:28:40 -0500
Message-ID: <CAMP44s0M8dg_8ke3p1wJtnPrjdtH0L-D3ZgnPPCSKH0Mx0Z=GA@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-8-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=QyznWZt4sJCok9OZxjrdjtMTtpStA8LHdCCbn0Oi6TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgQs-0005Gv-PN
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759561Ab3E2N2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:28:46 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:53026 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3E2N2p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:28:45 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so8510116lab.6
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YHjVjvBWBTv53DnjBBgtnudR1aGBc2xtpCGGoGyZMzc=;
        b=qRxHR5d185ZVYrORBu64FE6mAirEsDs1vMUjYyyTiP7QIfNvVsHCdqbjnjKFUyI/Nq
         NTm/UdrGxk4+LTTKr5Q4lPd7kxEOhTRcqTBVagUBx/unF1c9AIzjUsayTagqYkw4GU3g
         DY6aQLGHgTsDafU53sYvtdpur8ZqZsyQS7B1/Vzmg9wJcCALvart7ptRuvVufxfuXLSh
         h3JGTiH/FP/ufrLUPmiZSdcCK6PTAJKEorW5j4BEn1Pa0AV6StdlVl1tuEbgIkiwmyaz
         LdeNGQFdOy7O6WVArC5t5mSl/iB7I50SRk/GJi8kK7Llem4kOpsyCaiPD4C98X+OnuBY
         fSKw==
X-Received: by 10.152.2.233 with SMTP id 9mr1372028lax.34.1369834121047; Wed,
 29 May 2013 06:28:41 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 06:28:40 -0700 (PDT)
In-Reply-To: <CALkWK0=QyznWZt4sJCok9OZxjrdjtMTtpStA8LHdCCbn0Oi6TA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225816>

On Wed, May 29, 2013 at 7:33 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>         if (opts->skip_empty && is_index_unchanged() == 1) {
>> -               warning(_("skipping %s... %s"),
>> -                       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
>> -                       msg.subject);
>> +               if (!opts->quiet)
>> +                       warning(_("skipping %s... %s"),
>> +                               find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
>> +                               msg.subject);
>>                 goto leave;
>>         }
>
> All this trouble just to suppress the "skipping ..." message.  Do you
> see anything else --quiet can be used to suppress?

Did you miss the -q option passed to 'git commit'?

-- 
Felipe Contreras
