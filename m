From: David Turner <dturner@twopensource.com>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Fri, 04 Jul 2014 13:22:50 -0700
Organization: Twitter
Message-ID: <1404505370.3109.15.camel@stross>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=D8yvind?= "A. Holm" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 22:23:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3A0Z-00060S-0p
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 22:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759975AbaGDUWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2014 16:22:55 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:39563 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbaGDUWy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 16:22:54 -0400
Received: by mail-qc0-f176.google.com with SMTP id w7so1864555qcr.35
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 13:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=dEcVAg4Nyn8I4wA8FfgSsrxsd/VUkUVS5OSm9r9XB24=;
        b=InNnFDNIk0h6i8283RcqeOUTs2tKV3DGK4uSJojYW0jOhrKnynHBCa7Q58l2MDEz82
         SOwA/IAIVeoZpCY1iA8XEVY14NwVL0gasVbs6BYII/r8cWk9+Fp5nNcdGYqyacptDmTK
         nB1hBqd8WPEjA8yyNOwYV3ogzy/9HyFn+7BSuIlmz7D7kgvMXObMR5rzV9d2SPOjd0tC
         SHtQk93djFCcHSG16QlQ6+iS4+PWMq0aHCQNo9jRSxPWVejOe5FB/QKjur6R/vmbJWEO
         IrqM79F9ImEWFvDalpKPG76Y/KKGWdjiflnpWR0Dm0uKLWwb3q0EMH3QASJrhUjtWxPe
         nVWw==
X-Gm-Message-State: ALoCoQkpwL9VqYIPUt5O1ssDCzeo8BJFkj8sHdkaStBMNgM1Iev8UzfIjUL2HndOkPc6aRcoYMML
X-Received: by 10.140.24.76 with SMTP id 70mr19554443qgq.30.1404505373547;
        Fri, 04 Jul 2014 13:22:53 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id s8sm57501733qac.49.2014.07.04.13.22.51
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 13:22:52 -0700 (PDT)
In-Reply-To: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252901>

On Thu, 2014-07-03 at 23:55 +0200, =C3=98yvind A. Holm wrote:
> When compiling newest master (v2.0.1-472-g6f92e5f) on Debian 7.5
> (64-bit), t5150-request-pull.sh fails when compiling with
>=20
> $ make configure
> $ ./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f9=
2e5f
> $ make prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e5f
> $ make
> $ cd t
> $ ./t5150-request-pull.sh

Are you sure you're not running under valgrind? I can reproduce the tes=
t
failures when I run under valgrind because I didn't add the right stuff
to the suppression files (patch to follow). =20

I also just went ahead and got a Linode running Debian 7.5 (64-bit), an=
d
I still can't reproduce the problem.  Do you have any additional
reproduction info that I need here?
