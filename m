From: Matthieu Brucher <matthieu.brucher@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Fri, 5 Jul 2013 14:16:26 +0100
Message-ID: <CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 15:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv5sF-0006Y3-Kk
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 15:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933774Ab3GENQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 09:16:27 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:44642 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890Ab3GENQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 09:16:26 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so3279824oag.26
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=76ZTULN6A5EkrmM12bWuQRWJZOgD88CXH+DqZpNLJ80=;
        b=g3B5CWKQaLMxwISQzoo9ylPbm1cubU2UPF5YTlG043ejmYS9Ah5G7Zkgkc6uI2wr2C
         de/yWj8OaRzdc2UiavBrcg08MJhsuDT1Hsn7jOt5UAi6FQjr8AxOEFrZWptKfPRfT1Mx
         M4oTpsjH3FTa0To1bWhs/XBox2ora+au+jCZyOa2foT6wfyxcOYeikBZ7peFgqEUYhdl
         hh/RUEsfqFkATfWN73gfxbEACXFW2PVN/AR0P4hQ1/a+IW7kgAUE9OBILSx+GYHat0DP
         Wi1UML5uRTzNQDLYRGH08HjX0uQAgGAOhOveqDFDkDXq5t2vHIfaM+mgbl7p882ZV1sV
         ffNQ==
X-Received: by 10.182.87.42 with SMTP id u10mr10895852obz.73.1373030186280;
 Fri, 05 Jul 2013 06:16:26 -0700 (PDT)
Received: by 10.76.153.5 with HTTP; Fri, 5 Jul 2013 06:16:26 -0700 (PDT)
In-Reply-To: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229666>

Hi,

I'm trying to convert a Perforce repository to git, knowing that:
- I use client specs to remove a bunch of folders containing binaires
(several GiB)
- branch mappings may not be properly set, and I can't change them

Now, the branches are layout like this:
- Branch/Main <- master
- Branch/Feature1
- ...
- Releases/2013
- ...
I would like to have these branches and releases branches inside by
cloned git repository, but this doesn't work. I keep on getting each
file with Project/Branch/Main as well as Project/Branch/Feature1 and
all others in my master branch.
I tried to add branchLists like this:
        branchList = Branch/Main:Releases/2013
        branchList = Releases/2013:Branch/Feature1
but it doesn't change a thing with the following command:
 git p4 clone --verbose --use-client-spec --detect-branches
//Depot/Project@specificrevision

I can see that branches are detected from the Perforce server, but
none are actually detected for this specific project:
p4-git branches: []
initial parents: {}

Can someone give a pointer to a tutorial or something for a complex
case like this?

Regards,

Matthieu Brucher
--
Information System Engineer, Ph.D.
Blog: http://matt.eifelle.com
LinkedIn: http://www.linkedin.com/in/matthieubrucher
Music band: http://liliejay.com/
