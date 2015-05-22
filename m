From: Stefan Beller <sbeller@google.com>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule
 does not yield complete logs")
Date: Fri, 22 May 2015 12:23:02 -0700
Message-ID: <CAGZ79kaLqZCazM9MPR7wswMnVuvwO+Y0Pw9zPPXPEzAW6MQbEw@mail.gmail.com>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
	<xmqq8ucghf2s.fsf@gitster.dls.corp.google.com>
	<64326DCF30A041379141BB51437E87A6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Roberto Tyley <roberto.tyley@gmail.com>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 22 21:23:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvsXH-00036k-72
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 21:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381AbbEVTXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 15:23:06 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33770 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676AbbEVTXE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 15:23:04 -0400
Received: by qkgv12 with SMTP id v12so19797441qkg.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L9zrtl5dSjPBDZBldA5TseoPETN2m8b3acJ56ZarysE=;
        b=UZVJM3p1xG0OcA6t7j7ykLQ/Kh0y43buLczQYL+iWqyXxb2yFhQ9g4T3XjPGsvk2FD
         lCR5R9UvQCuIGQ8aDbP0AGgHDyB7pH7qE8Le40ENz+nEwR6Q0PD2k9+bNg2uNJEgYT1w
         /BzB9vfX1ZXRmvs9AbCoEPj8P7yDyJvVDs8o9zPNVlKJiECW7Yj+uPvj7D8COgzEkYdF
         JDBTrkzrC7hmox9fR1w4+FMxUx0uvDYHxH9HE6q/fUmXlOQ0WQYtK9jzhAdq1YiQD3VY
         bDfthqe1CylG08bNGXFIojEqYB8dIzB+iOjUdTk/2rxRxhS0Ikl2LKwvs6qU9Pd8tZ2Q
         PZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=L9zrtl5dSjPBDZBldA5TseoPETN2m8b3acJ56ZarysE=;
        b=JNBYoMLarxzjWt5z60L4jVvxB+a8QGTqaROQO6SB5tR78IHdgk6HMbID7IZkOOnwbz
         6vESvZj2GrEu/Fj8TyfSjzc75osItjM+xiwFK6uPgblRW4WdOt4eXKyLhs2OafYHAVMw
         ea3S3bOejv6saiZm4F+TujfmeyS5OsL1v0P8PzafPep2XNTCpfZQ/CR1dyrygvMmMo3p
         Pc2AzOl6kfI6yyrMSrfcZi/8udz/K8wxq8/WyRFJhczi5PsXGIQiFOj4esyH2IbMb40g
         Jwglo3frYP9XZThjW0zte+SjefclvHKCzalqvh81NQdyfaz5uDg0Q/0wktcjeOzwQ/Uq
         US+Q==
X-Gm-Message-State: ALoCoQlB6QhbfHMTaxJzh1TS9UiGGAvQ0vxF02oPtj54ABTcStWm7/vL7IgtEbr/jeeRoHa/WTAi
X-Received: by 10.55.19.197 with SMTP id 66mr21647859qkt.24.1432322582924;
 Fri, 22 May 2015 12:23:02 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 12:23:02 -0700 (PDT)
In-Reply-To: <64326DCF30A041379141BB51437E87A6@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269749>

Ok, I am trying it out now, all I have left is

    Register your email address
    (stefanbeller@googlemail.com)
    with submitGit's Amazon SES
    account in order for it to send
    emails from you.

So first of all:
Where do I find the Amazon SES account for submitGit, to register
my email with?

Also can I change the email in the process or change it before?

Thanks,
Stefan
