From: David Turner <dturner@twopensource.com>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Thu, 03 Jul 2014 15:16:22 -0700
Organization: Twitter
Message-ID: <1404425782.3109.12.camel@stross>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=D8yvind?= "A. Holm" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:16:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2pIy-00023w-SE
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759817AbaGCWQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2014 18:16:32 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:58552 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759729AbaGCWQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 18:16:25 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so779874qge.25
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 15:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=FEzvNPuvrLSlSfWJ0FUWhjYNOnrsPmzI4/w+/CdTIi4=;
        b=JH5mFMfaaAl/iXfw+E+3zLemDyYMVNXFkr1fe4+JADMGAHRzgFrtri9GK5pkcmyW0K
         5FIOp8DlvQHrlazfwSfOw6G91/ks2b+CAgULxC6tGl+/xgea/15Dz3A3koH0cG9caYVA
         9P1MdSg9wlsbWzGYLxQsJDT5Fmef9Q15gr+HO+WcK3l+V1HQL9R3lLun88UCx/gysECj
         pW4o2WhGafSsT8Nzc6nHRAqPajF6RvgYM0JttiqKz/pwKd8i7m4UwUp/3xczgrvxzL7U
         H2VEXUPaYaxs+RxoRGlE8Znux1a4XHllseB7jIuGG4Xl1wz4gbWgh1zUT2ZCp+a10NJ6
         VoYQ==
X-Gm-Message-State: ALoCoQlduZuyJ1Wx5NPf0i7J+GsM4rFmgtzWrC1HeitaFatfigs8ll6ee5Wy6Q4eK+ssG3R4ro2T
X-Received: by 10.140.26.39 with SMTP id 36mr10809352qgu.61.1404425785048;
        Thu, 03 Jul 2014 15:16:25 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id z15sm16496890qaq.42.2014.07.03.15.16.23
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 03 Jul 2014 15:16:24 -0700 (PDT)
In-Reply-To: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252882>

Interesting!  I wonder if the problem is with the compiler or with my
code.  I don't happen to have a Debian box handy; would it be possible
for you to compile refs.c to assembly language (gcc -S) and send me the
output?  That would help me track down the problem.

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
>=20
> I have attached the output of t5150-request-pull.sh, but in case the
> attachment doesn't go through, I've also pasted it at
> <https://gist.github.com/sunny256/0f6ff7ffee26224dbe12>. This happene=
d
> on two virtual servers (64 bit) hosted on Linode, with this
> configuration:
>=20
> $ lsb_release -a
> No LSB modules are available.
> Distributor ID: Debian
> Description:    Debian GNU/Linux 7.5 (wheezy)
> Release:        7.5
> Codename:       wheezy
>=20
> $ gcc --version
> gcc (Debian 4.7.2-5) 4.7.2
>=20
> Both servers are (of course) updated with new packages from apt-get.
>=20
> The test worked on my laptop which runs Ubuntu Studio 13.10. Have tri=
ed
> recompiling several times, and it fails on Debian every time.
>=20
> git bisect says the bad commit is 6f92e5ff3 ("Merge branch
> 'dt/refs-check-refname-component-sse", 2014-07-02 12:53:07 -0700), bu=
t
> that's a merge. Both parent commits works, so could this be an evil
> merge?
>=20
> When compiling parent commit 745224e test 6 is disabled, could that b=
e
> the reason?
>=20
> Parent commit a02ad88 passes all 7 tests.
>=20
> Cheers,
> =C3=98yvind
