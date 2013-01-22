From: John Szakmeister <john@szakmeister.net>
Subject: Build broken for contrib/remote-helpers...
Date: Tue, 22 Jan 2013 00:49:31 -0500
Message-ID: <CAEBDL5U+Yrny-YgN1fZj1T+XTJRVaiFvMixT13Zzb2DhhYgQsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 06:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxWk7-0001k3-2I
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 06:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab3AVFtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 00:49:33 -0500
Received: from mail-we0-f176.google.com ([74.125.82.176]:43691 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab3AVFtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 00:49:33 -0500
Received: by mail-we0-f176.google.com with SMTP id s43so458986wey.7
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 21:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type;
        bh=ZKqp6hlTp/oHO54ObJJjLhZHJMrnY6dboGoDp/A+iBE=;
        b=muQMbDZ4KbVleEcI/NN0iNGuXOKCW94abd4SmeSjC0XDTRV+Z296dKyJ7K3RgsFn4i
         mHxI34Fwy8NiQ7rh2MQa3gampQqaFgx/IsWnATncywImN3PpD8TlAl4b3KIYlx4sOIDW
         Z53MBojL6qaEvudej7UyMW0Q7smRiNc3XeQ/Eiw8/XN52hNL369pNlIJnivY1xmRtBwx
         1jSIMw8akDWmiSWcmUH6EOhhZeb63YTa8v2aKvrc6bq2vsraXpcWZUO40fjl21z/jPqx
         kwnzeF6LHxzRs0cs6XW13kFEOg3F42AltqG7pGx6UVNXym/9sFN07ZW9ZBkt1Y68Pd4g
         DbTw==
X-Received: by 10.195.13.200 with SMTP id fa8mr2375968wjd.15.1358833771608;
 Mon, 21 Jan 2013 21:49:31 -0800 (PST)
Received: by 10.180.162.170 with HTTP; Mon, 21 Jan 2013 21:49:31 -0800 (PST)
X-Google-Sender-Auth: K1rkYtQY900dkptsMOt0wQsYo5Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214194>

I tried running make in contrib/remote-helpers and it died with:

    :: make
    make -e -C ../../t test
    rm -f -r test-results
    duplicate test numbers: /Users/jszakmeister/sources/git
    make[1]: *** [test-lint-duplicates] Error 1
    make: *** [test] Error 2

The path shown is not quite correct.  I have the sources extracted to
/Users/jszakmeister/sources/git-1.8.1.1.  It appears that the Makefile
in contrib/remote-helpers is exporting T, which is causing the
duplicate test detection to fail.

Thought you'd like to know!

-John
