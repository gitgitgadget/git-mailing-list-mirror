From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] upload-pack: prepare to extend allow-tip-sha1-in-want
Date: Fri, 22 May 2015 17:53:28 -0700
Message-ID: <xmqqa8wwdshj.fsf@gitster.dls.corp.google.com>
References: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
	<1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
	<1432239819-21794-2-git-send-email-fredrik.medley@gmail.com>
	<xmqqpp5th9dy.fsf@gitster.dls.corp.google.com>
	<CABA5-zm4E71DV4hMw1Tifn-gqE4LzDDRzuo4vRL848bo_V5LLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 02:53:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvxh6-00072i-Ek
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 02:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250AbbEWAxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 20:53:31 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35011 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316AbbEWAxa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 20:53:30 -0400
Received: by iesa3 with SMTP id a3so42350480ies.2
        for <git@vger.kernel.org>; Fri, 22 May 2015 17:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fsiVIzHVwmzj4Q+boPLwLBg1fcn4iKC+FG9/h2kWvwU=;
        b=tmQvYdLPQO0LBPGPpTRi1ecdVTISl+UX0WrqJ39WtihF6AcXGatF0c2Tyr54/KBSzq
         CKQfjLhHPlY87fabtwkD51n2lNOBBidp9cxcDpjWOUlIVm58N2Dt9eCrYfQEaWJehQM8
         bo3ufUQvkPUtqheswad4zkE8udgUrKMUAV5msNPT9Jdhr1fMvoKr7dRvPOzSySiK6abr
         p+eB9x7FJDqulxopBwU3xLfLN5/AucDEtU9NXj5ApYPxNczjzH+cX+5pSWEkgwmKnEj7
         Abk4IlxUFriQsVGIpLqMol48D1StBqmUZ5p4B+G7+1LOMzp+rTWTDT4rrgb2ZM4ct72C
         57qA==
X-Received: by 10.107.18.222 with SMTP id 91mr13888269ios.34.1432342410226;
        Fri, 22 May 2015 17:53:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id 7sm3034609iol.43.2015.05.22.17.53.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 17:53:29 -0700 (PDT)
In-Reply-To: <CABA5-zm4E71DV4hMw1Tifn-gqE4LzDDRzuo4vRL848bo_V5LLA@mail.gmail.com>
	(Fredrik Medley's message of "Sat, 23 May 2015 01:47:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269784>

Fredrik Medley <fredrik.medley@gmail.com> writes:

>>> +#define ALLOW_TIP_SHA1       01
>>> +static int allow_unadvertised_object_request;
>>
>> It is better to use "unsigned int" for these bit masks, as we are
>> not interested in the top-most bit getting special-cased by using a
>> signed type.  I'll amend this (and the one in upload-pack.c) while
>> applying, so no need to resend only to correct these two, unless you
>> have other reasons to reroll.
>
> Sounds like a good idea to change. Please amend it while applying.

Alright, will do.

Thanks.
