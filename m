From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 05 Jun 2014 03:42:13 +0200
Message-ID: <538FCAF5.7030102@gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Duy Nguyen <pclouds@gmail.com>, Stepan Kasal <kasal@ucw.cz>, 
 GIT Mailing-list <git@vger.kernel.org>,
 Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
 msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBB5EVX6OAKGQEAYM4BWY@googlegroups.com Thu Jun 05 03:42:16 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB5EVX6OAKGQEAYM4BWY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB5EVX6OAKGQEAYM4BWY@googlegroups.com>)
	id 1WsMh5-0003PF-7z
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 03:42:15 +0200
Received: by mail-lb0-f185.google.com with SMTP id w7sf15352lbi.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=8+G1eKv/G1Pr648Um/6YqB9J7AiDCcBfBIY6wAtEZ34=;
        b=Mxoex6JlmE2LP7f6zejiTZJeEtkrjFSuEAjh7OW28jHeReRvJD/E2RBTwINxD9tplO
         rPTUfyj86kaQMXe/PeLziVqMfELKdsALP7zsMRk7I03LyLunzY+qGeSR0GysT8HZLFX/
         oK2OehdBnlYMNLATCpdqJfNLhxfpdbpy2OLlIfmIi2kcsq7anivt2cKRRrWBe32GORX9
         rFqSbdrq7voD7jIJTTyI9qm/aJk8mTVNjvNAHxrBbehtyGXq/WG4toJC/cTysrQHNCz4
         gPyUYLdLi0kmBEtc8UlTqaWWrDARpTV0bTNJPE/5UzYE7d0XWoghrl7KW5BE/9nQWz4G
         0G8Q==
X-Received: by 10.152.43.227 with SMTP id z3mr503417lal.3.1401932533050;
        Wed, 04 Jun 2014 18:42:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.3.67 with SMTP id a3ls4314laa.21.gmail; Wed, 04 Jun 2014
 18:42:11 -0700 (PDT)
X-Received: by 10.112.168.198 with SMTP id zy6mr2925038lbb.15.1401932531744;
        Wed, 04 Jun 2014 18:42:11 -0700 (PDT)
Received: from mail-we0-x22d.google.com (mail-we0-x22d.google.com [2a00:1450:400c:c03::22d])
        by gmr-mx.google.com with ESMTPS id s1si754004wiw.3.2014.06.04.18.42.11
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 18:42:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22d as permitted sender) client-ip=2a00:1450:400c:c03::22d;
Received: by mail-we0-f173.google.com with SMTP id u57so302663wes.18
        for <msysgit@googlegroups.com>; Wed, 04 Jun 2014 18:42:11 -0700 (PDT)
X-Received: by 10.14.211.66 with SMTP id v42mr6765670eeo.1.1401932531500;
        Wed, 04 Jun 2014 18:42:11 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w48sm10327190eel.9.2014.06.04.18.42.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 18:42:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22d
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250801>

Am 04.06.2014 17:46, schrieb Johannes Schindelin:
> Hi kusma,
>=20
> On Wed, 4 Jun 2014, Johannes Schindelin wrote:
>=20
>> The problem arises whenever git.exe calls subprocesses. You can pollute
>> the environment by setting HOME, I do not recall the details, but I
>> remember that we had to be very careful *not* to do that, hence the patc=
h.
>> Sorry, has been a long time.
>=20
> Actually, a quick search in my Applegate vaults^W^Wmail archives suggests
> that we had tons of troubles with non-ASCII characters in the path.
>=20

After a bit of digging in the history and the old googlegroups issue tracke=
r, I think this patch is completely unrelated to the non-ASCII problems.

In summary, this patch fixes 'git config' for the portable version only, an=
d it only does so partially. Thus I don't think its ready for upstream, at =
least not in its current form. See below for the nasty details.


> I would be strongly
> in favor of fixing the problem by the root: avoiding to have Git rely on
> the HOME environment variable to be set, but instead add a clean API call
> that even says what it is supposed to do: gimme the user's home
> directory's path. And that is exactly what the patch does.
>=20

