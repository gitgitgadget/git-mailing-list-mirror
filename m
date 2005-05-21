From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 16:46:08 -0400 (EDT)
Message-ID: <2475.10.10.10.24.1116708368.squirrel@linux1>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
    <Pine.LNX.4.58.0505211245580.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050521164608_82285"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 22:45:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZaqF-0007UH-Qx
	for gcvg-git@gmane.org; Sat, 21 May 2005 22:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVEUUqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 16:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVEUUqO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 16:46:14 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:10990 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261597AbVEUUqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 16:46:08 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521204608.SCSI1005.simmts12-srv.bellnexxia.net@linux1>;
          Sat, 21 May 2005 16:46:08 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4LKk5aG022876;
	Sat, 21 May 2005 16:46:07 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 16:46:08 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.58.0505211245580.2206@ppc970.osdl.org>
To: "Linus Torvalds" <torvalds@osdl.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050521164608_82285
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Sat, May 21, 2005 3:47 pm, Linus Torvalds said:
> On Fri, 20 May 2005, Sean wrote:
>>
>>  -u, --unreachable      Show missing objects or deltas
>
> That's the wrong description.
>
> fsck always shows missing objects, but "--unreachable" makes it also show
> objects that cannot be reached from any of the references (either passed
> in on the command line, or the implicit references we take if no explicit
> reference is given).
>
> So in many ways, "--unreachable" is about the _reverse_ of showing missing
> objects: it's about showing _extraneous_ objects that aren't needed by the
> ref that was passed in.

Right, fixed up in attached patch which basically punts with a description
of   "Show unreachable objects", and leaves it to the documentation to do
better.

Sean

------=_20050521164608_82285
Content-Type: plain/text; name="argp-fsck-cache-v4.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="argp-fsck-cache-v4.patch"

