From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 13:23:15 +0200
Message-ID: <vpqmylnkkm4.fsf@bauges.imag.fr>
References: <200806120920.31161.johan@herland.net>
	<200806151216.01886.johan@herland.net>
	<ee77f5c20806150352n6ccf00e9w8083a17d8c5c2326@mail.gmail.com>
	<200806151255.41055.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 13:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7qMf-00063q-8V
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 13:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141AbYFOLYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 07:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757209AbYFOLYN
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 07:24:13 -0400
Received: from imag.imag.fr ([129.88.30.1]:52723 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997AbYFOLYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 07:24:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m5FBNItg029783
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 15 Jun 2008 13:23:18 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K7qKJ-0001Xp-FM; Sun, 15 Jun 2008 13:23:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K7qKJ-0004Ff-D3; Sun, 15 Jun 2008 13:23:15 +0200
In-Reply-To: <200806151255.41055.johan@herland.net> (Johan Herland's message of "Sun\, 15 Jun 2008 12\:55\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 15 Jun 2008 13:23:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85080>

Johan Herland <johan@herland.net> writes:

> On Sunday 15 June 2008, David Symonds wrote:
>> On Sun, Jun 15, 2008 at 8:16 PM, Johan Herland <johan@herland.net> wrote:
>> > diff --git a/git.spec.in b/git.spec.in
>> > index 97a26be..d946bb1 100644
>> > --- a/git.spec.in
>> > +++ b/git.spec.in
>> > @@ -12,7 +12,7 @@ BuildRequires:        zlib-devel >= 1.2,
>> > openssl-devel, curl-devel, expat-devel, gettex
>> >  BuildRoot:    
>> > %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
>> >
>> >  Requires:      perl-Git = %{version}-%{release}
>> > -Requires:      zlib >= 1.2, rsync, curl, less, openssh-clients, expat
>> > +Requires:      zlib >= 1.2, rsync, less, openssh-clients, expat
>> >  Provides:      git-core = %{version}-%{release}
>> >  Obsoletes:     git-core <= 1.5.4.2
>> >  Obsoletes:     git-p4
>>
>> Shouldn't libcurl still be listed as a requirement? Or is it statically
>> linked?
>
> 4 lines further up in git.spec.in:
>
> BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel, 
> gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}

I don't understand how that answers the question. Unless curl is
statically linked, you need the library both at build time and at run
time. For example, zlib-devel is needed here at build time, and zlib
(without devel) is still in "Requires:". So, what's the difference
between zlib and libcurl here?

-- 
Matthieu
