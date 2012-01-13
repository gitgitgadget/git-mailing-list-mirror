From: Thomas Perl <th.perl@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: Fix file links in "grep" search
Date: Fri, 13 Jan 2012 15:09:27 +0100
Message-ID: <CA+uOhx7QwRQJzyYBCkmVDBRCMt0i_ZqS=sfTG0VmNiVv2dVoww@mail.gmail.com>
References: <CA+uOhx6i-07kW8K0y3Co++2ABD=Lmaq3r4h1hN4YLskAE+hR1Q@mail.gmail.com>
	<7vhb0cqpix.fsf@alter.siamese.dyndns.org>
	<CANQwDwfnp167Uth5TLbCD6OR-Xe6JD-2vENiJVnipi1YdjnMPQ@mail.gmail.com>
	<201201052126.49087.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 15:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlhoz-0000eV-9i
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 15:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179Ab2AMOJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 09:09:29 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38776 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753250Ab2AMOJ2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 09:09:28 -0500
Received: by lago2 with SMTP id o2so291890lag.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2mhjXkH1Jdc2dPRqVGYr2heitJzrMovWddrI0/sV/sk=;
        b=Lx9umkHmtHhKTGgyx+P1X/iMwp2GuAGq1ya6TN10K5+8VUystnmxgwsTXqzvGHdpkd
         8U1XmYsvjKfJGk1dG6K0GLzovDUYKZndvQnQ4g8LzCSPv7Tku00yjpA7mfDsibSI+7aF
         zL7+vlRe1eohCmu/ZR1lmLb0Fh1DI2+926O6E=
Received: by 10.112.86.67 with SMTP id n3mr274660lbz.29.1326463767194; Fri, 13
 Jan 2012 06:09:27 -0800 (PST)
Received: by 10.112.53.36 with HTTP; Fri, 13 Jan 2012 06:09:27 -0800 (PST)
In-Reply-To: <201201052126.49087.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188513>

Hi,

2012/1/5 Jakub Narebski <jnareb@gmail.com>:
> There were two bugs in generating file links (links to "blob" view),
> one hidden by the other. =A0The correct way of generating file link i=
s
>
> =A0 =A0 =A0 =A0href(action=3D>"blob", hash_base=3D>$co{'id'},
> =A0 =A0 =A0 =A0 =A0 =A0 file_name=3D>$file);
>
> It was $co{'hash'} (this key does not exist, and therefore this is
> undef), and 'hash' instead of 'hash_base'.
> [...]
> Thomas, could you check if this fixes your issue?

Sorry for taking a bit longer to respond on this one, but I just got
around to test all problematic cases that I described with the patch
applied - it fixes the problem for me (i.e. I can successfully grep in
non-master branches and then clicking the link brings me to the right
location).

As far as I'm concerned, the patch can be applied and fixes the bug.

Thanks for the quick fix! :)
Thomas