By that argument we'd have to introduce API abstractions for every environm=
ent variable that could possibly resemble a path (PATH, TMPDIR, GIT_DIR, GI=
T_WORK_DIR, GIT_TRACE* etc.).

We already have similar fallback logic for TMPDIR that is completely non-in=
trusive to core git code (fully encapsulated in mingw.c, see mingw_getenv (=
upstream) or mingw_startup (msysgit)). IMO such a solution would be hugely =
preferable over adding an additional get_home_directory() API (and continuo=
usly checking that no new upstream code accidentally introduces another 'ge=
tenv("HOME")').

Cheers,
Karsten

=3D=3D=3D=3D


Analysis of $HOME-realted issues:


1. mangled non-ASCII characters in environment variables

E.g. issue 491 [1], reportedly fixed in v1.7.10 ([1] comment #10).

This is actually a bug in msys.dll, and there's nothing that can be done ab=
out it from within git.exe. It is also not a problem if git is launched fro=
m cmd.exe.

The root cause is that the msys environment is initialized using GetEnviron=
mentStringsA(), which returns GetOEMCP()-encoded strings (e.g. cp850), rath=
er than GetACP() (e.g. cp1252) as all other *A API functions do [2]. This a=
dds one level of mangling whenever a native Windows program starts an msys =
program (so e.g. the call chain bash->git->bash->wish would mangle twice, s=
ee [1] comment #3).

For the fixed GetEnvironmentStringsA(), see [3] lines 459ff.

(As a side note, $HOMEDRIVE and $HOMEPATH originally did not have this prob=
lem, as they were separately initialized from NetUserGetInfoA(). This was c=
hanged in v1.6.3, however, at that time etc/profile was still using the bro=
ken $USERPROFILE. See [4], [5].)


2. 'git config' doesn't work with disconnected network drives

Issues 259 [6], 497 [7] and 512 [8], fixed in v1.7.0.2 for bash and v1.7.2.=
3 for cmd.

Apparently, $HOMEDRIVE$HOMEPATH is the home directory on the network, and $=
USERPROFILE is local. To be able to work offline, we need to check if $HOME=
DRIVE$HOMEPATH exists and fall back to $USERPROFILE otherwise.

Note that git-wrapper does _not_ check if $HOMEDRIVE$HOMEPATH actually exis=
ts, as the original git.cmd did. This is probably a regression wrt issue 25=
9.


3. HOME is not set when using the portable version

Issue 482 [9], partially fixed in v1.7.2.3 by this patch.

'Partially' because:
- there's no fallback to $USERPROFILE, so it doesn't work with disconnected=
 network drives (see problem 2.)
- it doesn't setenv(HOME) for child processes (at least git-gui accesses $e=
nv(HOME) directly, but I haven't checked what happens if HOME is not set)

Incidentally, this patch was first released with v1.7.2.3, which also sets =
$HOME correctly in both etc/profile and git.cmd. So I suspect that this pat=
ch has always been essentially dead code (except perhaps for the portable v=
ersion, I've never used that).


[1] https://code.google.com/p/msysgit/issues/detail?id=3D491
[2] http://msdn.microsoft.com/en-us/library/windows/desktop/ms683187%28v=3D=
vs.85%29.aspx
[3] https://github.com/msysgit/msysgit/blob/msys/src/rt/patches/0013-msys.d=
ll-basic-Unicode-support.patch
[4] https://github.com/msysgit/msysgit/blob/msys/src/rt/patches/0007-only-o=
verride-the-variables-HOMEPATH-and-HOMEDRIVE-i.patch
[5] https://github.com/msysgit/msysgit/commit/6b096c9
[6] https://code.google.com/p/msysgit/issues/detail?id=3D259
[7] https://code.google.com/p/msysgit/issues/detail?id=3D497
[8] https://code.google.com/p/msysgit/issues/detail?id=3D512
[9] https://code.google.com/p/msysgit/issues/detail?id=3D482

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
For more options, visit https://groups.google.com/d/optout.
