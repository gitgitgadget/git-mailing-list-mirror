From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/6] Add test_harness make target for testing with prove(1)
Date: Fri, 07 May 2010 13:20:28 -0700 (PDT)
Message-ID: <m339y3forb.fsf@localhost.localdomain>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
	<1273261025-31523-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:20:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAU2G-00045g-R7
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194Ab0EGUUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:20:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44813 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757008Ab0EGUUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:20:30 -0400
Received: by fxm10 with SMTP id 10so1066556fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=iqF5dkwOf6igdUl6rL/nmstB1T6AwPfnm714wZYPjWg=;
        b=W7a4zk/TBcoEtuPYSM1ZGqg8HLzZHnpm16F9FbQsNvMnVlWJ2jRkJVy94mFrJvcNsC
         q/eqOqVAsjlQxWTB7I+Ob5cArKNPR8D+yIpBNBeiGdz5ypxnXH2LMNdjqHLWyzcgB2sW
         W+AKw1qmZjnTIVIUAPpTDVHqqReZfpiUqkduU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=DSbiWwP4Vfy4jMArt1sG/PCXiVwQQRKkNecNC/Xdh/tk/uNlNfGwML6x6VoKAL08ev
         KZBOHKAVm5ARi/sODQZszn6RVDtHjekzmS3STwwGHO2byYM7t3uf4qf2dRPWIQzyQuYi
         UsPu9c8lYJAyYETkxlMGnQjCouEQhLJ7hqq2Y=
Received: by 10.223.5.81 with SMTP id 17mr621364fau.42.1273263629103;
        Fri, 07 May 2010 13:20:29 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 13sm8139296fad.7.2010.05.07.13.20.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:20:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o47KK4w3012559;
	Fri, 7 May 2010 22:20:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o47KJrsx012550;
	Fri, 7 May 2010 22:19:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1273261025-31523-6-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146584>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> The --jobs option I'm supplying to prove(1) is not supported in all
> prove versions, some older ones (before Perl 5.10.1) don't have
> it. Anyone that's hacking Git probably has 5.10.1, and you can always
> use the old `make test` for non-parallel tests.

I am hacking Git, and I don't have perl >=3D 5.10.1.  On the other hand
I can alway run "make test" or individual tests instead of=20
"make test_harness".

A better solution would be to check Perl version, or even better of
"prove" supports '--jobs' option, and selectively enable parallel
running of test harness in Makefile.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
