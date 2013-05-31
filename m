From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 5/7] add tests for rebasing merged history
Date: Thu, 30 May 2013 22:42:46 -0700
Message-ID: <CANiSa6gK99W=x-RXmgxqZ+UFJbps2nu0S_RApD2hAiQU2wgnQg@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-6-git-send-email-martinvonz@gmail.com>
	<51A5B4E1.3070205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 31 07:42:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiI76-0003O4-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 07:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980Ab3EaFmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 01:42:49 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:46934 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3EaFms (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 01:42:48 -0400
Received: by mail-bk0-f45.google.com with SMTP id je10so70105bkc.18
        for <git@vger.kernel.org>; Thu, 30 May 2013 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kENL/rWInVLEtplb0mRRdlBCG3HO20xUEbcOSnDyqXM=;
        b=ZKSA9rpVu9GzG2LMp5UGU65Qftd3n8W975znqxjgEPUDr/JKFa4u42En94aEzIrfzq
         vE8EdMSG5rwXO3Ys4e3Awe7ITW8IANGx2Rk1ueo8iFM1J6f3Qplk1KgONuXRhckah9TH
         Ox7WfNxHoJAwCAyZlaragZSImoCFQHeT+jgyPaiwkD7MlsCmry56RGorWNCTKuI4I22A
         4Nq9GkMb/DlI//oizZ6Q+8U4kx3ABpsecEiVg4s1iUiFDvmLDaloHtgMcvg9I/qMV7Le
         EXYgIx6+Ei5Yh1+ZvYiTomX0ZN3DMom7ApFAQKxTDPnDmjeU0ISwhoBJF6PRQBJV6m4y
         FhXA==
X-Received: by 10.205.21.10 with SMTP id qq10mr2766300bkb.133.1369978966679;
 Thu, 30 May 2013 22:42:46 -0700 (PDT)
Received: by 10.205.122.139 with HTTP; Thu, 30 May 2013 22:42:46 -0700 (PDT)
In-Reply-To: <51A5B4E1.3070205@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226047>

On Wed, May 29, 2013 at 12:57 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
>> +# a---b-----------c
>> +#      \           \
>> +#       d-------e   \
>> +#        \       \   \
>> +#         n---o---w---v
>> +#              \
>> +#               z
>
>> +#TODO: make all flavors of rebase use --topo-order
>> +test_run_rebase success 'e n o' ''
>> +test_run_rebase success 'e n o' -m
>> +test_run_rebase success 'n o e' -i
>
> As test_commit offers predictable timestamps, I think you can work around
> this discrepancy by generating commits n and o before e. (That is not a
> solution--just a workaround that depends on the current
> implementation--because the order in which parents of a merge are listed
> is unspecified.)

I actually liked it as documentation of the current inconsistency and
with an explicit TODO.

I have addressed the remainder of your comments in this and the next
message. Thanks again.
