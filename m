From: John Benes <smartcat99s@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 22:01:29 -0600
Message-ID: <437D5219.6060300@gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>	<b0943d9e0511160311k725526d8v@mail.gmail.com>	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>	<7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com> <7vfypur5jb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 05:01:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcxRc-0008MK-Ex
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 05:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVKREBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 23:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVKREBq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 23:01:46 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:44563 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932460AbVKREBp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 23:01:45 -0500
Received: by zproxy.gmail.com with SMTP id 13so100906nzn
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:01:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=kQWi30G5rEKXqAo02OXKtxuyET2sNUgLls0iYKwiEffrUSFPWR46cBQy+ouD+Pn9+AYl7HLMgkHGPEfEonENJDel1FpIQ6oodnf0ZFF2Ly2Ya3yBffKY68tsulnNznMjJqh8jpGIue9b5NWJd6STMS0O83xgM2bAAhpdxWr0Alk=
Received: by 10.36.24.5 with SMTP id 5mr8364680nzx;
        Thu, 17 Nov 2005 20:01:45 -0800 (PST)
Received: from ?192.168.0.198? ( [68.96.128.241])
        by mx.gmail.com with ESMTP id 8sm390138nzn.2005.11.17.20.01.42;
        Thu, 17 Nov 2005 20:01:45 -0800 (PST)
User-Agent: Thunderbird 1.5 (Windows/20051117)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7vfypur5jb.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12191>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> John Benes <smartcat99s AT gmail DOT com> writes:
>> Commit ID's used for testing:
>> refs/heads/master	4e1da85d7d0480b6d9973317da4f7a5aa603fcb5
>> refs/heads/pu		3b4587eb3c549649af7e84659b4808003c34c2d3
> 
> Thanks.  But the test result look suspicious for pu.

I verified that I was testing that commit, and the ls-tree results.
Must have been left over after switching from master...

> Anyway, the master is more important at this point.

> So it fails on these binary diffs with full index tests.  Could
> you try running it like this?
> 
> 	$ cd t
>         $ sh ./t4103-apply-binary.sh -i -v
> 
> If all things being equal, this will stop at the first failing
> test "* FAIL 7: ", and you will have trash/ directory under t/.
> 
> 	$ cd trash
> 	$ ls -l
> 
> I would first want to see if it was diff that failed or the
> apply.  What does BF.diff contain?
> 

Output from the commands requested:

Twinkie@squirrel ~/git/t
$ sh ./t4103-apply-binary.sh -i -v
sh ./t4103-apply-binary.sh -i -v
* expecting success: git-checkout master
         git-apply --stat --summary B.diff
 file1 |    4 ++--
 file2 |    5 -----
 file3 |    0
 file4 |    0
 4 files changed, 2 insertions(+), 7 deletions(-)
 delete mode 100644 file2
 create mode 100644 file3
*   ok 1: stat binary diff -- should not fail.
* expecting success: git-checkout master
         git-apply --stat --summary C.diff
 file1 |    4 ++--
 file2 |    5 -----
 file3 |    0
 file4 |    0
 4 files changed, 2 insertions(+), 7 deletions(-)
 delete mode 100644 file2
 copy file1 => file3 (70%)
*   ok 2: stat binary diff (copy) -- should not fail.
* expecting failure: git-checkout master
         git-apply --check B.diff
fatal: patch with only garbage at line 30
*   ok 3: check binary diff -- should fail.
* expecting failure: git-checkout master
         git-apply --check C.diff
fatal: patch with only garbage at line 32
*   ok 4: check binary diff (copy) -- should fail.
* expecting failure: git-checkout master
         git-apply --check --allow-binary-replacement B.diff
fatal: patch with only garbage at line 30
*   ok 5: check incomplete binary diff with replacement -- should fail.
* expecting failure: git-checkout master
         git-apply --check --allow-binary-replacement C.diff
fatal: patch with only garbage at line 32
*   ok 6: check incomplete binary diff with replacement (copy) -- should
fail.
* expecting success: git-checkout master
         git-apply --check --allow-binary-replacement BF.diff
fatal: patch with only garbage at line 30
* FAIL 7: check binary diff with replacement.
        git-checkout master
                 git-apply --check --allow-binary-replacement BF.diff

Twinkie@squirrel ~/git/t
$ cd trash
cd trash

