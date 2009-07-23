From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v4] grep: Add --max-depth option.
Date: Wed, 22 Jul 2009 23:11:33 -0700
Message-ID: <4A67FF15.7080703@gmail.com>
References: <1248285135-9033-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 08:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTrWs-0003zw-UK
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 08:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbZGWGLi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2009 02:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbZGWGLi
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 02:11:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:40664 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZGWGLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 02:11:37 -0400
Received: by rv-out-0506.google.com with SMTP id f6so201959rvb.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=3DwA+Eci/scOM6Ms1U+FkrxssyQI32thHlfeQ0A3IeA=;
        b=tB+RD8B5eLs6vQc8Zzl6WG32W52tfZwG+UrsZfFRRgtJp1gOyNugfh0RcDZee/GIgI
         riQjedVzem/6HD+Yd3Vfq3H6JRaCGXyzIMtsVT85A4P6sFvMK5tfMPkXiSO1bGLuMTZy
         3MD0s9nEGM17GhCsY5U/4GZ7Bc7XCwyXHXh4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=qaYnTHTjv1VeO0Jbpx1oz5KICpwXKjpvLM9CH9onSWLpOLa955r2sFRcBP9ZJKyb59
         EGbDFOZhOQwaIDbF8lsxcEMy8yQuY7mHtCH8nqYqZ+H3LKDER76HPk+YtNW4bL5t/Ail
         Ml3EGFZLaFgpOzdRCXICbQI9CPymiV4Y3UMrU=
Received: by 10.140.133.7 with SMTP id g7mr1161964rvd.169.1248329497154;
        Wed, 22 Jul 2009 23:11:37 -0700 (PDT)
Received: from ?10.10.0.3? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id g22sm3885391rvb.58.2009.07.22.23.11.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 23:11:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <1248285135-9033-1-git-send-email-michal.kiedrowicz@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123847>

This looks good now. Just one minor point but I don't think it requires
a resend.

Micha=C5=82 Kiedrowicz wrote:
>
> +		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, "depth",
> +			"descend at most <depth> levels", PARSE_OPT_NONEG,
> +			NULL, 1 },

This NULL and 1 are not needed unless you're using PARSE_OPT_OPTARG. I
think this last line can be safely removed.
