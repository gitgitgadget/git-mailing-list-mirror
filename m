From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/2] stash: use "stash--helper"
Date: Fri, 29 Jan 2016 12:21:52 +0100
Message-ID: <20160129112152.GO7100@hank>
References: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
 <0000015289f33e85-713596a1-2718-4c3a-bf3c-4a0f1048d401-000000@eu-west-1.amazonses.com>
 <CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthias Asshauer <mha1993@live.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 12:21:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP77L-0005jv-V0
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 12:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbcA2LV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 06:21:27 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34697 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbcA2LV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 06:21:26 -0500
Received: by mail-wm0-f68.google.com with SMTP id p63so9226087wmp.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 03:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HhjwFwVHlMJ9LCacm6tzdom58gc5BQ6OKunzXZI3xIg=;
        b=Duq1hkN1nIh79ubxcS3Axdk7hr3A4zo8bAozXWXyQsN4X4yvUPr95kM6/StnLGo+vd
         IqwjE6hEx2sIiQ/7F8zBe1etARsDIBYKuOAk3vE+js/BIlDBEe7CHlijNgYZ4l1zUCYU
         3ytqR3ryRssm3x1xhdg/CyQ4Gw1/fqfxgHAzWLEnP2jJ6VbtbqzRFMdc7tZmO7eGoH6b
         xSBQlgrEKUeguaLjt6ARkFOLJgXzuBoqZCR0lmcVsu3xrF8FG+FnuYKgLrvfExWLXn0k
         o/eo5nssxVOwwBOuoPxMwIr6IO7tkbll7eiISts9cAJRA2WY28zMM6az5PloRm0i3yvD
         m3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HhjwFwVHlMJ9LCacm6tzdom58gc5BQ6OKunzXZI3xIg=;
        b=Z6Cm+ehOO4Dx/8hJFgx8TLjTc9s0E0veXkEAT0AKFbUgFNq4k9gntMZ9++jecavxfb
         1tGTdivDQamKhcQY6qd911iHTyIlw2qVywCwvDwmeob7xTxgxI723z2PCqh8N3evwJIZ
         GyxJMPS19iJSY2Ojv6q6Jb/39GyKIyjzD2yW6uXndczaaFdSkLHOrVD+o/AMVMv7g1Lh
         WDWpuo4lEe1+SeOpIFn0KAyE1S7nlO5mOIFD/qVwbvIVbYgXvuyJpzex4kbvjnCyD7G6
         zH2iKbwirYsEykZaAoRYU6xxLFYIIgexoAytwAQOHosPTUMPqTonRVhh9MQD3yMgaO8X
         m67w==
X-Gm-Message-State: AG10YOR/djeAdLD0FM3kSGAeWiqg3/HmK/HsofDAMxBQZd65Pf3Di+xZ0KD11mRUheKtfQ==
X-Received: by 10.28.222.86 with SMTP id v83mr7892974wmg.17.1454066485055;
        Fri, 29 Jan 2016 03:21:25 -0800 (PST)
Received: from localhost (host116-106-dynamic.25-79-r.retail.telecomitalia.it. [79.25.106.116])
        by smtp.gmail.com with ESMTPSA id js8sm15173385wjc.37.2016.01.29.03.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 03:21:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kaPQP+-LpW8ExM2wmfftW4_oa7tB5XdfsdC8XHwH4aFOA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285073>

On 01/28, Stefan Beller wrote:
> On Thu, Jan 28, 2016 at 12:36 PM, Matthias Asshauer <mha1993@live.de>=
 wrote:
> > From: Matthias A=DFhauer <mha1993@live.de>
> >
> > Use the new "git stash--helper" builtin. It should be faster than t=
he old shell code and is a first step to move
> > more shell code to C.
>
> You had some good measurements in the coverletter, which is not going=
 to be
> recorded in the projects history. This part however would be part of =
the commit.
> So you could move the speed improvements here (as well as the other r=
easoning)
> on why this is a good idea. :)

In addition it would be nice to add a performance test in t/perf,
especially since it seems further improvements are planned.  That will
make it easy for everyone to reproduce the performance numbers for
different use-cases.

Matthias, feel free to squash the following (or something similar) in
when you re-roll.

diff --git a/t/perf/p3000-stash.sh b/t/perf/p3000-stash.sh
new file mode 100755
index 0000000..e6e1153
--- /dev/null
+++ b/t/perf/p3000-stash.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description=3D"Test performance of git stash"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+file=3D$(git ls-files | tail -n 30 | head -1)
+
+test_expect_success "prepare repository" "
+	echo x >$file
+"
+
+test_perf "stash/stash pop" "
+	git stash &&
+	git stash pop
+"
+
+test_done