SW5kZXg6IERvY3VtZW50YXRpb24vZ2l0LWZzY2stY2FjaGUudHh0Cj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIDg1
ZWMyNTY2NTZhNzgzOWNhN2EyMDY3NzkyYjgyOGM5YjYzYzg3MTEvRG9jdW1lbnRhdGlvbi9naXQt
ZnNjay1jYWNoZS50eHQgIChtb2RlOjEwMDY0NCkKKysrIHVuY29tbWl0dGVkL0RvY3VtZW50YXRp
b24vZ2l0LWZzY2stY2FjaGUudHh0ICAobW9kZToxMDA2NDQpCkBAIC05LDcgKzksOCBAQAogCiBT
WU5PUFNJUwogLS0tLS0tLS0KLSdnaXQtZnNjay1jYWNoZScgWy0tdGFnc10gWy0tcm9vdF0gW1st
LXVucmVhY2hhYmxlXSBbLS1jYWNoZV0gPG9iamVjdD5cKl0KKydnaXQtZnNjay1jYWNoZScgWy0t
dGFnc10gWy0tcm9vdF0gWy0tZGVsdGEtZGVwdGhdIAorCQkJW1stLXVucmVhY2hhYmxlXSBbLS1j
YWNoZV0gPG9iamVjdD5cKl0KIAogREVTQ1JJUFRJT04KIC0tLS0tLS0tLS0tCkBAIC0zNCw2ICsz
NSw5IEBACiAJQ29uc2lkZXIgYW55IG9iamVjdCByZWNvcmRlZCBpbiB0aGUgY2FjaGUgYWxzbyBh
cyBhIGhlYWQgbm9kZSBmb3IKIAlhbiB1bnJlYWNoYWJpbGl0eSB0cmFjZS4KIAorLS1kZWx0YS1k
ZXB0aDo6CisJU2hvdyBsZW5ndGggb2YgbG9uZ2VzdCBkZWx0YSBjaGFpbi4KKwogSXQgdGVzdHMg
U0hBMSBhbmQgZ2VuZXJhbCBvYmplY3Qgc2FuaXR5LCBhbmQgaXQgZG9lcyBmdWxsIHRyYWNraW5n
IG9mCiB0aGUgcmVzdWx0aW5nIHJlYWNoYWJpbGl0eSBhbmQgZXZlcnl0aGluZyBlbHNlLiBJdCBw
cmludHMgb3V0IGFueQogY29ycnVwdGlvbiBpdCBmaW5kcyAobWlzc2luZyBvciBiYWQgb2JqZWN0
cyksIGFuZCBpZiB5b3UgdXNlIHRoZQpJbmRleDogZnNjay1jYWNoZS5jCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IDg1ZWMyNTY2NTZhNzgzOWNhN2EyMDY3NzkyYjgyOGM5YjYzYzg3MTEvZnNjay1jYWNoZS5jICAo
bW9kZToxMDA2NDQpCisrKyB1bmNvbW1pdHRlZC9mc2NrLWNhY2hlLmMgIChtb2RlOjEwMDY0NCkK
QEAgLTEsNSArMSw3IEBACiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAjaW5jbHVkZSA8ZGlyZW50
Lmg+CisjaW5jbHVkZSA8YXJncC5oPgorY29uc3QgY2hhciAqYXJncF9wcm9ncmFtX3ZlcnNpb24g
PSBWRVJTSU9OOwogCiAjaW5jbHVkZSAiY2FjaGUuaCIKICNpbmNsdWRlICJjb21taXQuaCIKQEAg
LTQwNywzNiArNDA5LDQyIEBACiAJZmluZF9maWxlX29iamVjdHMoZ2l0X2RpciwgInJlZnMiKTsK
IH0KIAorc3RhdGljIGNvbnN0IGNoYXIgZG9jW10gPSAiUGVyZm9ybSByZXBvc2l0b3J5IGNvbnNp
c3RlbmN5IGNoZWNrIjsKKworc3RhdGljIHN0cnVjdCBhcmdwX29wdGlvbiBvcHRpb25zW10gPSB7
CisgeyJ1bnJlYWNoYWJsZSIsICd1JywgMCwgMCwgIlNob3cgdW5yZWFjaGFibGUgb2JqZWN0cyJ9
LAorIHsidGFncyIsICd0JywgMCwgMCwgIlNob3cgcmV2aXNpb24gdGFncyJ9LAorIHsicm9vdCIs
ICdyJywgMCwgMCwgIlNob3cgcm9vdCBvYmplY3RzLCBpZS4gdGhvc2Ugd2l0aG91dCBwYXJlbnRz
In0sCisgeyJkZWx0YS1kZXB0aCIsICdkJywgMCwgMCwgIlNob3cgbGVuZ3RoIG9mIGxvbmdlc3Qg
ZGVsdGEgY2hhaW4ifSwKKyB7ImNhY2hlIiwgJ2MnLCAwLCAwLCAiTWFyayBhbGwgb2JqZWN0cyBy
ZWZlcmVuY2VkIGJ5IGNhY2hlIGFzIHJlYWNoYWJsZSJ9LAorIHsgfQorfTsKKworc3RhdGljIGVy
cm9yX3QgcGFyc2Vfb3B0IChpbnQga2V5LCBjaGFyICphcmcsIHN0cnVjdCBhcmdwX3N0YXRlICpz
dGF0ZSkKK3sKKyAgICAgICAgc3dpdGNoIChrZXkpIHsKKyAgICAgICAgY2FzZSAndSc6CQlzaG93
X3VucmVhY2hhYmxlID0gMTsgYnJlYWs7CisgICAgICAgIGNhc2UgJ3QnOgkJc2hvd190YWdzID0g
MTsgYnJlYWs7CisgICAgICAgIGNhc2UgJ3InOgkJc2hvd19yb290ID0gMTsgYnJlYWs7CisgICAg
ICAgIGNhc2UgJ2QnOgkJc2hvd19tYXhfZGVsdGFfZGVwdGggPSAxOyBicmVhazsKKyAgICAgICAg
Y2FzZSAnYyc6CQlrZWVwX2NhY2hlX29iamVjdHMgPSAxOyBicmVhazsKKyAgICAgICAgZGVmYXVs
dDoJCXJldHVybiBBUkdQX0VSUl9VTktOT1dOOworICAgICAgICB9CisgICAgICAgIHJldHVybiAw
OworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGFyZ3AgYXJncCA9IHsgb3B0aW9ucywgcGFyc2Vf
b3B0LCAiW0hFQUQtU0hBMS4uLl0iLCBkb2MgfTsKKwogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQogewogCWludCBpLCBoZWFkczsKIAljaGFyICpzaGExX2RpcjsKKwlpbnQgaWR4Owog
Ci0JZm9yIChpID0gMTsgaSA8IGFyZ2M7IGkrKykgewotCQljb25zdCBjaGFyICphcmcgPSBhcmd2
W2ldOwotCi0JCWlmICghc3RyY21wKGFyZywgIi0tdW5yZWFjaGFibGUiKSkgewotCQkJc2hvd191
bnJlYWNoYWJsZSA9IDE7Ci0JCQljb250aW51ZTsKLQkJfQotCQlpZiAoIXN0cmNtcChhcmcsICIt
LXRhZ3MiKSkgewotCQkJc2hvd190YWdzID0gMTsKLQkJCWNvbnRpbnVlOwotCQl9Ci0JCWlmICgh
c3RyY21wKGFyZywgIi0tcm9vdCIpKSB7Ci0JCQlzaG93X3Jvb3QgPSAxOwotCQkJY29udGludWU7
Ci0JCX0KLQkJaWYgKCFzdHJjbXAoYXJnLCAiLS1kZWx0YS1kZXB0aCIpKSB7Ci0JCQlzaG93X21h
eF9kZWx0YV9kZXB0aCA9IDE7Ci0JCQljb250aW51ZTsKLQkJfQotCQlpZiAoIXN0cmNtcChhcmcs
ICItLWNhY2hlIikpIHsKLQkJCWtlZXBfY2FjaGVfb2JqZWN0cyA9IDE7Ci0JCQljb250aW51ZTsK
LQkJfQotCQlpZiAoKmFyZyA9PSAnLScpCi0JCQl1c2FnZSgiZ2l0LWZzY2stY2FjaGUgWy0tdGFn
c10gW1stLXVucmVhY2hhYmxlXSBbLS1jYWNoZV0gPGhlYWQtc2hhMT4qXSIpOworCWVycm9yX3Qg
cmMgPSBhcmdwX3BhcnNlKCZhcmdwLCBhcmdjLCBhcmd2LCAwLCAmaWR4LCBOVUxMKTsKKwlpZiAo
cmMpIHsKKwkJZnByaW50ZihzdGRlcnIsICJhcmd1bWVudCBmYWlsZWQ6ICVzXG4iLCBzdHJlcnJv
cihyYykpOworCQlyZXR1cm4gMTsKIAl9CiAKIAlzaGExX2RpciA9IGdldF9vYmplY3RfZGlyZWN0
b3J5KCk7CkBAIC00NTAsNyArNDU4LDcgQEAKIAlleHBhbmRfZGVsdGFzKCk7CiAKIAloZWFkcyA9
IDA7Ci0JZm9yIChpID0gMTsgaSA8IGFyZ2M7IGkrKykgeworCWZvciAoaSA9IGlkeDsgaSA8IGFy
Z2M7IGkrKykgewogCQljb25zdCBjaGFyICphcmcgPSBhcmd2W2ldOyAKIAogCQlpZiAoKmFyZyA9
PSAnLScpCg==
------=_20050521164608_82285--


