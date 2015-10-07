From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] gitk: l10n: Update Catalan translation
Date: Wed, 7 Oct 2015 17:08:48 -0600
Message-ID: <CAMMLpeRhJiYrZ8P3G7uQj4rcRRV+1+5qRiRjaUbh9CDrvKprPg@mail.gmail.com>
References: <1444105572-20580-1-git-send-email-alexhenrie24@gmail.com>
 <xmqqk2r0wo8g.fsf@gitster.mtv.corp.google.com> <CAMMLpeSMLjzq-8kkSx-shJGqVS1ZHsC=nKG5pOSyyz7ymnE95w@mail.gmail.com>
 <xmqqio6is2wg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 01:09:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjxpm-00024r-2G
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 01:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbbJGXJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 19:09:10 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32917 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbbJGXJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 19:09:08 -0400
Received: by wiclk2 with SMTP id lk2so4675728wic.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DZPRJsIGwLm5u0nW4q+2d64YdfxTFzuVy5/KpnPn4pw=;
        b=HLKoIIRoI8dTUt/ehbHoRVXaz0CxEn5+DXXFk/ZSbvzl+29KPXAELT52C07wVHou/T
         CDvlf69dW5Q89bX3CtKQq/ux3lDvEBS+IZSDaV2MOsF3OJG0coQJr5te56VONmfrMS4i
         wgUaUon3s9Ma0CVbRDYfXsXyLk8+myUAma3JY64/2QT+CHHcj1VePQiPudg+pKNx+KmJ
         P2QHSIl6LUPJRdW/2Y8k8e579ZqA6tqyDdsCzYDEXZTCv5tDC8l8CCrKwzrommKZ/KRQ
         Pu9i+H0DWXHV419vKMqKJpdXcoIiZW9Br+ykmCGgIakFzWUvtJd0otuj4R/xzyYu8H3O
         BwBA==
X-Received: by 10.194.114.133 with SMTP id jg5mr3824107wjb.98.1444259347553;
 Wed, 07 Oct 2015 16:09:07 -0700 (PDT)
Received: by 10.28.16.211 with HTTP; Wed, 7 Oct 2015 16:08:48 -0700 (PDT)
In-Reply-To: <xmqqio6is2wg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279210>

I figured out how to reproduce the problem: Running gitk with any
parameter causes it to crash. For example:

$ gitk e334ca2b9d9a48a1636f73fc12606b6eaa58b7d9
Error in startup script: bad menu entry index "Edita la vista..."
    while executing
".bar.view entryconf [mca "Edit view..."] -state normal"
    invoked from within
"if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
    # create a view for the files/dirs specified on the command line
    se..."
    (file "/usr/bin/gitk" line 12442)

Running gitk without parameters is still OK. My guess is that it is
the same bug that
<http://article.gmane.org/gmane.comp.version-control.git/278863>
describes.

-Alex
