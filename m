From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] transport-helper: check if the dry-run is supported
Date: Tue, 21 May 2013 16:14:12 -0500
Message-ID: <CAMP44s14ZBUYhxDkSwjoi+6JPx4whfQDhiq_4QfMteALsbuQ_Q@mail.gmail.com>
References: <1369099924-13763-1-git-send-email-felipe.contreras@gmail.com>
	<7vli78p920.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 23:14:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uett4-0005Vp-B4
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 23:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab3EUVOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 17:14:17 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:55959 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab3EUVOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 17:14:14 -0400
Received: by mail-la0-f46.google.com with SMTP id er20so1221857lab.5
        for <git@vger.kernel.org>; Tue, 21 May 2013 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/sQ2HB/n3CTzV2AbecC2r126DzjNgZP8eIyNond6Ww8=;
        b=fW/qySp8DcXwy7h4PyiJNKjtdnOX0cvAq4yqH5gc31QXbVRIxl5ltMMy0y/LPly9Z7
         feSuHxVlE5LSlc2/yg+DMOF//4elLH4A2tVLULflctqUmI32TeFUO8s0OpbYZLLLjMIq
         KJsxpsWKgFDC335saiaefCq9K8XwvB3XNG+xivcC1Ky65UNZuaWm1tX1u4SJ3aTR+Hpl
         yRSbAlmVwa9fbcNErOu2NI7XWCM5lXmaW2nQBeNP0Eb78OXtqM25tSpn/cX0Mqfs0v1e
         XjCHCe4cf3ItWxXYVfmO0IlwaKipOl2J1T+GIt5aXxDf2dN+vR/HcQojmb0qCg+dgXqb
         UHwQ==
X-Received: by 10.112.190.42 with SMTP id gn10mr612503lbc.82.1369170852504;
 Tue, 21 May 2013 14:14:12 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 14:14:12 -0700 (PDT)
In-Reply-To: <7vli78p920.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225079>

On Tue, May 21, 2013 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Certain remote-helpers (the ones with 'export') would try to push
>> regardless.
>>
>> Obviously this is not what the user wants.
>>
>> Also, add a check for the 'dry-run' option, so remote-helpers can
>> implement it.
>
> This sounds like a good thing to do.  Perhaps the refspec mapping
> can be handled the same way as a backend feature so that you do not
> have to unconditionally disable it in the other patch.

With my patch the remote helper doesn't need to know about the refspec
handling at all, it just works magically.

-- 
Felipe Contreras
