From: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Sat, 10 Nov 2012 13:13:53 -0800 (PST)
Message-ID: <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
 <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_286_27308070.1352582033821"
Cc: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>, 
	Git List <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>
To: msysgit@googlegroups.com
X-From: msysgit+bncBCX3HZP5V4BRBEUH7OCAKGQEGT5ZSDI@googlegroups.com Sat Nov 10 22:14:06 2012
Return-path: <msysgit+bncBCX3HZP5V4BRBEUH7OCAKGQEGT5ZSDI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ia0-f186.google.com ([209.85.210.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCX3HZP5V4BRBEUH7OCAKGQEGT5ZSDI@googlegroups.com>)
	id 1TXINR-0004NC-4w
	for gcvm-msysgit@m.gmane.org; Sat, 10 Nov 2012 22:14:05 +0100
Received: by mail-ia0-f186.google.com with SMTP id k10sf3867112iag.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 10 Nov 2012 13:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:x-original-sender:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=ynHMT8Yi+hP4vG5sWOtlN8gaJ7KbbEhfizuHDcsEWxw=;
        b=kta5qnCjnaCtm++oizFv2tjnbM8G/b5aAcOAwzY7mwbLUev+iSdhk/7RWApDi0+FMy
         GuXI53mUIxFaFp4tkXs0BxXiC1Fvcuzvx/slXs1TXs4N00DRpNslhoMbIxaos1nDoFGo
         ISOtudKajicttVCQb4LTpLPv7reuewo7vIWV1qlq9XGw2zVgXQFQZEbS7qFOWpxwQhbV
         Xgh3RRCb6HUums/Ydj6ZRioQYazRaoG8pHOpzpwU3xT2TPfZZ6bt5Dry+tgHbdFEr09B
         2VB8lfT+43BhFYI89rMvpAPOZK4Zozv+cuGy41DfUo46pXqh6cMjzYY1iuchCveYI2Yu
         YNFQ==
Received: by 10.52.175.73 with SMTP id by9mr2983548vdc.1.1352582034936;
        Sat, 10 Nov 2012 13:13:54 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.7.200 with SMTP id e8ls6087079vce.9.gmail; Sat, 10 Nov
 2012 13:13:54 -0800 (PST)
Received: by 10.52.96.71 with SMTP id dq7mr2999346vdb.11.1352582034079;
        Sat, 10 Nov 2012 13:13:54 -0800 (PST)
In-Reply-To: <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
X-Original-Sender: jeanjacques.lafay@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209307>

------=_Part_286_27308070.1352582033821
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le samedi 10 novembre 2012 21:00:10 UTC+1, Philip Oakley a =E9crit :

> From: "Jean-Jacques Lafay" <jeanjacq...@gmail.com <javascript:>> Sent:=20
> Saturday,=20
> November 10, 2012 5:36 PM=20
> > In large repos, the recursion implementation of contains(commit,=20
> > commit_list)=20
> > may result in a stack overflow. Replace the recursion with a loop to=20
> > fix it.=20
> >=20
> > Signed-off-by: Jean-Jacques Lafay <jeanjacq...@gmail.com <javascript:>>=
=20
>
> This is a change to the main git code so it is better to submit it to=20
> the main git list at g...@vger.kernel.org <javascript:> (plain text, no=
=20
> HTML, first=20
> post usually has a delay ;-)=20
>
> It sounds reasonable but others may have opinions and comments.=20
>
> Have you actually suffered from the stack overflow issue? You only=20
> suggest it as a possibility, rather than a real problem.=20
>
> Philip=20
>

Yes, it actually crashed on me, and since the call is made by GitExtension=
=20
while browsing the commit history, it was quickly annoying to have windows=
=20
popping a "git.exe stopped working" message box at my face every time I=20
clicked on a line of the history ;-)  (well, you can sort of work around it=
=20
by having the "file tree" or "diff" tab active)

Coincidentally, as I was having a glance at the recent topics, I saw that=
=20
someone else experienced it.

However, I couldn't reproduce it on Linux : where the windows=20
implementations crashes at a ~32000 depth (*not* exactly 32768, mind you),=
=20
on linux it happily went through 100000 commits. I didn't take time to look=
=20
much further, but maybe on my 64 bit Linux VM, the process can afford to=20
reserve a much bigger address range for the stack of each thread than the=
=20
1Mb given to 32 bit processes on windows.
=20
Jean-Jacques.

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

------=_Part_286_27308070.1352582033821
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le samedi 10 novembre 2012 21:00:10 UTC+1, Philip Oakley a =E9crit&nbsp;:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;b=
order-left: 1px #ccc solid;padding-left: 1ex;">From: "Jean-Jacques Lafay" &=
lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"IaCrn=
fg-MOcJ">jeanjacq...@gmail.com</a>&gt; Sent: Saturday,=20
<br>November 10, 2012 5:36 PM
<br>&gt; In large repos, the recursion implementation of contains(commit,=
=20
<br>&gt; commit_list)
<br>&gt; may result in a stack overflow. Replace the recursion with a loop =
to=20
<br>&gt; fix it.
<br>&gt;
<br>&gt; Signed-off-by: Jean-Jacques Lafay &lt;<a href=3D"javascript:" targ=
et=3D"_blank" gdf-obfuscated-mailto=3D"IaCrnfg-MOcJ">jeanjacq...@gmail.com<=
/a>&gt;
<br>
<br>This is a change to the main git code so it is better to submit it to=
=20
<br>the main git list at <a href=3D"javascript:" target=3D"_blank" gdf-obfu=
scated-mailto=3D"IaCrnfg-MOcJ">g...@vger.kernel.org</a> (plain text, no HTM=
L, first=20
<br>post usually has a delay ;-)
<br>
<br>It sounds reasonable but others may have opinions and comments.
<br>
<br>Have you actually suffered from the stack overflow issue? You only=20
<br>suggest it as a possibility, rather than a real problem.
<br>
<br>Philip
<br></blockquote><div><br></div><div>Yes, it actually crashed on me, and si=
nce the call is made by GitExtension while browsing the commit history, it =
was quickly annoying to have windows popping a "git.exe stopped working" me=
ssage box at my face every time I clicked on a line of the history ;-)&nbsp=
;&nbsp;(well, you can sort of work around it by having the "file tree" or "=
diff" tab active)</div><div><br></div><div>Coincidentally, as I was having =
a glance at the recent topics, I saw that someone else experienced it.</div=
><div><br></div><div>However, I couldn't reproduce it on Linux : where the =
windows implementations crashes at a ~32000 depth (*not* exactly 32768, min=
d you), on linux it happily went through 100000 commits. I didn't take time=
 to look much further, but maybe on my 64 bit Linux VM, the process can aff=
ord to reserve a much bigger address range for the stack of each thread tha=
n the 1Mb given to 32 bit processes on windows.</div><div>&nbsp;</div><div>=
Jean-Jacques.</div><div><br></div>

<p></p>

-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />

------=_Part_286_27308070.1352582033821--
