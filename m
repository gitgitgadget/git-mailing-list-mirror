From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] send-email: drop misleading function prototype
Date: Mon, 1 Apr 2013 00:09:13 -0400
Message-ID: <CAPig+cTvtrtzLeZDPuxzomz055V4u+R9cR+M86oKsEzt8+5Mhw@mail.gmail.com>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
	<1364780442-6015-1-git-send-email-gitster@pobox.com>
	<1364780442-6015-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 06:09:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMW3z-0003k9-P9
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 06:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab3DAEJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 00:09:16 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:48617 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab3DAEJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 00:09:15 -0400
Received: by mail-la0-f54.google.com with SMTP id gw10so1815405lab.27
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=eBE4NneuuTt37EyakImMWWXq/cP48e5QxA3AvuC89Q4=;
        b=z6dlXescePbrcqZZRSxg1dOo0WPEIm49yJ6C2J2/980A/14NTd95tUNUHS+mI0fj2t
         wZQTCLoU9pg/S0XLz5FKiafMq9fpSD3hAl2OueKBBOTVUB2B6YMIFLIWivDzWuzU8bfL
         wsdO/AbYBv5GgMYWpAf3Cn26zGt9+a5jXfJ+F+fpE4baYKPbf2VBLnsnnMmxV+HKhaXp
         lx1iXpIgt9ohPAUQKuZYViQjOtTrBz1bp42owF708XIUdiluULjTHh4pEr4GiOF9aTcd
         cvSTzZRTJu7H9ED/YqCatoEAhWwMzSmpkdtL3FOWoYEiRcNswiEvBaJ9ElfmRLcSkjhd
         SxjA==
X-Received: by 10.152.47.242 with SMTP id g18mr4909082lan.42.1364789353584;
 Sun, 31 Mar 2013 21:09:13 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sun, 31 Mar 2013 21:09:13 -0700 (PDT)
In-Reply-To: <1364780442-6015-2-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: dRrSdUyG8cErZt-_OqfFpKYRwlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219667>

On Sun, Mar 31, 2013 at 9:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The subroutine check_file_rev_conflict() is called from two places,
> both of which expects to pass a single scaler variable and see if

s/scaler/scalar/g

(note the /g)

> that can be interpreted as a pathname or a revision name.  It is
> defined with a function prototype ($) to force a scaler context
> while evaluating the arguments at the calling site but it does not
> help the current calling sites.  The only effect it has is to hurt
> future calling sites that may want to build an argument list in an
> array variable and call it as check_file_rev_confict(@args).
>
> Drop the misleading prototype, as Perlcritic suggests.
