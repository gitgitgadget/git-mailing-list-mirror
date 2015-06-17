From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Wed, 17 Jun 2015 12:25:58 -0700
Message-ID: <xmqqh9q66ss9.fsf@gitster.dls.corp.google.com>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
	<CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
	<CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:26:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5IyL-000548-Fu
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbbFQT0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:26:02 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36385 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbbFQT0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:26:00 -0400
Received: by iecrd14 with SMTP id rd14so40742685iec.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=l6gUv+ER1pd+QJBPekg7bs/Zkq0Z/QhDIhseNeFgByA=;
        b=cmEZBVcNFGl2ad18jbiNyQm1whx1JxV2KOLWD7EmCollPU9hMvyqrsL1SGGKKgrTIX
         JWiarwHGIBtQANHoBOtzZMx55n8q/uNkPDmWtDfvIzjyn3GvMIvrrbFZsX2GR1SmLCQZ
         02voGCybOngDug9FQn7O3ZXoN/n0/PdiaBO2pjKPOXmYmHl97s3TKE2aG5AEfpNdBTjK
         L5zdp16+nKXHf1M2+dmKmIlMdgQflJBt1ITt791dLLPQwg7fxcukr4y7UztBHDy5ryh+
         t3JE3SruOMmNIUFg3ctj3MfUouQhzvE0GVGPy+TRy5bcaukrYz1i+fEIXwnVfeh1y3mc
         AHuQ==
X-Received: by 10.42.161.74 with SMTP id s10mr8787881icx.5.1434569160006;
        Wed, 17 Jun 2015 12:26:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id j4sm12517729igo.0.2015.06.17.12.25.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 12:25:59 -0700 (PDT)
In-Reply-To: <CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 17 Jun 2015 10:58:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271890>

Stefan Beller <sbeller@google.com> writes:

>> Just make strbuf_slopbuf[] large enough to keep Coverity happy. If it's
>> happy, we'll have cleaner defect list
>
> It's down 31 defects, roughly 10% of all things coverity detected as
> problematic.
> YAY!

I actually think this is too ugly to live.  If coverity is buggy and
unusable, why aren't we raising that issue to them?
