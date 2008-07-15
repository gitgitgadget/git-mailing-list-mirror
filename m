From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git config oddity
Date: Tue, 15 Jul 2008 17:29:15 +0200
Message-ID: <bd6139dc0807150829n2b3c88d7p18c203e93cd4e0c1@mail.gmail.com>
References: <bd6139dc0807150744l78eb8d54ld167d3a9a5a600f@mail.gmail.com>
	 <alpine.DEB.1.00.0807151600170.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:32:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImVg-0004Td-KM
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761586AbYGOP3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYGOP3S
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:29:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:5531 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761586AbYGOP3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:29:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5380281wfd.4
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GOTVa5xa0u8OETXYbd5/6E/aeMjMH/UZ6kbSJwrRfLc=;
        b=xNhHl1md62Zv/CWjD0us3EAJPwUb8FkWvhcdiISFmsw401fZkVUz1SoPa8QIWBCeLV
         E+3DLukttzj22bMIwdjv6djB5aB+UnvhQNQiai69YY9h0jmK9E90+aBUkfvaHFz1Qn8z
         a/tHPWgTEIl9X2mRhqSlmBMDqfvun4WmCPboU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=loyaWvCWsBwNrBIaoq5yXTQhyWbp4e/7E80JtCMGtNBC2bX6qHB4WFfKLtfqvb5rgQ
         8xHSxdz3XUXOK64LVzkqsTqhCEFEArd1A9hQNTVKI5QgC0UXIhd11FZQoLqiiQtCVumy
         qDL6Nv6vp1rNhnVwTsyHa+3ATEBiMYAsxUZQU=
Received: by 10.142.229.4 with SMTP id b4mr4704356wfh.241.1216135755254;
        Tue, 15 Jul 2008 08:29:15 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 15 Jul 2008 08:29:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807151600170.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88569>

On Tue, Jul 15, 2008 at 5:02 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> I noticed today that when unsetting the last value in a group git
>> config leaves the empty group header.
>
> That is on purpose.  As .git/config was always meant as a user-editable
> file, you can put comments into that section.  Or comment out some values.

Ok, this makes sense :). I agree that I would be unhappily surprised
if I found that git removed a section that I had put some comments in
when I unset a variable.

> It is somewhat unfortunate that setting a variable does not find the
> section; the reason is that it sees sections only when a variable is set
> (to avoid having to do the parsing itself).

Ah, unfortunate indeed. I'm not sure I understand why it does not see
the existing header? I had a look at config.c but I couldn't really
make out why it doesn't. Would it be difficult to add that?

-- 
Cheers,

Sverre Rabbelier
