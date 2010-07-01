From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 5/8] t/README: Document test_external*
Date: Thu, 01 Jul 2010 13:52:26 -0700 (PDT)
Message-ID: <m3630zncwx.fsf@localhost.localdomain>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
	<1278015478-6920-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:56:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQo6-0006F6-Ey
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863Ab0GAUz7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:55:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42161 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870Ab0GAUw3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 16:52:29 -0400
Received: by fxm14 with SMTP id 14so1714491fxm.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=qkNWj2qUXypyxgq6GPwYkDfddDQAYhemlM4Es64GvU8=;
        b=cj92rE6IXWZr/ss1HHhK32uEUlayRvm2eFeI29BFTqIIIhsT4u905epSUUbs4esDJA
         1ZiIs3DylKL7dE+dZzCfwcqpEgCx4BfKJRQlkTFblNTgEboo4N0CX8py+AHMAyXlow2e
         y4014wer1evaXukA4qyGQ+h7IjzQ20/X/51MM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=D/jfIZKiGBxswWGb6SF6VHuEjBI2rtcrjLbuEXIU4cTEbMj3QUH41HHZG1Sg6U5UvW
         9ilzVumnqEssYZBX/VQ/ZhVwGGWGMU1Tl/w/NwAWOPDku0lAcXjfdu+w/D88Q4R0u3Ez
         l7KnXx9rnlAfqRt32yVEqP9/vOYUMBjhwsvp4=
Received: by 10.223.122.141 with SMTP id l13mr61367far.25.1278017546634;
        Thu, 01 Jul 2010 13:52:26 -0700 (PDT)
Received: from localhost.localdomain (abwm116.neoplus.adsl.tpnet.pl [83.8.236.116])
        by mx.google.com with ESMTPS id l26sm8292017fam.39.2010.07.01.13.52.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:52:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o61Kq3cV001347;
	Thu, 1 Jul 2010 22:52:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o61KpgZi001342;
	Thu, 1 Jul 2010 22:51:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1278015478-6920-6-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150082>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> + - test_external [<prereq>] <message> <external> <script>
> +
> +   Execute a <script> with an <external> interpreter (like perl). Th=
is
> +   was added for tests like t9700-perl-git.sh which do most of their
> +   work in an external test script.
> +
> +	test_external_without_stderr \
> +	    'Perl API' \
> +	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl

I think this example was to be about 'test_external'; currently it
duplicates example for 'test_external_without_stderr'.

Perhaps:

  +     test_external \
  +         'GitwebCache::*FileCache*' \
  +         "$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.p=
l

> + - test_external_without_stderr [<prereq>] <message> <external> <scr=
ipt>
> +
> +   Like test_external but fail if there's any output on stderr,
> +   instead of checking the exit code.
> +
> +	test_external_without_stderr \
> +	    'Perl API' \
> +	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl

--=20
Jakub Narebski
Poland
ShadeHawk on #git
