From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Windows performance / threading file access
Date: Thu, 17 Oct 2013 18:50:42 +0200
Message-ID: <52601562.2090301@gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com> <52570BC1.2040208@gmail.com> <52574B90.3070309@gmail.com> <CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com> <3bb056f6-5f8b-486e-8e5e-9bf541bd0d0b@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org, 
 szager@google.com
To: pro-logic <pro-logic@optusnet.com.au>, msysgit@googlegroups.com
X-From: msysgit+bncBCH3XYXLXQDBBYVKQCJQKGQESQNAR5A@googlegroups.com Thu Oct 17 18:50:44 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBYVKQCJQKGQESQNAR5A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBYVKQCJQKGQESQNAR5A@googlegroups.com>)
	id 1VWqmZ-0006h5-0a
	for gcvm-msysgit@m.gmane.org; Thu, 17 Oct 2013 18:50:43 +0200
Received: by mail-we0-f186.google.com with SMTP id q59sf206750wes.23
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Oct 2013 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=Ur7NF3Lqfi/fpz9Q2ru4g3dFYZrszzBycaqj1cqiKgE=;
        b=NOS1x6O38NN+9XRa46sfzpbgXgua7AtUX7YyTFDXul+J9EP7H8K3azyMErOh2wVCIM
         Itk8IJGxjmUZ7VAa4xwh+5hbpU5ptwYqynihbh35bWon8a0il5GDLB9aFFsa1S1eN5kA
         OJbf9NHAk/iXNrQv5y71sXfv3Lg52yGbIeg65bE5pmVzQlzXyWJvWNgmARA3whhzYwxi
         GCU4W1dMtuHw5kntBtrZy4DzeHp98WPAyhqJ2HTTNUg+42Jclo2RIkF0Fueb2ILbJnhw
         +/MGsT2OKKdA6KNVjXyV7LVWP+r+8Gwvx3bsLncRZfVARAXQc+V0fcRx/r28PL7R78Hr
         CMow==
X-Received: by 10.152.10.74 with SMTP id g10mr47789lab.19.1382028642722;
        Thu, 17 Oct 2013 09:50:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.116.112 with SMTP id jv16ls189722lab.76.gmail; Thu, 17 Oct
 2013 09:50:41 -0700 (PDT)
X-Received: by 10.112.126.162 with SMTP id mz2mr3660634lbb.9.1382028641780;
        Thu, 17 Oct 2013 09:50:41 -0700 (PDT)
Received: from mail-ee0-x230.google.com (mail-ee0-x230.google.com [2a00:1450:4013:c00::230])
        by gmr-mx.google.com with ESMTPS id a1si8221560ees.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 09:50:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::230 as permitted sender) client-ip=2a00:1450:4013:c00::230;
Received: by mail-ee0-f48.google.com with SMTP id e50so283840eek.21
        for <msysgit@googlegroups.com>; Thu, 17 Oct 2013 09:50:41 -0700 (PDT)
X-Received: by 10.14.210.8 with SMTP id t8mr13751595eeo.39.1382028641681;
        Thu, 17 Oct 2013 09:50:41 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id j7sm195198581eeo.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 09:50:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <3bb056f6-5f8b-486e-8e5e-9bf541bd0d0b@googlegroups.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::230
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236299>

Am 16.10.2013 00:22, schrieb pro-logic:
> I also get fairly slow performance out of the checkout / reset=20
> operations on windows.
>=20
> This discussion got me trying to work out what's taking so long on=20
> windows. To help I used killcache [1] to flush the HDD cache and
> Very Sleepy [2] to profile the code. I couldn't use the=20
> GIT_TRACE_PERFORMANCE [3] patch as that seems to only work on script=20
> commands, and in my case I just get a result of "335 seconds git=20
> reset --hard head" from the log.

The trace_performance functions require manual instrumentation of the code =
sections you want to measure, e.g. like this [1]. Output looks like this fo=
r a full WebKit checkout (Win7 x64, Core i7 860, WD VelociRaptor 300, NTFS,=
 no virus scanner, no luafv, no defragger):

trace: at entry.c:128, time: 135.786 s: write_entry::create
trace: at entry.c:129, time: 101.6 s: write_entry::stream
trace: at entry.c:130, time: 0 s: write_entry::read
trace: at entry.c:131, time: 0 s: write_entry::convert
trace: at entry.c:132, time: 0 s: write_entry::write
trace: at entry.c:133, time: 4.71825 s: write_entry::close
trace: at compat/mingw.c:2150, time: 5.68786 s: mingw_lstat (called 661660 =
times)
trace: at compat/mingw.c:2151, time: 259.219 s: command: c:\git\msysgit\git=
\git-checkout.exe -f HEAD

> After running killcache I ran very sleepy connected to git, and=20
> according to the profile: 95.5% of the time is spent in do_lstat=20
> (mingw.c) / NtQueryFullAttributeFile (ntdll)

Very Sleepy confirmed my numbers from above: lstat was always much smaller =
than create/stream/read/write. Could you post details about your test setup=
? Are you still using WebKit for your tests?

> For fun, not knowing if I would break anything or not (it probably=20
> does), I wrapped the entire unpack_trees method in the fscache [4]=20
> and the total git reset --hard head time fell from 335 seconds to 28=20
> seconds, a 11x improvement.

Hmmm...this doesn't work for me at all. Fscache isn't updated during checko=
ut, so lstat-checks whether creating a file or directory succeeded will fai=
l.

$ git config core.fscache true
$ time git checkout -f HEAD
Unlink of file 'Examples' failed. Should I try again? (y/n) n
warning: unable to unlink Examples: Permission denied
fatal: cannot create directory at 'Examples': Permission denied


Karsten

[1] https://github.com/kblees/git/commit/b8eca278

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
