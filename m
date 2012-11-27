From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 02:29:22 +0100
Message-ID: <CAMP44s3HAzSPsrGwcpQpx_3n2aHK5wm++_7_Cbk3qRWMkxDh6g@mail.gmail.com>
References: <20121115212818.GA21558@thyrsus.com>
	<CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
	<20121126220108.GB1713@thyrsus.com>
	<CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
	<20121126234359.GA8042@thyrsus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec54a36f2d14ec004cf6ffaf1
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Nov 27 02:29:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td9zZ-0004RN-Ts
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 02:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab2K0B3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 20:29:24 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52926 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab2K0B3X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 20:29:23 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so11890065oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 17:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SjForsE0fFj9QB0lsN2/oqom3dqYCENS/X7wt6S0Qiw=;
        b=lWkrBKFo1LYdou9EiWuL/Jyp180c3axsDI4U5tDf2OHVhNWpz81w9MIe5hwvuGi/+B
         lbkLqhYqgRyvUg506dm8+heYu4klEJCoG7t/nUhoCGlngoqPFl2YPLg6R/kNElCvCfev
         2VdRd1zsvTP5Ybss5zra5Vx4z8iM7WYkEhROwl4I+/a3L6k93JVwCS70Q9P/qiWaYYXs
         J9HBatIp2Nj9bRQ904NxqV/QbB9d/LbS6HqKQc7cV1F72e6gjAdLQKbcbn59svh9dyir
         8awVAyd8YQRWcSJc8OMKA9SP9n85UJ8N6T38g7BNvBce9Ks3uaQunOTSVHheYIHsv0t5
         NfLA==
Received: by 10.60.169.173 with SMTP id af13mr10788923oec.97.1353979763182;
 Mon, 26 Nov 2012 17:29:23 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 17:29:22 -0800 (PST)
In-Reply-To: <20121126234359.GA8042@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210522>

--bcaec54a36f2d14ec004cf6ffaf1
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 27, 2012 at 12:43 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> Might be easier to just call 'git ls-files --with-three foo', but I
>> don't see the point of those calls:
>
> Ah, much is now explained.  You were looking at an old version.  I had
> in fact already fixed the subdirectories bug (I've updated my
> regression test to check) and have full support for branchy repos,
> preserving tags and branch heads.

So you are criticizing my code saying "it would then be almost
completely useless...", when this is in fact what you sent to the
list.

For the record, here is the output of a test with your script vs.
mine: the output is *exactly the same*:

---
== log ==
* afcbedc (tag: v0.2, master) bump
| * cbd2dce (devel) dev
|/
* 46f1813 (HEAD, test) remove
* df95e41 dot .
* ede0876 with
* d6f10fc extra
* e6362b1 (tag: v0.1) one
== files ==
file
== spaces ==
with

spaces

== dot ==
dot
.

== orig ref ==
refs/heads/test

== script ==
bc9a7d99132f97adeb5d2ca266bd3d8bc64ccb21  /home/felipec/Downloads/gitpacker.txt
Unpacking......(0.13 sec) done.
Packing......(0.28 sec) done.
== log ==
* 5d0b634 (HEAD, master) bump
* 2fe4a6d remove
* 0c27d3b dot .
* 5e36d3f with spaces
* d6f10fc extra
* e6362b1 one
== files ==
file
== spaces ==
with
spaces

== dot ==
dot
.

== orig ref ==
refs/heads/master

== script ==
33edcb28667b683fbb5f8782383f782f73c5e9e1  /home/felipec/bin/git-weave
== log ==
* afcbedc (HEAD, master) bump
* 46f1813 remove
* df95e41 dot .
* ede0876 with
* d6f10fc extra
* e6362b1 one
== files ==
file
== spaces ==
with

spaces

== dot ==
dot
.

== orig ref ==
refs/heads/test
---

