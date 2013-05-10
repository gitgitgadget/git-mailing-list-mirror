From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] transport-helper: fix remote helper namespace regression
Date: Fri, 10 May 2013 15:36:16 -0500
Message-ID: <CAMP44s2QHd7b2t654hnMw_xca0OJKjUjEgP2yU4PUe-w4z-zBg@mail.gmail.com>
References: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
	<1368187710-4434-3-git-send-email-felipe.contreras@gmail.com>
	<7vsj1uzijo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 22:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uau3I-0000md-K9
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 22:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab3EJUgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 16:36:18 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:52054 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab3EJUgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 16:36:17 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so1027385wiv.1
        for <git@vger.kernel.org>; Fri, 10 May 2013 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=/L41mjgbGosWMV6rSATx2eUzUQQVq6EjgZmxdMpno2Y=;
        b=eOyGys0asU5HsreKDu9Fgfyh6pvvvyOE26JEB8lCeEShpYwJhDpTtDhgkosnUswoz6
         /aOjipPTYeXfZbUmWvtZb5F1jX0x4f1rqbRkv2754GG6FJ1Q2AfJ58B/ABuGPWi/Y277
         LHrh08s4z3DnZnNhKaFoBYmRbTBSafmH8H8ueAdioOBPH47Tii6pQ4b77FFMyp+IZM4K
         sBCAgj2G1u4uKxooRSjJScWhFqYRUpL3dD7+kYdVOEcZy2g4FahSkGvRpc0hTfVtgeo9
         NJcFb/0usvc6W7Ed80L6HHpdrGJVO5DyqcQ/PpRk5S/QfRxw5jp+ByEFKoHR8VTe3XCS
         1iEg==
X-Received: by 10.180.83.199 with SMTP id s7mr6145696wiy.19.1368218176450;
 Fri, 10 May 2013 13:36:16 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Fri, 10 May 2013 13:36:16 -0700 (PDT)
In-Reply-To: <7vsj1uzijo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223905>

On Fri, May 10, 2013 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +test_expect_success 'push update refs failure' '
>> +     (cd local &&
>> +     git checkout update &&
>> +     echo "update fail" >>file &&
>> +     git commit -a -m "update fail" &&
>> +     git rev-parse --verify testgit/origin/heads/update >expect &&
>> +     GIT_REMOTE_TESTGIT_PUSH_ERROR="non-fast forward" \
>> +     test_expect_code 1 git push origin update &&
>
> This is not portable

Why not? Other parts of this script run commands with environment
variables like this.

-- 
Felipe Contreras
