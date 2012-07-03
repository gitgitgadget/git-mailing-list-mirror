From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git_getpass regression?
Date: Tue, 3 Jul 2012 19:37:23 +0200
Message-ID: <CABPQNSZjZtRxf1=cdKqgp3FwP6Fw2W876si9=OpyHmZ6mjHRsw@mail.gmail.com>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
 <20120629173954.GA3804@sigill.intra.peff.net> <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
 <20120629203001.GA12937@sigill.intra.peff.net> <CABPQNSY3hJse6J7fDo0S5=ySZA4_7=JisfzLBUu135gR2nSF-w@mail.gmail.com>
 <20120630183607.GA19739@sigill.intra.peff.net> <CABPQNSYP6mUZb-1dCifytRxqP7_grzYzON2bjevK2zsGawb-yg@mail.gmail.com>
 <CABPQNSZGcReC4CgaYcmwsXyGSqzQgHKQceZ2M5D=zQmyAs8_Ug@mail.gmail.com> <20120703171121.GA3294@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 19:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm73E-0008Px-19
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 19:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab2GCRiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 13:38:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38727 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab2GCRiF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 13:38:05 -0400
Received: by yhmm54 with SMTP id m54so6348298yhm.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=U42Rpm7lYxQHP/8bDsVnQl//m5ouxECCJCVJeuSMuMo=;
        b=KB0LovCHDSX28v2wjWdQeovGuVswcI84LH88pOyyrrQuad5Sk72CIX3w2IBU9IrGY4
         5HgnvcnoNZv2/+ezP6FjTDnEhrCIutnaK0pp6MtiRGoB341JEzTOgvj923OWU8gffYzZ
         /lK122scv7TSJhvfRxKFmOoAR86kUo5X2If24x6pSLaano8fgic+MVVyqIfnQcXjgNkS
         cKqwpFHyFvvoKzLVhrVGfFe41RzZCjo5tg9bpf994sJmLrzgkkFulpliDlsc5+aJ3HTw
         vHMNKXiQ29tIy3Ql6fI/2JR2Z5coO/xZbQrPXkSiQMOGpVUipioUqcSVCHkc6qtWwmpU
         v7rw==
Received: by 10.68.201.195 with SMTP id kc3mr9133704pbc.33.1341337083908; Tue,
 03 Jul 2012 10:38:03 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 3 Jul 2012 10:37:23 -0700 (PDT)
In-Reply-To: <20120703171121.GA3294@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200923>

On Tue, Jul 3, 2012 at 7:11 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 03, 2012 at 06:28:11PM +0200, Erik Faye-Lund wrote:
>
>> Is there some other way of getting EOF from the console than Ctrl+C?
>> If not, perhaps we can disable the Ctrl+C handling altogether for the
>> current process, and restore the console mode on EOF? That only leaves
>> the "Bash kills our process"-case, but Bash seems to set a sane
>> console mode anyway.
>
> On unix systems, you can generally send EOF on a terminal using Ctrl+D
> (and strbuf_getline should handle it properly).  I have no clue if that
> works on a Windows console, though.

Nope. On Windows, Ctrl+D seens to give EOT (0x4).

> Also, I wonder if these kind of
> terminal issues are different based on the terminal emulator you are
> using (e.g., msys bash window versus something like pterm).

No, they should not. Windows doesn't have a concept of different
terminal emulators. There's only ever one, which is built into
windows.
