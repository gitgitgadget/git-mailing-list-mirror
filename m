From: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
Subject: Re: Bug: Recursive submodules fail when the repo path contains
 spaces
Date: Tue, 24 Jul 2012 13:30:31 -0700
Message-ID: <D842C9D621F44E398A1145EC1B67580C@gmail.com>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
 <500F00C7.4040209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stlke-0005pT-Di
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 22:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab2GXUaf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jul 2012 16:30:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58738 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab2GXUaf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2012 16:30:35 -0400
Received: by pbbrp8 with SMTP id rp8so138647pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=RA9jBcA0e2kGkEdHUvlawSuwwAPMC6u3R3V9Hn+ivHM=;
        b=RwFNKELL7t/YPFZ20aav6GbuyUP1mYMYv4fLD+YalaxdiTF7R+cUET6HlDkTGZQg4u
         yGHQZnJ+4qsU8+q+lOYgqDzxi7zFTx3ysZlKHJumPqMPzhuu0AsvVoVaG6PWlwFLsnoY
         UoBczwkDyrfdeCVJY2OGvmDd3xtZckIm4a3tYfHqroSMDx1Ex055k4OnI1W/OX0t7Xsh
         qLSipFZEsMKaNM5MNqRx8jxVSQ+gM5caoFnEaWTVJ3v2o9oMR2jbeeTpHMXfmTwQW2kw
         cUgQ05lVtTsN9P/4QhdQRw0WG/qbUjQE0WWFBTylH7LkWr0mYzolQNDd9wWmUPT9kjn7
         lD/A==
Received: by 10.68.189.104 with SMTP id gh8mr47347643pbc.152.1343161834855;
        Tue, 24 Jul 2012 13:30:34 -0700 (PDT)
Received: from [10.168.1.100] (c-24-16-145-254.hsd1.wa.comcast.net. [24.16.145.254])
        by mx.google.com with ESMTPS id qr3sm12792645pbc.69.2012.07.24.13.30.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 13:30:34 -0700 (PDT)
In-Reply-To: <500F00C7.4040209@web.de>
X-Mailer: sparrow 1.6.2 (build 1143.6)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202066>

On Tuesday, 24. July 2012 at 13:08, Jens Lehmann wrote:
> Am 24.07.2012 21:01, schrieb Justin Spahr-Summers:
> > This occurs on Mac OS X 10.7.4, on git versions 1.7.10.2 (Apple Git=
-33) and 1.7.11.3.
> > =20
> > Steps:
> > 1. Create or clone a repository to an absolute path that contains s=
paces.
> > 2. Add a submodule to the repository, if it does not already have o=
ne.
> > 3. Within that submodule, attempt to add another submodule.
> > =20
> > The result is an error "fatal: Not a git repository", followed by t=
he relative path to the submodule directory within .git/modules of the =
top-level repository.
> > =20
> > Similarly, using "git submodule update --init --recursive" in a fre=
shly-cloned repository that matches the above configuration will fail w=
ith the same error. "git clone --recursive" does not seem to suffer fro=
m the same problem at clone time, but will still fail to add recursive =
submodules.
> =20
> Hmm, I don't understand how that is different from what t7407 does, i=
t uses
> "git submodule update --init --recursive" in to populate recursive su=
bmodules
> in a freshly cloned repository whose path contains a space (in the tr=
ash
> directory name) in test number 8.
> =20
> Does the git test suite succeed for you? =20
The only test that fails is: =20

*** t7501-commit.sh ***
*** t7502-commit.sh ***
=E2=80=A6
not ok - 13 commit message from template with whitespace issue



(which I assume is unrelated)
