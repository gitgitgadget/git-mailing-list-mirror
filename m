From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v2] config: allow inaccessible configuration under $HOME
Date: Sat, 25 May 2013 13:35:25 +0200
Message-ID: <CAHmME9rYH2kuvxafg10kYRa8kiOLeBeY9UuwUMNOeQdTbvhf+g@mail.gmail.com>
References: <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
	<20130412050550.GA15724@sigill.intra.peff.net>
	<20130412112636.GC20178@odin.tremily.us>
	<20130412144855.GA17968@sigill.intra.peff.net>
	<7vk3o7g29s.fsf@alter.siamese.dyndns.org>
	<20130412161600.GA20492@sigill.intra.peff.net>
	<20130412170505.GA2383@sigill.intra.peff.net>
	<20130412191433.GR27070@google.com>
	<20130412193755.GA5329@sigill.intra.peff.net>
	<20130412203442.GT27070@google.com>
	<20130412210318.GU27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 13:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgCrX-0005bq-8Q
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 13:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab3EYLmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 07:42:10 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51287 "EHLO frisell.zx2c4.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719Ab3EYLmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 07:42:09 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 May 2013 07:42:08 EDT
Received: from frisell.zx2c4.com (localhost [127.0.0.1]);
	by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c81bcbda;
	for <git@vger.kernel.org>;
	Sat, 25 May 2013 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; s=mail; bh=iC8F/e4uSFNXB+jJMhpgo4CN3NQ=; b=YUN4pa
	41CzGLmBAcbZyba/Z1tEacx5XGXkMsXG2zYwYQz33NK4gRg/Y40qf7AWCgYWTTmt
	bECL3eLjK36jCvBle9tuyZRv/rRishWSDUgfp/BgSEDtAjX3Q/Bp020/2t/BWEyu
	KrwrU09eTK+JY4Tnf4K8clEyRvmK5rA8es8SU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=zx2c4.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; q=dns; s=mail; b=T8iwY5BIcBr34Ufk/GPk0sCkJ0xkPRJK
	4P24ttHnQwpiUp3vfqxGPlDnE0w+0muIXL69RCe9b0Mb45sOoA90ITuZpPtoZ417
	l4Rj/7TaXw5FHJSnKkt8jXANFdiw2xK/iEEs67R1tI2eFna3f5Gtuz0pcCpZGdHC
	Yg4Y4CbZyuQ=
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com [209.85.220.177]);
	by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 08309363;
	TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sat, 25 May 2013 11:35:26 +0000 (UTC)
Received: by mail-vc0-f177.google.com with SMTP id ib11so3723064vcb.8
        for <git@vger.kernel.org>; Sat, 25 May 2013 04:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BGjmX1SX62YqQ+Qx3umKI4bSQxHe+f1LjDSFHhnu4Ak=;
        b=W9Rs/Bj3sBh2EZp1srBTEZ1fPmKQpYuvTpDDFRc37IWu1sIvXNjZT87iA2UWS+L3KF
         k9EcCqWvqN9mSIih69GVmXnUIBmSEOdeazty5Y+Zp+wGVjgtcJB/acoc9V95Bp1gHeFx
         7C0Tv/x7hXrb3tQmr+skd7KnCz9aHaEh4hf1bM2xNU/Dum1OhhOoRE1FcC3nXM6M54uX
         nCmc8O4YxU55LFsrINuNyFUQw1OxBavXxhvtiuBJeC5Rg0MosCYsJzUaMZweQReRz+oP
         ywV3UlK2Y4NF7sjeecVq9cUiPqEcRI+VIkueARb7uTALZ8Od1c70tybhg/dqD24BZA08
         4aHg==
X-Received: by 10.220.166.69 with SMTP id l5mr846059vcy.26.1369481725762; Sat,
 25 May 2013 04:35:25 -0700 (PDT)
Received: by 10.52.19.11 with HTTP; Sat, 25 May 2013 04:35:25 -0700 (PDT)
In-Reply-To: <20130412210318.GU27070@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225520>

Jonathan's patch would indeed be nice. In cgit, we are forced to do
ugly things like this:

        /* Do not look in /etc/ for gitconfig and gitattributes. */
        setenv("GIT_CONFIG_NOSYSTEM", "1", 1);
        setenv("GIT_ATTR_NOSYSTEM", "1", 1);

        /* We unset HOME and XDG_CONFIG_HOME before calling the git
setup function
         * so that we don't make unneccessary filesystem accesses. */
        user_home = getenv("HOME");
        xdg_home = getenv("XDG_CONFIG_HOME");
        unsetenv("HOME");
        unsetenv("XDG_CONFIG_HOME");

        /* Setup the git directory and initialize the notes system.
Both of these
         * load local configuration from the git repository, so we do
them both while
         * the HOME variables are unset. */
        setup_git_directory_gently(&nongit);
        init_display_notes(NULL);

        /* We restore the unset variables afterward. */
        if (user_home)
                setenv("HOME", user_home, 1);
        if (xdg_home)
                setenv("XDG_CONFIG_HOME", xdg_home, 1);

A big nasty guard around the git setup function, so that we don't error out.
