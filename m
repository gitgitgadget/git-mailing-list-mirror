From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 5/5] help: respect new common command grouping
Date: Tue, 19 May 2015 11:20:03 -0700
Message-ID: <xmqq617o8m5o.fsf@gitster.dls.corp.google.com>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431976697-26288-6-git-send-email-sebastien.guimmara@gmail.com>
	<xmqqr3qda7kx.fsf@gitster.dls.corp.google.com>
	<20150519004356.GA12854@flurp.local>
	<xmqq1tica6rk.fsf@gitster.dls.corp.google.com>
	<CAPig+cS15yzwbcdb-yLH5QiMoxa0utmaJaDDz=W9WfWd+PL37A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 19 20:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yum7h-0001to-AU
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 20:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbbESSUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 14:20:08 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36689 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbESSUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 14:20:06 -0400
Received: by iepj10 with SMTP id j10so20560750iep.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6nF0XULgoMTIq7MEM/OQx3JwaGsQZOoXlqkjezJQIqA=;
        b=bezBjZbxombTxsYBjTV7ITmDefrg4TLG1RaCIvobrldGUFkkqKefjXJE8W+Ef/KTaH
         eHMwjnpJTp3OidybrdRUo10YMEKAYMuY7pRmjK7WdCDEFZ8s2UFV2Dx4kdLJe7HbxRzg
         xUxMvZGOLklE2rP/6OxViamOHSk0DGjvivXDJrF8xkb1PX4a6H1zMA9Pq+KS3FkNVXWE
         ThSz/FSfgSbsFtlyrSULT15W0QARtFJ5CSLBCOMu0j9LC1suuakoZQnTTc+LfQ6OjpYV
         NajS4Q8lyi64B2clIh4U0s0sRQeZV8L8H1H2ZalGWJdDS0Au74nxJJYvdUq1QmgZSmsV
         ab6w==
X-Received: by 10.107.135.35 with SMTP id j35mr37694138iod.91.1432059605627;
        Tue, 19 May 2015 11:20:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id ot6sm8361576igb.11.2015.05.19.11.20.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 11:20:04 -0700 (PDT)
In-Reply-To: <CAPig+cS15yzwbcdb-yLH5QiMoxa0utmaJaDDz=W9WfWd+PL37A@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 19 May 2015 12:35:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269384>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, May 19, 2015 at 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> The awk script restricts itself to POSIX, and I did test it on Linux,
>>> Mac OS X, and FreeBSD, so it seems pretty portable.
>>
>> I was worried more about some people only having gawk while others
>> with mawk and yet others nawk, etc., without having one of them
>> under the canonical name "awk".  It's nothing what
>>
>>     $ make AWK=mawk
>>
>> or its config.mak equivalent cannot fix, but still bothers me a bit.
>
> In that case, perhaps we should go with the Perl version, which, given
> that more people (these days) are familiar with Perl than awk, is less
> likely to be a maintenance burden.

As long as we all can agree that the long-term direction we want to
go in is to remove dependency on awk, that's fine by me.

That means a small awk scriptlets in t/ and elsewhere need to be
rethought, though.

Thanks.