Unfortunately, when I enable some testing stuff, this is what your
script throws:
---
== script ==
bc9a7d99132f97adeb5d2ca266bd3d8bc64ccb21  /home/felipec/Downloads/gitpacker.txt
Unpacking......(0.17 sec) done.
Packing......(0.02 sec) done.
Traceback (most recent call last):
  File "/home/felipec/Downloads/gitpacker.txt", line 308, in <module>
    git_pack(indir, outdir, quiet=quiet)
  File "/home/felipec/Downloads/gitpacker.txt", line 171, in git_pack
    command += " ".join(map(lambda p: "-p " + commit_id[int(p)],parents))
  File "/home/felipec/Downloads/gitpacker.txt", line 171, in <lambda>
    command += " ".join(map(lambda p: "-p " + commit_id[int(p)],parents))
IndexError: list index out of range
== log ==
fatal: bad default revision 'HEAD'
== files ==
fatal: tree-ish master not found.
== spaces ==
fatal: ambiguous argument ':/with': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
== dot ==
fatal: ambiguous argument ':/dot': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
== orig ref ==
refs/heads/master
---

I'm attaching it in case you are interested.

Anyway, I can add support for branches and tags in no time, but I
wonder what's the point. Who will take so much time and effort to
generate all the branches and tags, and the log file?

If the goal is as you say "importing older projects that are available
only as sequences of release tarballs", then that code is overkill,
and it's not even making it easier to import the tarballs.

For that case my proposed format:

tag v0.1 gst-av-0.1.tar "Release 0.1"
tag v0.2 gst-av-0.2.tar "Release 0.2"
tag v0.3 gst-av-0.3.tar "Release 0.3"

Would be much more suitable.

>> > It doesn't issue delete ops.
>>
>> What do you mean?
>>
>>     out.puts 'deleteall' <- All current files are removed
>
> Yours emits no D ops for files removed after a particular snapshot.

man git fast-import

---
This command is extremely useful if the frontend does not know (or
does not care to know) what files are currently on the branch, and
therefore cannot generate the proper filedelete commands to update the
content.
---

Why would I want to emit D operations, again, deleteall takes care of that.

>> > Be aware, however, that I consider easy editability by human beings
>> > much more important than squeezing the last microsecond out of the
>> > processing time.  So, for example, I won't use data byte counts rather
>> > than end delimiters, the way import streams do.
>>
>> Well, if there's a line with a single dot in the commit message ('.'),
>> things would go very bad.
>
> Apparently you missed the part where I byte-stuffed the message content.
> It's a technique used in a lot of old-school Internet protocols, notably
> in SMTP.

You might have done that, but the user that generated the log file
might have not.

>> Personally I would prefer something like this:
>
> There's a certain elegance to that, but it would be hard to generate by hand.

You think this is hard to generate by hand:

---
tag v0.1 gst-av-0.1.tar "Release 0.1"
tag v0.2 gst-av-0.2.tar "Release 0.2"
tag v0.3 gst-av-0.3.tar "Release 0.3"
---

Than this?

---
commit 1
directory gst-av-0.1

Release 0.1
.
commit 2
directory gst-av-0.2

Release 0.2
.
commit 3
directory gst-av-0.3

Release 0.3
.
---

After of course, extracting the tarballs, which my script already does
automatically.

> Remember that a major use case for this tool is making repositories
> from projects whose back history exists only as tarballs.

Which is exactly what my script does, except even easier, because it
extracts the tarballs automatically.

> The main objective of the logfile design is to make hand-crafting
> these easy.

What does the above log file achieve, that my log file doesn't?

-- 
Felipe Contreras

--bcaec54a36f2d14ec004cf6ffaf1
Content-Type: application/octet-stream; name=test-gitpacker
Content-Disposition: attachment; filename=test-gitpacker
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ha0ckoub0

