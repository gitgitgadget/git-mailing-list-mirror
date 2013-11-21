From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Thu, 21 Nov 2013 21:19:25 +0100
Message-ID: <CAP8UFD2S1HUDYLbmEGFqLcBFExuB0h7=gqwsQ0qjpMSc+YaXog@mail.gmail.com>
References: <20131120203350.GA31139@kitenet.net>
	<20131120213348.GA29004@sigill.intra.peff.net>
	<20131120222805.GC26468@kitenet.net>
	<20131121114157.GA7171@sigill.intra.peff.net>
	<20131121160426.GA21843@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Thu Nov 21 21:19:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjaip-0006VI-8s
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab3KUUT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:19:28 -0500
Received: from mail-vb0-f47.google.com ([209.85.212.47]:57765 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab3KUUT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:19:27 -0500
Received: by mail-vb0-f47.google.com with SMTP id x11so201562vbb.6
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 12:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fecYiJFOYK1piSiXmxW1FKfXmNMHzYuUlB0TemMRWbE=;
        b=vPsfEJtPI5GEzpLs0eyjHGd0tVLlJ+cfdf4cH6FpCTRMv1Om2Lvkilqf551xwO8xia
         kxHwWHQrVnwf3kOaA7HTv1kiwxx1+Ps1Gd9g+FlwvZuctVe+hTfXXk1ecn+lTfoanBXI
         e5EZpydL3E6STMKReA1Hr9xmQG6Vwq0DAvGPPDSMTCwt+jD2hibM9k291lycJc1EtssJ
         U76p+k0yc8feZvsn7L5v5KDQNIdhXSLSXtXjAC0eTcF1khB+dml2VF3RhL2kROIYzN08
         jPgpjYEORy5rxZVWVhxn/c/Olifj6zV/USkk1fFmj8WiB3ANbXG1atwYgmfR1FpctKxv
         q4yQ==
X-Received: by 10.220.174.200 with SMTP id u8mr7508869vcz.6.1385065165622;
 Thu, 21 Nov 2013 12:19:25 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Thu, 21 Nov 2013 12:19:25 -0800 (PST)
In-Reply-To: <20131121160426.GA21843@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238140>

On Thu, Nov 21, 2013 at 5:04 PM, Joey Hess <joey@kitenet.net> wrote:
>
> BTW, I've also seen git cat-file --batch report wrong sizes for objects,
> sometimes without crashing. This is particularly problimatic because if
> the object size is wrong, it's very hard to detect the actual end of the
> object output in the batch mode stream.

Yeah, I think it might report wrong size in case of replaced objects
for example.
I looked at that following Junio's comment about the
sha1_object_info() API, which,
unlike read_sha1_file() API, does not interact with the "replace" mechanism:

http://thread.gmane.org/gmane.comp.version-control.git/234023/

I started to work on a patch about this but didn't take the time to
finish and post it.

Thanks,
Christian.
