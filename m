From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] read_loose_refs(): treat NULL_SHA1 loose references as broken
Date: Wed, 03 Jun 2015 14:20:14 -0700
Message-ID: <xmqqmw0gwktt.fsf@gitster.dls.corp.google.com>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
	<eb79f7d96ec74445f7adf62757119273280e09c9.1433339279.git.mhagger@alum.mit.edu>
	<20150603140803.GA23901@peff.net>
	<xmqqr3pswrpc.fsf@gitster.dls.corp.google.com>
	<20150603201511.GA31157@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0G5J-0005x8-4C
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 23:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbbFCVUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 17:20:20 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36610 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084AbbFCVUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 17:20:17 -0400
Received: by ieclw1 with SMTP id lw1so23055696iec.3
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DzgWRk1Wz5uITtP175uLWI3dILItK2vxoJvaaPja+Bs=;
        b=BHwHneHUXNa6GEPlAvn/ECr9BYcQD0qiTa1piU/kisKUbyhA8Nh/Cuc1fto40FPsrY
         Zrr+IUfryo6xJWFcutMW3wA2HHckqQZmusgoX317iutHbIW6fpjVYaukUHTqGj4so8VY
         eebrQb3LDNZspuFcIEyZ2SELkavG3IiCtRzE5bYhSXSQcpZbURCVClknYyfncKuBYYcw
         SSkNfVid/cHuADzzKzfm/KJi5oY6TUpcWQB5GN4UF13GA1IEe+blP8aVoslD3CYQqyn2
         VqMJx0xr1w/RDilIEIPnSKWrSJBwxPe9eomOqasgUqbjXl4Skox7m9y1pQxoBLy0SVeR
         16XA==
X-Received: by 10.43.92.199 with SMTP id br7mr741221icc.43.1433366416293;
        Wed, 03 Jun 2015 14:20:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id m84sm12606606ioi.27.2015.06.03.14.20.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 14:20:15 -0700 (PDT)
In-Reply-To: <20150603201511.GA31157@peff.net> (Jeff King's message of "Wed, 3
	Jun 2015 16:15:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270739>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 03, 2015 at 11:51:43AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Wed, Jun 03, 2015 at 03:51:59PM +0200, Michael Haggerty wrote:
>> >
>> >> NULL_SHA1 is used to indicate of "invalid SHA-1" throughout our code
>> >
>> > s/of/an/ ?
>> 
>> Also possibly s/invalid SHA-1/invalid ref/?
>
> I thought it was trying to express that we use the null sha1 as a
> sentinel value throughout the code, no matter if the value came from a
> ref or otherwise.

Yeah, an invalid object name, not limited to refs, is correct.

Thanks.
