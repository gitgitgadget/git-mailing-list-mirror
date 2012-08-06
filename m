From: karsten.blees@dcon.de
Subject: Re: Re: Re: File path not escaped in warning message
Date: Mon, 6 Aug 2012 19:18:58 +0200
Message-ID: <OF9C260C14.7F8DC09D-ONC1257A52.005D3AD5-C1257A52.005F222E@dcon.de>
References: <2783325c.512962ce.501f69dd.5711e@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	msysgit@googlegroups.com
To: jbialobr <jbialobr@o2.pl>
X-From: msysgit+bncCN2Jst6HAhCK-f-ABRoEpgeUdA@googlegroups.com Mon Aug 06 19:19:12 2012
Return-path: <msysgit+bncCN2Jst6HAhCK-f-ABRoEpgeUdA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2Jst6HAhCK-f-ABRoEpgeUdA@googlegroups.com>)
	id 1SyQxO-0008IB-Tp
	for gcvm-msysgit@m.gmane.org; Mon, 06 Aug 2012 19:19:06 +0200
Received: by lbom4 with SMTP id m4sf862930lbo.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 06 Aug 2012 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:in-reply-to:from:to:cc:subject
         :mime-version:x-mailer:message-id:sender:date:x-mimetrack
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=j4Yeibe3pGSZcKevMj27VrbeXPM4AMnCDxXgfYRXC28=;
        b=SiP1UWdqgYu8Xx2Kc+An7PfeKS3cdu9r2ORga29wTWM9s7j3tJeo2WH77Q/36tz2Lg
         2y+h4UkUO51fOZEbYZtK6mU66VIJWVy3xVkfgQE6PpRp1NRsrIJlimaihV3bJkXoVf9b
         4W8vM3MGHTGv6FPrVnU4/R0sGKAn5b5u++sB8=
Received: by 10.180.105.232 with SMTP id gp8mr681096wib.0.1344273546022;
        Mon, 06 Aug 2012 10:19:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.81.71 with SMTP id y7ls3285078wix.3.gmail; Mon, 06 Aug
 2012 10:19:05 -0700 (PDT)
Received: by 10.180.82.226 with SMTP id l2mr1280773wiy.1.1344273545029;
        Mon, 06 Aug 2012 10:19:05 -0700 (PDT)
Received: by 10.180.82.226 with SMTP id l2mr1280771wiy.1.1344273545019;
        Mon, 06 Aug 2012 10:19:05 -0700 (PDT)
Received: from MAIL.DCON.DE (mail.dcon.de. [77.244.111.98])
        by gmr-mx.google.com with ESMTP id cx9si1951828wib.0.2012.08.06.10.19.04;
        Mon, 06 Aug 2012 10:19:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@dcon.de designates 77.244.111.98 as permitted sender) client-ip=77.244.111.98;
In-Reply-To: <2783325c.512962ce.501f69dd.5711e@o2.pl>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
Sender: msysgit@googlegroups.com
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 06.08.2012 19:18:58,
	Serialize complete at 06.08.2012 19:18:58
X-Original-Sender: karsten.blees@dcon.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of karsten.blees@dcon.de designates 77.244.111.98 as permitted sender) smtp.mail=karsten.blees@dcon.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202971>

Hi Janusz,

It seems you're mixing up a few completely unrelated concepts here.

Core.quotepath enables quoting and escaping of special characters in file=
=20
names. This has nothing to do with character set encoding of file names=20
(i.e. Cp1250/ISO-8859-2/UTF-8). AFAIK, apart from git-svn, git currently=20
doesn't support character set re-coding of file names at all, so=20
core.quotepath and encoding are completely unrelated.

Regarding git-log / git-diff output, there are basically three different=20
character set encodings involved:
1. commit log messages: re-coded to i18n.logoutputencoding (usually UTF-8)
2. file content: printed verbatim (no re-coding); gui tools such as gitk=20
may decode this based on gui.encoding or .gitattributes settings
3. everything else (file names, diff headers, error / warning messages):=20
always UTF-8 (at least in Git for Windows)

Gui tools such as gitk decode this output line by line using the=20
appropriate encoding.


<jbialobr@o2.pl> wrote on 06.08.2012 08:53:17:
> File name is 1=C4=85.txt its content is encoded in windows-1250

File name encoding and file content encoding are completely unrelated.=20
File name encoding in current Git for Windows is *always* UTF-8, file=20
content encoding can be anything.

> Output of git diff after reencoding to windows1250 is:
>
> warning: LF will be replaced by CRLF in 1=C3=84=E2=80=A6.txt.
> The file will have its original line endings in your working directory.

This looks like the file name is UTF-8, but reinterpreted (not reencoded)=
=20
as if it were Cp1250. However, as stated above, you cannot simply=20
interpret the entire git-log / git-diff output as beeing one particular=20
encoding, as the encoding may vary on a line by line basis.

> Here is output from linux:
>
> [janusz@mikrus JavaCommon]$ git config --add core.quotepath false
> [janusz@mikrus JavaCommon]$ git diff  --unified=3D3 -- "1=C4=85.txt"
> warning: LF will be replaced by CRLF in 1<B1>.txt.
> The file will have its original line endings in your working directory.

"<B1>" looks like less's escaping with missing LESSCHARSET setting.

Additionally, your Linux box seems to be set up with ISO-8859-2 system=20
encoding. Git repositories created on this system will not be portable,=20
i.e. using the same repository on other Linux systems, Git for Windows,=20
Cygwin-git, or JGit/EGit will result in completely broken file names. The=
=20
quasi-standard file name encoding in git repositories is UTF-8.

> There is nothing said in the manual, that core.quotepath affects=20
> only header. But it is not the point. You don't know which part of=20
> git output will be consumed by machine. Warning message is addressed
> to human, but it can be consumed by program in the same way as all=20
> other messages and output data.

Error / warning messages may be localized, so they are particularly=20
unsuitable for consumption by other programs. That's why many git commands=
=20
have special switches to make their output machine readable (e.g. -z).=20
Incidentally, 'git-log -z' also disables core.quotepath. So if you write a=
=20
program that parses git output, and you're using the proper 'machine=20
readable' version, you should never have to worry about quoted paths,=20
irrespective of the core.quotepath setting.

> Imho, since warning comes from git, path should be quoted to
> make git behaviour consistent.=20
> From git-log help:
> > Note that we deliberately chose not to re-code the commit log=20
> message when a commit is made to force UTF-8 at the commit object=20
> level, because re-coding to UTF-8 is not necessarily a reversible=20
operation.
>=20
> If re-coding from one encoding to other is not necessarily a=20
> reversible operation, and you can set logoutputencoding to any=20
> encoding you wish, you may loose some charatcers while recoding file
> path in warning message. Quoting it would be desired then.
>=20

The i18n.commitencoding and i18n.logoutputencoding settings only affect=20
commit log messages. They are completely unrelated to error / warning=20
messages, file names, or file name quoting.

Hope that helps,
Karsten

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
