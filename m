From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 05 Jun 2014 16:33:58 +0200
Message-ID: <53907FD6.4060609@gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <alpine.DEB.1.00.1406051354000.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Duy Nguyen <pclouds@gmail.com>, 
 Stepan Kasal <kasal@ucw.cz>,
 GIT Mailing-list <git@vger.kernel.org>, 
 Thomas Braun <thomas.braun@virtuell-zuhause.de>,
 msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCH3XYXLXQDBBVX7YGOAKGQECC2J2HQ@googlegroups.com Thu Jun 05 16:33:59 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBVX7YGOAKGQECC2J2HQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f185.google.com ([74.125.82.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBVX7YGOAKGQECC2J2HQ@googlegroups.com>)
	id 1WsYju-0001eP-TD
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 16:33:58 +0200
Received: by mail-we0-f185.google.com with SMTP id w61sf134581wes.22
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=59waM7w0t9NTM6vexkelv7nFbWRxE3qNZM7Tb+/4n/s=;
        b=H4qJ2MouOGLvIF2kaG3yIuxacplhqyaMZVRbrVoQmL0ECNc/3GvVkLsStRjgLcNIrL
         E4srmKZI5LzWJLM8L80SHK/UyfDD4ho4KXB6az+FiEA7Z+Ogx97Qq/eOGxs9iwCyLNsI
         lRZshhyEvdRivbdqDkre7X6nIt49uHaTuuUJPXJndhAY8d8LSJQAysv1b0VdSHuI5Mik
         GV/8EVgIR61RZQimkGEIv3bbipp2knxXstCrJEP5Ju0G1bcpSdqLxYMJCXm/qbfv0U92
         uZC/7U+qE6fxn0XmoiEHX8ENmlKrR7EH74fUN735yesExcU8TaLs9Q7do5fGHxk4Xqj7
         iPiw==
X-Received: by 10.152.43.202 with SMTP id y10mr21785lal.33.1401978838658;
        Thu, 05 Jun 2014 07:33:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.39 with SMTP id n7ls48283laj.80.gmail; Thu, 05 Jun 2014
 07:33:57 -0700 (PDT)
X-Received: by 10.112.59.136 with SMTP id z8mr6667959lbq.8.1401978837769;
        Thu, 05 Jun 2014 07:33:57 -0700 (PDT)
Received: from mail-we0-x22a.google.com (mail-we0-x22a.google.com [2a00:1450:400c:c03::22a])
        by gmr-mx.google.com with ESMTPS id e12si1350376wiv.1.2014.06.05.07.33.57
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 07:33:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22a as permitted sender) client-ip=2a00:1450:400c:c03::22a;
Received: by mail-we0-x22a.google.com with SMTP id u57so1236528wes.29
        for <msysgit@googlegroups.com>; Thu, 05 Jun 2014 07:33:57 -0700 (PDT)
X-Received: by 10.14.4.199 with SMTP id 47mr8044356eej.9.1401978837648;
        Thu, 05 Jun 2014 07:33:57 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id f3sm14957893eep.40.2014.06.05.07.33.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 07:33:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <alpine.DEB.1.00.1406051354000.14982@s15462909.onlinehome-server.info>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250840>

Am 05.06.2014 14:03, schrieb Johannes Schindelin:
> Hi Karsten,
>=20
> On Thu, 5 Jun 2014, Karsten Blees wrote:
>=20
>> After a bit of digging in the history and the old googlegroups issue
>> tracker, I think this patch is completely unrelated to the non-ASCII
>> problems.
>=20
> Actually, the non-ASCII problems were the trigger for my patch.

The commit message explicitly claims that it fixes issue 482, which is: 'gi=
t config --global' in the portable version fails with "fatal: $HOME not set=
" (not "unable to access '...'", which you would get for a mangled path tha=
t doesn't exist).

As outlined in the previous mail (analysis 1.), the non-ASCII problem is ca=
used by a bug in msys.dll, and it is in fact impossible to fix in git (even=
 if that was your intention).

>=20
>> In summary, this patch fixes 'git config' for the portable version only,
>> and it only does so partially.
>=20
> Care to elaborate?
>=20

See previous mail analysis 3. In short: it doesn't work with disconnected h=
ome share (issue 259), and it doesn't setenv("HOME") (so child processes su=
ch as git-gui will most likely fail).

>> Am 04.06.2014 17:46, schrieb Johannes Schindelin:
>>
>>> I would be strongly in favor of fixing the problem by the root:
>>> avoiding to have Git rely on the HOME environment variable to be set,
>>> but instead add a clean API call that even says what it is supposed to
>>> do: gimme the user's home directory's path. And that is exactly what
>>> the patch does.
>>
>> By that argument we'd have to introduce API abstractions for every
>> environment variable that could possibly resemble a path (PATH, TMPDIR,
>> GIT_DIR, GIT_WORK_DIR, GIT_TRACE* etc.).
>=20
> But of course you are mixing things here. GIT_* are purely Git-specific
> constructs, so there is no possibility for confusion. PATH and TMPDIR nee=
d
> to be handled specially (as does HOME) because we are reusing environment
> variable concepts that pose their own set of problems on Windows because
> of the separator, the path separator and the encoding problems.
>=20
> I understand that it is easy to confuse my want for a API function for th=
e
> home variable with handling for other environment variables. But that HOM=
E
> is an environment variable is not the point at all! It just *happens* to
> be an environment variable on Linux/Unix.
>=20
>> We already have similar fallback logic for TMPDIR that is completely
>> non-intrusive to core git code (fully encapsulated in mingw.c, see
>> mingw_getenv (upstream) or mingw_startup (msysgit)). IMO such a solution
>> would be hugely preferable over adding an additional
>> get_home_directory() API (and continuously checking that no new upstream
>> code accidentally introduces another 'getenv("HOME")').
>=20
> Well, since you mention that TMPDIR hack: this is a hack. We are bending
> over in order for upstream not having to accomodate non-POSIX operating
> systems.

Exactly. In order to support different platforms, we need to agree on a com=
mon abstraction layer to access platform-specific functionality. For the gi=
t project, this common abstraction layer happens to be the POSIX standard (=
actually: the subset of the standard that is used by core git code). And co=
mpat/mingw.c implements that abstraction layer for the native Windows platf=
orm.

There are cases where conforming to the standard is simply not feasible, e.=
g. fork() (we don't want to build another cygwin). So we sometimes need spe=
cial handling for certain functionality in core-git (see run-command.c in c=
ase of fork()).

However, getenv("HOME"), getenv("TMPDIR") and getenv("PATH") are all fully =
POSIX compliant, including the standardised variable names. In this particu=
lar case, conforming to the standard (via special handling in mingw_getenv =
or mingw_startup) is actually even _simpler_ than inventing a new, non-stan=
dard, undocumented get_home_directory() API.

> But how much cleaner would it be if there was an API call with
> varargs. After all, by the reasoning "TMPDIR is a standard on Unix" you
> would also have to special case "/tmp/" in all the open/opendir/etc
> functions because the temporary directory is /tmp/ on Linux/Unix, right?

No, POSIX doesn't specify path names. The standard way to get the temp dire=
ctory is 'getenv("TMPDIR")'. A hardcoded "/tmp" in core git code would be a=
 bug.


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
