From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/2] t/lib-http/apache.conf: load mod_unixd module in
 apache 2.4
Date: Thu, 25 Feb 2016 15:43:42 -0800
Message-ID: <CA+P7+xpBtzQ6vd-aTqqrcBVwjXi2UKunnMacrPCHSKiQbX0BuA@mail.gmail.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
 <20160225220045.GA10267@sigill.intra.peff.net> <xmqqbn74mlco.fsf@gitster.mtv.corp.google.com>
 <xmqq37sgml9f.fsf@gitster.mtv.corp.google.com> <CA+P7+xrtkgAv3oNwSvO1hfSAz_VDNGSa4GQWWSPDnZrZdsDokg@mail.gmail.com>
 <CAPc5daUEqb2xuJFGj2xCPn-uqJ5XDcpP7VmiZr0VjZQ48m=ELw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:44:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5Zp-00051x-VP
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbcBYXoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:44:05 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34568 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcBYXoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:44:04 -0500
Received: by mail-ig0-f170.google.com with SMTP id g6so26950632igt.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jld58Sod4C+HI9gquRgtC/Sa1fJkvVempPq/EHHGOds=;
        b=eD3eOx+0uSkJsGc9zWbgMrzhyUytiQtj0dSXqCR8zltW1Glk1jEJWuXWVK93lTeQdc
         bg9wyCPrI3h1CeEsNw+KJKluayNleBDMeNWyfbvAnF2wPagWWw58B0WKVH0Jo9zX5IBl
         KUf4fHX69Ai5gztkwAwBsn1p+8YOCm5U5t7NrfrJvcQMqrUVwcg61tH7V7tJbkUV9IvA
         +c59eFh9HPryGkWmfXLl1d/7nBSsdKFxk7CEUOJNOuO25sHZ23GgNf30LY2SNOfGhv0X
         Sly/VC2TKnSlWtZdqFLaK5RaKmB8+reFLShGbIGkmvbLdKeGIjqEG0fo0Zcq6Gl1TKXi
         wqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jld58Sod4C+HI9gquRgtC/Sa1fJkvVempPq/EHHGOds=;
        b=VIvm1E+No+8CDA+qkSX+e5oKWRigwe1c4ePWVCClBow4s698Pqn+sQ+YbP+UtudUMK
         /lfHoNf49kLHiwcWj7qm4WWraJ59/D3IwUcsAa5EmKMEL3Dckuii/VgHpBa0+wVj6XlP
         cVH9qXzN/wR+G2F3y3XiOb0Eb7QaoQoIuW9+LKIetqq/rsGro8OezybOkFo9ykfdZXcm
         rKUwS3mr0vCLhzNbp9cxADhIq2j6vI/VOWRNU4aBmYlR5jHCd/44i6OmFySFX/msxEUm
         Mlw4T9BPYu43ipXbubBdbmQ/yvA7xUuw5uvTe107FHGAHCTojouygL3A+Bqcky6eg6CZ
         iCUg==
X-Gm-Message-State: AG10YOQYrKpzc7P+fsQZmf+5a1kGf9TrpXnc337+uwwOrHPeeGlEE9m0EoH0v1gAyYTbNdjrRHojsoPDng0+6w==
X-Received: by 10.50.142.103 with SMTP id rv7mr1394378igb.35.1456443841857;
 Thu, 25 Feb 2016 15:44:01 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 25 Feb 2016 15:43:42 -0800 (PST)
In-Reply-To: <CAPc5daUEqb2xuJFGj2xCPn-uqJ5XDcpP7VmiZr0VjZQ48m=ELw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287496>

On Thu, Feb 25, 2016 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Actually, let's wait a bit to avoid unnecessary conflicts between topics.
> sb/submodule-fetch-nontip changes the way how these calls to "clean env"
> helper function are made.

Ya there will be some superficial conflicts with some of Stefan's work.

Regards,
Jake
