From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Thu, 8 Oct 2015 21:39:19 +0530
Message-ID: <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com> <vpqr3l5zgst.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 08 18:09:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkDlS-00080n-RA
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 18:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934455AbbJHQJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 12:09:51 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35474 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757611AbbJHQJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 12:09:50 -0400
Received: by vkao3 with SMTP id o3so34973140vka.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RMknNPtVYouqGwvcmeaU+rYzGXea+T3X+WcKbwLxRn8=;
        b=jBnWEdnKgZnJa0WEzPlmgA3tLRZqUSRiXLeGo/xP7QRMfKUUrUwAXEejshQAhd/eHK
         RB407lSU83ChRfXcb7JxMEox/d4gGivAzVsTgaJdBtZoV0Gcdbqiwf6RokVcLxOMuruk
         TnIjeEdSx+EC1PKYEYhEYnjoB3bmP3oUgwYzotsTdXFcOFwl7qZyjFu3t+ZCda4QYYXo
         RSPkpSgFX2O6vGiYoQtz6WFa5nr107IU79UL7m2R6EM7EHi5qRUFXmB/Ftpv4INmpnVq
         MPnO07kkqVsZ4psgGLP6MXRHJ1uD9QSexEQBwo9/feY8hO4JgKwpBPWtfRJeoOQWKBTU
         oNyQ==
X-Received: by 10.31.173.136 with SMTP id w130mr5718745vke.72.1444320589187;
 Thu, 08 Oct 2015 09:09:49 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Thu, 8 Oct 2015 09:09:19 -0700 (PDT)
In-Reply-To: <vpqr3l5zgst.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279243>

On Thu, Oct 8, 2015 at 5:57 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> +                             unsigned int nobracket = 0;
>> +
>> +                             if (!strcmp(valp, ",nobracket"))
>> +                                     nobracket = 1;
>
> The code to parse comma-separated values is different here and
> elsewhere. I'd rather have the same code (possibly factored into a
> helper function), both to get consistent behavior (you're not allowing
> %(upstream:nobracket,track) for example, right?) and consistent code.
>

Speaking of comma-separated values, the only other place we use that is
in the align atom. Also I find this very specific to get a function out of.
Somehow I think this is the simplest way to go about this.

-- 
Regards,
Karthik Nayak
