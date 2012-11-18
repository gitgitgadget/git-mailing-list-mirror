From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/7] completion: fix args of run_completion() test helper
Date: Sun, 18 Nov 2012 09:48:01 +0100
Message-ID: <CAMP44s3FmB3F5zjQcVQJDwo7K5m19203Z7D67beHv726g3TL_A@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 09:48:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta0Y6-0007Vs-CD
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 09:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab2KRIsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 03:48:04 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51320 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2KRIsC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 03:48:02 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4011587oag.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 00:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KHYXe+dUvWW4GCycu2bUsEbGbBwe2JYckXM3J9HItHQ=;
        b=NO8fHrYlubPkM21qZEB+cBnlHa5lySWtIruCFzfeIqvzc6n+ygFLdu2g1qqBxvThmU
         cKorhA/DHizIPG1+KCWSw2mhh5nG2hTYYUXDMio5kUnP9Jj35j+AWcSVmnUuFKJMXFY9
         DMm7dUDzPYyE4f3jQYUngpOtPxq0wD8YcbreEwn7XsdskUP1XR35lszqNUeunho+GZwP
         RnM4OQ3m7IPfLmicLJL6xK/cDAggQCSGrNLJNkJX341+TGWBRkDnFWBf/BiLz/9NczdO
         WJ6Od+Jw++6B2ZL66RXLJcGyZhhYhnoHoJ56Q8trquw236CllPL1f2qCrFUyL9h6ATgW
         IU8g==
Received: by 10.182.235.46 with SMTP id uj14mr7773415obc.40.1353228481881;
 Sun, 18 Nov 2012 00:48:01 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 18 Nov 2012 00:48:01 -0800 (PST)
In-Reply-To: <1353150353-29874-3-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209995>

On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:

>  test_expect_success 'basic' '
> -       run_completion "git \"\"" &&
> +       run_completion git "" &&

I don't like this approach. I prefer

run_completion "git "

So that it's similar to how test_completion is called:

run_completion "git f"
test_completion "git f"

--=20
=46elipe Contreras
