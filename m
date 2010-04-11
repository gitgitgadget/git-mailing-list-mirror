From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured output
Date: Sun, 11 Apr 2010 08:46:46 -0700 (PDT)
Message-ID: <m3bpdqgfha.fsf@localhost.localdomain>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
	<20100411113733.80010.3767.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 17:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0zN9-0007kp-EW
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 17:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab0DKPqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 11:46:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:63041 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab0DKPqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 11:46:49 -0400
Received: by fg-out-1718.google.com with SMTP id 22so426851fge.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=/ORXJ0d7qdD+xJTn19r257REP0D7Bvn0wtDeT1QtQXk=;
        b=x0oeJQK74h7rbVsWP0TEZTnyltrr0sm4BClJqehRr3tmVTRJLLJVlaUMH6gNu35mav
         FzDd8L1vtAk8+cvm/ajqLbCwAJLK1wmJymT+zwjOlI2k20d3m6VyHVvWNSQ3fM21CBbe
         8cPiY9MlfOSmJWQ6Xoc1zxqrTqeBx82yDpTCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=x/WO2/O0IaKh2MBe1BhBwirxbMeUIG8JHm/rZHGx5i2IilzfMQ3QzkupK281VmD3Jq
         1RhAX6VOWRpXGMUC2QRPMBYhZOgxOH73L2zwZjG3UIj4taPZr6UDdWQyR57fEYNvxpd7
         996BA1Cdxy4u+9BhaLz92J2r7eB8Z5YPlz6tg=
Received: by 10.223.17.150 with SMTP id s22mr2104286faa.14.1271000807907;
        Sun, 11 Apr 2010 08:46:47 -0700 (PDT)
Received: from localhost.localdomain (abwq147.neoplus.adsl.tpnet.pl [83.8.240.147])
        by mx.google.com with ESMTPS id 21sm6763315fkx.40.2010.04.11.08.46.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 08:46:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3BFk4Rw007666;
	Sun, 11 Apr 2010 17:46:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3BFjcaf007658;
	Sun, 11 Apr 2010 17:45:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100411113733.80010.3767.julian@quantumfyre.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144652>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> Add a library that allows commands to produce structured output in any
> of a range of formats using a single API.
> 
> The API includes an OPT_OUTPUT and handle_output_arg so that the
> option handling for different commands will be as similar as possible.
> 
> At the moment JSON and XML output options are available - though the
> XML output is _very_ rudimentary.
> 
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
> ---
>  Makefile      |    3 +
>  output-json.c |  128 ++++++++++++++++++++++++++++++++++
>  output-xml.c  |   68 ++++++++++++++++++
>  output.c      |  212 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  output.h      |   71 +++++++++++++++++++
>  5 files changed, 482 insertions(+), 0 deletions(-)
>  create mode 100644 output-json.c
>  create mode 100644 output-xml.c
>  create mode 100644 output.c
>  create mode 100644 output.h

How about some technical documentation, in the form of
Documentation/technical/api-structured-output.txt (or something like
that), describing how this API should be used.

How about some tests?  Note that you need to take care of commits that
are encoded in encoding other than utf-8 (but with 'encoding' header,
so you know what encoding it is), and of filenames that are invalid
UTF-8 (and their encoding is unknown in general: they are raw binary
data).  You need to take care of non-ASCII characters, and of special
characters (like '"', SPC, TAB, LF, '\') in commits and in filenames.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
