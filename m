From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 02:36:05 +0100
Message-ID: <CAMP44s3yq-C7nYciONf=O61F9mceNV36A3XRPtXCrH=6m-ZpMg@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<20121128011136.GA29674@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Nov 28 02:36:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWZc-00070O-01
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab2K1BgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:36:08 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38358 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab2K1BgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:36:07 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13072821oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8cFab0ZdDTdSG79U6wlwUkFYFM3+wZihyaPCgk0Q3iY=;
        b=0+axMYQwGYRQ0By8hfJdRnlUSO3vg/PcCXSb+KvsEb3iWcgdLC9CrpLZURtoblF0yo
         O7pQg0JmAVySHXJnHFXTaMGaCG7xdXUoAbIYAb8u15+1u4eGg+Lg2fWfHa+NtOBzQYc1
         Vn3T/TmlmAgtQf1pQpbmohk+zEgnkYCd4ZT/b/umrSoESHq5IW7Wfelxkuq1DUM5Kc7Z
         5bP9m0Y4z/FjUwoYLMzHUZOJmvWGUx2xRLl92YbqazfKyi7pSJ/qvEyNKiWdGfPRKWyO
         nxj8otQP1tZC4aJDlP9Cpq5pROTt4QRaNG11VTz9vOY4CijnUi38Ff4+Unp0WbOuR9gj
         enfA==
Received: by 10.60.169.173 with SMTP id af13mr14511720oec.97.1354066565513;
 Tue, 27 Nov 2012 17:36:05 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 17:36:05 -0800 (PST)
In-Reply-To: <20121128011136.GA29674@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210657>

On Wed, Nov 28, 2012 at 2:11 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> % git cat-file -p HEAD
>>
>> You'll see exactly how git stores commits. Changing anything in there
>> must be done carefully.
>
> Oh, I've seen *that* before.  Are you telling me the database
> representation is actually textual?

http://git-scm.com/book/ch9-2.html

---
% ruby -e "require 'zlib'; puts
Zlib::Inflate.inflate(File.read('.git/objects/55/47f28602c9b07f69dfa4685945f71f660e8b25'))"

commit 382tree a14fe16bb9cb7d949d9eb7570bf56968b209f4a2
parent c3640f09011d969ac85753c8f0114ce9b9c86603
author Felipe Contreras <felipe.contreras@gmail.com> 1352767480 +0100
committer Felipe Contreras <felipe.contreras@gmail.com> 1354064281 +0100

remote-bzr: detect local repositories

So we don't create a clone  unnecessarily.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Yes, that's what I'm telling you.

-- 
Felipe Contreras