IyEvYmluL3NoCgpybSAtcmYgdGVzdCB0ZXN0LXVucGFja2VkKiB0ZXN0LW5ldyoKdGVzdF9kYXRl
PTEKdGVzdF9zdWJkaXI9MQoKdGVzdF90aWNrICgpIHsKCWlmIHRlc3QgLXogIiR7dGVzdF90aWNr
K3NldH0iCgl0aGVuCgkJdGVzdF90aWNrPTExMTI5MTE5OTMKCWVsc2UKCQl0ZXN0ICIkdGVzdF9k
YXRlIiAtZXEgMSB8fCBcCgkJdGVzdF90aWNrPSQoKCR0ZXN0X3RpY2sgKyA2MCkpCglmaQoJR0lU
X0NPTU1JVFRFUl9EQVRFPSIkdGVzdF90aWNrIC0wNzAwIgoJR0lUX0FVVEhPUl9EQVRFPSIkdGVz
dF90aWNrIC0wNzAwIgoJZXhwb3J0IEdJVF9DT01NSVRURVJfREFURSBHSVRfQVVUSE9SX0RBVEUK
fQoKKApnaXQgaW5pdCAtcSB0ZXN0CgpjZCB0ZXN0CmVjaG8gb25lID4gZmlsZQpnaXQgYWRkIGZp
bGUKdGVzdF90aWNrCmdpdCBjb21taXQgLXEgLW0gb25lCmdpdCB0YWcgdjAuMQplY2hvIGV4dHJh
ID4gZXh0cmEKZ2l0IGFkZCBleHRyYQp0ZXN0X3RpY2sKZ2l0IGNvbW1pdCAtcSAtbSBleHRyYQpl
Y2hvIHNwYWNlcyA+PiBmaWxlCnRlc3RfdGljawpnaXQgY29tbWl0IC1xIC1hIC1tICIkKGVjaG8g
LWUgIndpdGhcblxuc3BhY2VzIikiCmVjaG8gZG90ID4+IGZpbGUKdGVzdF90aWNrCmdpdCBjb21t
aXQgLXEgLWEgLW0gIiQoZWNobyAtZSAiZG90XG4uXG4iKSIKaWYgdGVzdCAiJHRlc3Rfc3ViZGly
IiAtZXEgMQp0aGVuCglta2RpciBzdWJkaXIKCWVjaG8gc3ViZGlyID4gc3ViZGlyL2ZpbGUKCWdp
dCBhZGQgc3ViZGlyL2ZpbGUKCXRlc3RfdGljawoJZ2l0IGNvbW1pdCAtcSAtbSBkaXIKCWVjaG8g
c3ViZGlyMiA+PiBmaWxlCgl0ZXN0X3RpY2sKCWdpdCBjb21taXQgLXEgLWEgLW0gc3ViZGlyMgpm
aQpnaXQgcm0gLXEgZXh0cmEKdGVzdF90aWNrCmdpdCBjb21taXQgLXEgLW0gcmVtb3ZlCmdpdCBj
aGVja291dCAtcSAtYiBkZXZlbAplY2hvIGRldiA+PiBmaWxlCnRlc3RfdGljawpnaXQgY29tbWl0
IC1xIC1hIC1tIGRldgpnaXQgY2hlY2tvdXQgLXEgbWFzdGVyCmVjaG8gYnVtcCA+PiBmaWxlCnRl
c3RfdGljawpnaXQgY29tbWl0IC1xIC1hIC1tIGJ1bXAKZ2l0IHRhZyB2MC4yCmdpdCBjaGVja291
dCAtcSAtYiB0ZXN0IG1hc3Rlcl4KCmVjaG8gIj09IGxvZyA9PSIKZ2l0IGxvZyAtLW9uZWxpbmUg
LS1ncmFwaCAtLWRlY29yYXRlIC0tYWxsCmVjaG8gIj09IGZpbGVzID09IgpnaXQgbHMtZmlsZXMg
LS13aXRoLXRyZWUgbWFzdGVyCmVjaG8gIj09IHNwYWNlcyA9PSIKZ2l0IHNob3cgLS1xdWlldCAt
LWZvcm1hdD0nJUInIDovd2l0aAplY2hvICI9PSBkb3QgPT0iCmdpdCBzaG93IC0tcXVpZXQgLS1m
b3JtYXQ9JyVCJyA6L2RvdAopCmVjaG8gIj09IG9yaWcgcmVmID09IgpnaXQgLS1naXQtZGlyPXRl
c3QvLmdpdCBzeW1ib2xpYy1yZWYgSEVBRApnaXQgLS1naXQtZGlyPXRlc3QvLmdpdCBzeW1ib2xp
Yy1yZWYgSEVBRCByZWZzL2hlYWRzL3Rlc3QKCnNjcmlwdD0iL2hvbWUvZmVsaXBlYy9Eb3dubG9h
ZHMvZ2l0cGFja2VyLnR4dCIKCmVjaG8KZWNobyAiPT0gc2NyaXB0ID09IgpzaGExc3VtICRzY3Jp
cHQKCiRQWVRIT05fUEFUSCAkc2NyaXB0IC14IC1pIHRlc3QgLW8gdGVzdC11bnBhY2tlZC0xCiRQ
WVRIT05fUEFUSCAkc2NyaXB0IC1jIC1pIHRlc3QtdW5wYWNrZWQtMSAtbyB0ZXN0LW5ldy0xCgoo
CmNkIHRlc3QtbmV3LTEKZWNobyAiPT0gbG9nID09IgpnaXQgbG9nIC0tb25lbGluZSAtLWdyYXBo
IC0tZGVjb3JhdGUgLS1hbGwKZWNobyAiPT0gZmlsZXMgPT0iCmdpdCBscy1maWxlcyAtLXdpdGgt
dHJlZSBtYXN0ZXIKZWNobyAiPT0gc3BhY2VzID09IgpnaXQgc2hvdyAtLXF1aWV0IC0tZm9ybWF0
PSclQicgOi93aXRoCmVjaG8gIj09IGRvdCA9PSIKZ2l0IHNob3cgLS1xdWlldCAtLWZvcm1hdD0n
JUInIDovZG90CikKZWNobyAiPT0gb3JpZyByZWYgPT0iCmdpdCAtLWdpdC1kaXI9dGVzdC8uZ2l0
IHN5bWJvbGljLXJlZiBIRUFECmdpdCAtLWdpdC1kaXI9dGVzdC8uZ2l0IHN5bWJvbGljLXJlZiBI
RUFEIHJlZnMvaGVhZHMvdGVzdAoKc2NyaXB0PSIkSE9NRS9iaW4vZ2l0LXdlYXZlIgoKZWNobwpl
Y2hvICI9PSBzY3JpcHQgPT0iCnNoYTFzdW0gJHNjcmlwdAoKJHNjcmlwdCAteCAtaSB0ZXN0IC1v
IHRlc3QtdW5wYWNrZWQtMgokc2NyaXB0IC1jIC1pIHRlc3QtdW5wYWNrZWQtMiAtbyB0ZXN0LW5l
dy0yCgooCmNkIHRlc3QtbmV3LTIKZWNobyAiPT0gbG9nID09IgpnaXQgbG9nIC0tb25lbGluZSAt
LWdyYXBoIC0tZGVjb3JhdGUgLS1hbGwKZWNobyAiPT0gZmlsZXMgPT0iCmdpdCBscy1maWxlcyAt
LXdpdGgtdHJlZSBtYXN0ZXIKZWNobyAiPT0gc3BhY2VzID09IgpnaXQgc2hvdyAtLXF1aWV0IC0t
Zm9ybWF0PSclQicgOi93aXRoCmVjaG8gIj09IGRvdCA9PSIKZ2l0IHNob3cgLS1xdWlldCAtLWZv
cm1hdD0nJUInIDovZG90CikKZWNobyAiPT0gb3JpZyByZWYgPT0iCmdpdCAtLWdpdC1kaXI9dGVz
dC8uZ2l0IHN5bWJvbGljLXJlZiBIRUFECmdpdCAtLWdpdC1kaXI9dGVzdC8uZ2l0IHN5bWJvbGlj
LXJlZiBIRUFEIHJlZnMvaGVhZHMvdGVzdAo=
--bcaec54a36f2d14ec004cf6ffaf1--