Twinkie@squirrel ~/git/t/trash
$ ls -l
ls -l
total 19
- -rw-r--r--  1 Twinkie None  909 Nov 17 21:49 B.diff
- -rw-r--r--  1 Twinkie None 1173 Nov 17 21:49 BF.diff
- -rw-r--r--  1 Twinkie None  944 Nov 17 21:49 C.diff
- -rw-r--r--  1 Twinkie None 1208 Nov 17 21:49 CF.diff
- -rw-r--r--  1 Twinkie None  201 Nov 17 21:49 file1
- -rw-r--r--  1 Twinkie None  201 Nov 17 21:49 file2
- -rw-r--r--  1 Twinkie None  201 Nov 17 21:49 file4

Twinkie@squirrel ~/git/t/trash
$ cat BF.diff
cat BF.diff
diff --git a/file1 b/file1
index
edc575dec543a684da5007b43886ee32ecb381ae..af1eedd35be991f3ced320f7d927799c
72cd8435 100644
- --- a/file1
+++ b/file1
@@ -1,5 +1,5 @@
- -A quick brown fox jumps over the lazy dog.
+A quick brown fov jumps over the lazy dog.
 A tiny little penguin runs around in circles.
- -There is a flag with Linux written on it.
+There is a flag with Linuv written on it.
 A slow black-and-white panda just sits there,
 munching on his bamboo.
diff --git a/file2 b/file2
deleted file mode 100644
index
edc575dec543a684da5007b43886ee32ecb381ae..00000000000000000000000000000000
00000000
- --- a/file2
+++ /dev/null
@@ -1,5 +0,0 @@
- -A quick brown fox jumps over the lazy dog.
- -A tiny little penguin runs around in circles.
- -There is a flag with Linux written on it.
- -A slow black-and-white panda just sits there,
- -munching on his bamboo.
diff --git a/file3 b/file3
new file mode 100644
index
0000000000000000000000000000000000000000..adb07b7ad3fa2c63251b06d1d39cb90a
85b860b4
Files /dev/null and b/file3 differ
diff --git a/file4 b/file4
index
edc575dec543a684da5007b43886ee32ecb381ae..adb07b7ad3fa2c63251b06d1d39cb90a
85b860b4 100644
Files a/file4 and b/file4 differ

Twinkie@squirrel ~/git/t/trash
$ git-apply BF.diff
fatal: patch with only garbage at line 30

- --
John Benes
GPG Fingerprint: D519 25DB BB5C 38FC 9D02  02E7 596D BC50 F880 27FA
"It is not only the living who are killed in war." - Isaac Asimov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBQ31SGGF0oWcU9kCNAQJmchAA0L9fnTvMNwYhDHRVdPyF6XQYJJ7j3s6M
CtcjFvQZ0Zo2tp3ZZ8mqv9ANgPkV80HZFpWPwmlAouFQfNbjvEDlFxLejaKZ5TJj
q068iMk8ZmUUHKPUhONhCsi/toXHQuhA7RMWEwtE9EeugOOIC/++eI8qhKzBhJr3
REzLQN55lqrdhN/6ksrhJQU2VQ3AcAukgezrJy3j8CYOId3pVLYoyD75oxTrelnN
xSPritxM/zkdQZYwx/WeSFRivQQZgiSwm2nREJ5NY5MJ8X5SIZJ+bcHSnndNmUYv
e6YkZRPLXQBAyJpQHwmAQIqtYikPZ/Q6SNBoiQgA3Ws1SyzSaMcOo9R30Cg4LT4i
37EtQwjrGXzY6V/YlHbPqauPlUW6Sosc7fadNXHXkJJrdgyGSATZghh+XEZpNQ1G
2cS05y7/Xu9KnhL0GxbwLf9FZg14CndRh04NDtkdvwyE5rK9SCD5seW6HQOeBcuX
oHLPeA29IaZvHFUYTITXP5p2ZySAXrrFt7R532j6njeJvVCRzV7pPh7msHmAgdXL
Wz5Xv9ED43wz+q6JpXuWloYNyDKUUil2emXVA/MHwLW9ugfZmu9/OVo2ChXf+ZLH
8pSGxRmxTAVSf0GIiODPMWmGrm2zsKbNczCY1wATjiRaYvlmRk1kiXpXpubW5bw9
F1UDCLIFaJk=
=Uh0t
-----END PGP SIGNATURE-----
