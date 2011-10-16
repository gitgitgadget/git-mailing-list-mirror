From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 1/6] git-p4 tests: refactor and cleanup
Date: Sun, 16 Oct 2011 11:54:11 +0200
Message-ID: <201110161154.11898.stefano.lattarini@gmail.com>
References: <20111015155358.GA29436@arf.padd.com> <20111015155517.GB29436@arf.padd.com> <201110161138.58396.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 11:54:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFNQJ-0002ct-VP
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 11:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab1JPJyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 05:54:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64107 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab1JPJyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 05:54:23 -0400
Received: by wyg36 with SMTP id 36so1310319wyg.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=zLxIka4jNoRaS9Ju9eJkqeAqwbBqASrI2wGLaaceR/U=;
        b=Q0bNU4OIv5nhH26g5gipPxMaBWd5mJoFD2f5X4mxIR4GBl1pGy5SvmsRqxaGkOCp3/
         7S3ZchVHBTBwwUeNRvpBtj9OUTnCTHwhU/hQhnCpyi3UGvv8GvJ0UozZSilBya1qtsEn
         46VBRFWvjq+OFXMYeQKIXJmJxwByjGOgM8jfk=
Received: by 10.216.9.133 with SMTP id 5mr2205638wet.95.1318758861859;
        Sun, 16 Oct 2011 02:54:21 -0700 (PDT)
Received: from bigio.localnet (host72-38-dynamic.56-82-r.retail.telecomitalia.it. [82.56.38.72])
        by mx.google.com with ESMTPS id fo7sm24420085wbb.20.2011.10.16.02.54.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 02:54:21 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/2.6.30-2-686; KDE/4.6.5; i686; ; )
In-Reply-To: <201110161138.58396.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183699>

OK, I have to partially correct myself here ...

On Sunday 16 October 2011, Stefano Lattarini wrote:
>
> This won't work with older versions of the Almquist shell (without
> prepending `testid' and `git_p4_test_start' with a `$', that is):
> 
>   $ ash-0.5.2 -c 'a=4; b=2; echo $(( 1 + (a - b) ))'
>   ash-0.5.2: arith: syntax error: " 1 + (a - b) "
> 
OTOH, this behaviour seems in contrast with the POSIX standard, which
says that:

  ``If the shell variable x contains a value that forms a valid integer
    constant, then the arithmetic expansions "$((x))" and "$(($x))" shall
    return the same value.''

Reference:
 <http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_04>

So, since the git testsuite explicitly requires a POSIX shell, there is
probably nothing to fix here.

Sorry for the noise,
  Stefano
