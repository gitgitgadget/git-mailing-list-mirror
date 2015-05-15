From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Fri, 15 May 2015 19:41:39 +0800
Message-ID: <CACRoPnSbekLANNiGOyxN70TCUd1c=wcrU_6Gfew5pp5EBpSEsA@mail.gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
	<xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
	<CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
	<xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 13:41:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtDzu-0001rs-73
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 13:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934362AbbEOLlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 07:41:42 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:33761 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933981AbbEOLll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 07:41:41 -0400
Received: by lagr1 with SMTP id r1so33587901lag.0
        for <git@vger.kernel.org>; Fri, 15 May 2015 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QE4BhZlfvoG7mjAWpFc9Xk+lne6MjOeo8bK/G1s/XlY=;
        b=IiS+9GLPMIZaHybqHec61UjoUueOxIemng7mcBqFOSqeKvgmBTFOeHDaE00JSR5cQn
         CN+iN45E5LoSUdL6pQQBKazRAmQyMDYr2gxdWilbyY/OMQ+J481tFR1WgdlPnBITxyBH
         zAfhdNa0gpOcUm9DBxK7gtguBlF5z/b3Y2PFlaxnkOu5HqyDl9bt1GiKOrDp+wt4aBLz
         Ia3ojlOMQLT7XvWtcqefc+k0srA+jVWwQi8g01Gu8b6/cIs/UYsiVgK0DP5eCphDcGCm
         dxgNvNw+fy0ah4ebCERC5TSAg8X14ofAc3JDeYFFJxNo016k8ORC9N+dGGRntdKIfM2c
         u67A==
X-Received: by 10.112.205.69 with SMTP id le5mr6863005lbc.65.1431690099843;
 Fri, 15 May 2015 04:41:39 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 15 May 2015 04:41:39 -0700 (PDT)
In-Reply-To: <xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269140>

Hi Junio,

On Fri, May 15, 2015 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Change that 'verbose test' line to
>
>         verbose test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
>
> i.e. losing the double-quotes around $().

Noted and fixed. Interesting quirk though :-).

> By the way, thanks for a fine demonstration that the 'verbose test'
> is not very useful.
>
> This output
>
>> command failed:  'test' '1' '=' '       1'

Personally, I find that the quoting provided by "verbose" helps make
it clear that it's a whitespace issue, which might be a bit harder to
spot with the output of set -x I think.

Other than that, I'm also convinced that "verbose" doesn't really
offer much. Will remove in the re-roll.

Thanks,
Paul
