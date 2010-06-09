From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Wed, 9 Jun 2010 15:13:34 +0200
Message-ID: <AANLkTimXSfAqMYVIQcepibeDlJPOKE4hTlys9laEFTHo@mail.gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com> 
	<20100608141321.GP20775@machine.or.cz> <AANLkTiksOpUqxGc7Lo4clrLwOF6GvkT7CZH5CVeirtBr@mail.gmail.com> 
	<201006090138.52125.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 15:14:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OML6Z-00055L-T5
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab0FINN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 09:13:58 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:42764 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab0FINN5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 09:13:57 -0400
Received: by wwb31 with SMTP id 31so228459wwb.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dw31lKIC/wz55XKHpZwwwpcPOb2cYsrFwlkDd1CM3hw=;
        b=efsjuD0t1z6QIfoos16Ky1bnQ9LXiA+gNUGSn8PbAcNsQ1ndGvfloWYH5tFa3exIw8
         KLCV8hY4pGDM6fvBbABH4mXEUzV8zYTeHvoZ7Lsc21t9IQHtwTxSW+YDS9fWrENX6MDd
         3a1crI5SguCjOF9TudepjlHoYu9SwPtMBRhY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pNr/zU8HpZj/IZjiZ3Nm0CzjUSqmqeFz4PIo7GOToYkr7UiMwulI29LUmTL9hIN+bH
         XNlmlMn+On8xQGMxN5J50yARBnRtXMIQ8P3CMq2HZQD4BqQYs63cz+93SrKxnfwEP/jp
         tmhTuiTtTV+KRhYqSIpvuEMdFt9O63awZzy8g=
Received: by 10.227.156.195 with SMTP id y3mr8493942wbw.10.1276089235772; Wed, 
	09 Jun 2010 06:13:55 -0700 (PDT)
Received: by 10.216.73.15 with HTTP; Wed, 9 Jun 2010 06:13:34 -0700 (PDT)
In-Reply-To: <201006090138.52125.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148770>

On Wed, Jun 9, 2010 at 1:38 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Tue, 8 Jun 2010, Petr Baudis wrote:
>>
>> =A0 I thought we already discussed MVC and sort of agreed that it's =
an
>> overkill at this point. At least that is still my opinion on it; I'm=
 not
>> opposed to MVC per se, but to me, this modularization is a good
>> intermediate step even if we go the MVC way later, and doing MVC pro=
perly
>> would mean much huger large-scale refactoring than just naming a mod=
ule
>> Gitweb::View instead of Gitweb::HTML. Let's do it not at all, or
>> properly sometime later. I think it's well out-of-scope for GSoC.
>
> So it would be enough to have Gitweb with core of gitweb, gitweb.perl
> top-level script, Gitweb::Write or something like that for new write
> functionality and Gitweb::Util containing things that are needed by G=
itweb
> and by Gitweb::Write(r).

Sidenote (something I meant to write, but forgot): SVN::Web[1][2] and
Gitalist[3][4] might or might not be good example on how to split gitwe=
b
into modules.

[1] http://p3rl.org/SVN::Web
    http://search.cpan.org/dist/SVN-Web/
[2] http://jc.ngo.org.uk/svnweb/jc/browse/nik/CPAN/SVN-Web/trunk/

[3] http://p3rl.org/Gitalist
    http://search.cpan.org/dist/Gitalist/
[4] http://github.com/broquaint/Gitalist
--=20
Jakub Narebski
