From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Thu, 13 Aug 2015 20:43:02 +0530
Message-ID: <CAOLa=ZQSVCgcuUQFsF2Mq-m+wS8im3t4Z3PSEgoAHcV0gGuvPA@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <1438693282-15516-1-git-send-email-Karthik.188@gmail.com> <xmqqpp2tspb6.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZRRU4htKgB46g0FAGVEGGFN+1N1250AOYJh7H5apv=RJQ@mail.gmail.com> <CAOLa=ZQic2=z6bJ0Ykhn2x8mE86w4HwBrJP7pb_RaemGKCZzmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 17:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPuCG-0006vI-Vx
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 17:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbbHMPNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 11:13:32 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33286 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbHMPNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 11:13:32 -0400
Received: by oio137 with SMTP id 137so28270426oio.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=57OwyMaG//D5qlTtV3fYc15JSMVU+oOnzrPNaet0SMo=;
        b=IQ046YWahM99sBD0OHf4deSax0m6vSwpF/LdrFSiv5D4ZtA3pQEavNMWx1dmo5P+MX
         e78+an2WsrH0pYNBGfM807YEgmJxwfOEQWn3hh2ZuqSZ9GagAwIEao+RWhJ09HM1JMPI
         cbLARr8GRtdLDcC/qiNUZHM7tenB+6uwtEg1IteazFwrgDf7s5Y3X+0ckhDnAitfLFrb
         YP6M3tsRSk7bSe4qEjtLxMEKkIYhWXUtc8CxWdcdP3qCDqBdXnzTGYj7nIrXYam1OqzZ
         Mq50tkF3nBHkR6K66lca6sVQ5M0QeVrDOgdTUi5B4bcJtu+XbRr5V32v1PFO2c28biqt
         wQPA==
X-Received: by 10.202.200.75 with SMTP id y72mr33994278oif.111.1439478811713;
 Thu, 13 Aug 2015 08:13:31 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 13 Aug 2015 08:13:02 -0700 (PDT)
In-Reply-To: <CAOLa=ZQic2=z6bJ0Ykhn2x8mE86w4HwBrJP7pb_RaemGKCZzmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275848>

On Thu, Aug 13, 2015 at 5:05 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Thu, Aug 13, 2015 at 4:21 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> This was taken from branch.c, I thought of using an enum instead but that
>> would again require most of branch.c, hence it's been carried over
>> without changing
>> I'm thinking of changing it, any suggestions?
>>
>
> What I was thinking was of having:
>
> #define FILTER_REFS_INCLUDE_BROKEN 0x1
> #define FILTER_REFS_TAGS 0x2
> #define FILTER_REFS_BRANCHES 0x4
> #define FILTER_REFS_REMOTES 0x8
> #define FILTER_REFS_DETACHED_HEAD 0x16
>
> and using these for showing ref kind also instead of separately
> having 'REF_DETACHED_HEAD' and so on.
>

Something like this:
https://github.com/KarthikNayak/git/commit/0ec5381420dcdfe7c62000b56168e2842d5d0063

-- 
Regards,
Karthik Nayak
