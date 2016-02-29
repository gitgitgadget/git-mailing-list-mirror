From: Guilherme <guibufolo@gmail.com>
Subject: Re: git config --get-urlmatch does not set exit code 1 when no match
 is found
Date: Mon, 29 Feb 2016 18:38:28 +0530
Message-ID: <CAMDzUtwJVyaQbjgdQLi17_4ejGofpRFBDxXxjseaVcHLXCAwRA@mail.gmail.com>
References: <CAMDzUtzNKAYSKYkt3WagkUrA2mKaoDu1rT6Nhf89pXSMg0wZwA@mail.gmail.com>
 <20160229115355.GA31273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 14:09:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaNZa-0003Iw-Um
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 14:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcB2NJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 08:09:09 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33821 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbcB2NJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 08:09:08 -0500
Received: by mail-vk0-f48.google.com with SMTP id e185so132680548vkb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 05:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q1QMaZ6mLV0SwQgGm1yRkjHhfXdqt55owGVw/Xwa1Yk=;
        b=dzaSSBuWFjq+d02MPaRiTMRF3WKyo4Lp5WS9TyRK1N037NCiMERMeGx2M10PctKLiw
         fv1auzTkzl2nr8rntvhTG7A5kaVUtjWoB2GYfNilRQOPpRA/yM8NU7dXGOibnOr0K0wu
         tRLz5Y+pVMUXihXzQ8M0KBX6EtB+90Q5MgySooWf4V25E1wWVFwKpGEmtMrs51AxQKrt
         ZzoHN8xwdyNlO3x7x4+kx0g6wMupAerkgXnx46/TJWS8KQedF30TXzbwyK39El6x1+Pi
         iYJ+8MLmG1h/diILIjM6EheOjlv6kjb3QatAVpiDtIqby9NceTALGUYGCHevVvwajHzq
         +3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q1QMaZ6mLV0SwQgGm1yRkjHhfXdqt55owGVw/Xwa1Yk=;
        b=S9F54pVO1eRb7csK1cmOMQuslWfku1Ixdl419/MfzAlbOKV02w6K2yRn1ix8A47IRo
         Xvqwm/5PoPAHg2CcB85V7N5f0gHHF1BiB6f2iMnXstGulES/KnUMCHYS1GKI/077NaFf
         GQsSqj3mR5JSSOz4UFjJtpkDEC0fCEhiXct7crGUqBgFGL4536w5A9JdHv28IACQxFN1
         lFGQyCbIir7Trp87nFeOvZ8JrWmX1PSbbreWAIzDzxYJB6ulCrsKv5++0QVP6vVa6jZ0
         MBAYFfX92XzAYh9xf8uCgVypJqHN04zEUZiYo8sUHBUR56IvQINIrKy2OUctrdLgYz2c
         fGWA==
X-Gm-Message-State: AD7BkJKa3tuKQ5ycGcym0ngZdQbwnh/BAUKBWsOuo/FCTr8/tBHTFMrSj6G7AQ/F9n2gZZ0eBVIo/JmNIsCdOQ==
X-Received: by 10.31.52.147 with SMTP id b141mr11574019vka.82.1456751347792;
 Mon, 29 Feb 2016 05:09:07 -0800 (PST)
Received: by 10.31.162.145 with HTTP; Mon, 29 Feb 2016 05:08:28 -0800 (PST)
In-Reply-To: <20160229115355.GA31273@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287835>

@Peff Thank you for the heads up.

I'm trying to find out if there are any credential helpers configured
in the system that will be running tests. On the dedicated test
machines that is not a problem but the developer machines are.

Should I already post a pre-emptive email asking about the corner cases?

More importantly for me is if there is a case where get-url would not
show a match where git clone would. If git clone skips a configuration
that config url-match doesn't then it's not so bad.
