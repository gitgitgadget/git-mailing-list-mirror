From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: cvs2git with modules?
Date: Tue, 17 Jun 2008 11:06:42 -0700
Message-ID: <7f9d599f0806171106rb39f0e0m69f2f70090adb918@mail.gmail.com>
References: <63BEA5E623E09F4D92233FB12A9F794302389A59@emailmn.mqsoftware.com>
	 <4857DC0C.8060902@alum.mit.edu>
	 <7f9d599f0806171102w561ae5bfw594a3bc46eb9c8c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6164_25797891.1213726003019"
Cc: "Kelly F. Hickel" <kfh@mqsoftware.com>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 17 20:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8far-0006s5-NE
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 20:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbYFQSGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 14:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755811AbYFQSGr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 14:06:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:21191 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbYFQSGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 14:06:46 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3497871wri.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type:references
         :x-google-sender-auth;
        bh=zDaolULuzUib5hRnoJoWGyJiWiz5LyZm0Mib2O5MMeM=;
        b=SwkL9BfcJ8WNVWMm29bxSjlGnEgsJY+sCiBNqWe1+pfX5TGMgH5c/z6cyHe45BX8DV
         zzf82H+JIdS3U5pq7IOyw28rAqaDIcVAPTtPQBIKvY8C9jiEcTmnhN29JKLCqA53pIKg
         ljRF6/YNmqO1BCwT3zn4Rk+2O4ux5ataYWWlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:references:x-google-sender-auth;
        b=kXaFvfCu6pkKrIoVJwjH1nuWYsnHzly9qNdWPoAZtrf+YhDZcs7hztycM2eZVTbom5
         mEeYzZOnEhZFwIO+dVmJpxyFiPL7M09B6K/sCg7tIJsGE+Kmv7/HZgopzXrF6XhKv0Uk
         d095f2IRVbjm0FD7I7jDI3blEo/Kynr7OBicM=
Received: by 10.90.93.13 with SMTP id q13mr3089723agb.106.1213726003005;
        Tue, 17 Jun 2008 11:06:43 -0700 (PDT)
Received: by 10.90.97.4 with HTTP; Tue, 17 Jun 2008 11:06:42 -0700 (PDT)
In-Reply-To: <7f9d599f0806171102w561ae5bfw594a3bc46eb9c8c1@mail.gmail.com>
X-Google-Sender-Auth: f30f10e9d0a63e8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85316>

------=_Part_6164_25797891.1213726003019
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Jun 17, 2008 at 11:02 AM, Geoffrey Irving <irving@naml.us> wrote:
> On Tue, Jun 17, 2008 at 8:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [I see you sent essentially the same question to both the git and the
>> cvs2svn mailing lists.  I am replying on the git list with bcc to the
>> cvs2svn list.  Followups please to git@vger.kernel.org.]
>>
>> Kelly F. Hickel wrote:
>>> I'm trying to use cvs2svn in cvs2git mode to convert a repo with a
>>> number of modules.  Can anyone tell me how to keep that module
>>> structure in the new git repo? So, if in cvs there are two modules,
>>> ModA and ModB, I want to see those two as top level directories in
>>> the git repo.
>>>
>>> I've tried putting adding the projects in my options file as below,
>>> but it puts the files ModA/* and ModB/* at the top level in the git repo.
>>>
>>> run_options.add_project(
>>>     r'/home/foo/cvsrepo/ModA,
>>>     trunk_path=ModA',
>>>     [...]
>>>     )
>>>
>>> run_options.add_project(
>>>     r'/home/foo/cvsrepo/ModB,
>>>     trunk_path=ModB',
>>>     [...]
>>>     )
>>
>> I assume that what you mean is that the CVS repository contains
>> directories like ModA/a, ModA/b, ModB/c, and ModB/d, but the resulting
>> git repository has only /a, /b, /c, and /d.  That is because cvs2git
>> completely ignores the trunk_path argument to add_project().
>>
>> It is strange that the code allows you to add multiple projects,
>> considering that the cvs2git documentation[1] states that cvs2git only
>> supports converting single projects at a time.  I guess I forgot to
>> build that check in.
>>
>> You can get the result you want by treating ModA and ModB not as two
>> separate projects, but simply as two separate subdirectories within a
>> bigger project; i.e.,
>>
>> run_options.add_project(
>>    r'/home/foo/cvsrepo,
>>    [...]
>>    )
>>
>> .  This is assuming that ModA and ModB are the only subdirectories
>> within /home/foo/cvsrepo/; otherwise, make a copy of your CVS repo and
>> remove the other subdirectories from the copy before the conversion.
>>
>> Please note that when cvs2git is run this way, it treats tags and
>> branches as being global.  If you tagged your projects simultaneously,
>> then this is probably what you want.  But if you tagged your projects
>> separately, then tag names that happen to be the same across projects
>> will be considered the same.
>>
>> It would be possible to add cvs2git support for multiproject
>> conversions, but I was under the impression that it doesn't make much
>> sense to put multiple projects into a single git repository.  But I'm a
>> novice git user, so I could very well be wrong about that.
>>
>> Michael
>
> I haven't touched cvs2git, but I did modify git-cvsimport to handle
> submodules.  The patch is below.  The idea is that you first convert
> the submodule parts from cvs to git, and then when you convert the
> parent project the submodules are continuously updated based on a
> submodule description file and the dates.
>
> To use it, write a file in the same format as .gitmodules and pass it
> to cvs-import via -E.
>
> I eventually decided that submodules were getting in the way far more
> than they were helping, so I stopped using this.  Perhaps someone else
> will find it useful.

Oops.  Copying and pasting the patch messed it up due to 80 character
wrapping.  Trying again...

Geoffrey

------=_Part_6164_25797891.1213726003019
Content-Type: text/x-patch;
 name=0002-cvsimport-add-support-for-generating-submodules.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhkt3mhx0
Content-Disposition: attachment;
 filename=0002-cvsimport-add-support-for-generating-submodules.patch

RnJvbSA2NTNmZTJlODQ0MDg5M2RhMDZmYTBlYmE5ZmQ1YzJjMjc1NDM1ODk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZW9mZnJleSBJcnZpbmcgPGlydmluZ0BuYW1sLnVzPgpEYXRl
OiBUaHUsIDEyIEp1biAyMDA4IDA3OjM4OjQ5IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gY3ZzaW1w
b3J0OiBhZGQgc3VwcG9ydCBmb3IgZ2VuZXJhdGluZyBzdWJtb2R1bGVzCgpBZGQgYW4gLUUgPHN1
Ym1vZHVsZXM+IG9wdGlvbiB0byBjdnNpbXBvcnQgdG8gZ2VuZXJhdGUgc3VibW9kdWxlIGxpbmtz
IHRvCm90aGVyIGdpdCByZXBvc2l0b3JpZXMgYW5kIHRvIHVwZGF0ZSB0aGVtIGFmdGVyIGVhY2gg
Y29tbWl0IGJhc2VkIG9uIGRhdGUuClRoaXMgaXMgdXNlZnVsIHdoZW4gb25lIGlzIHNwbGl0dGlu
ZyB1cCBhIGN2cyByZXBvc2l0b3J5IGludG8gc2VwYXJhdGUgZ2l0Cm1vZHVsZXMgd2hpY2ggYXJl
IHN0cm9uZ2x5IHJlbGF0ZWQgdG8gZWFjaCBvdGhlci4KLS0tCiBnaXQtY3ZzaW1wb3J0LnBlcmwg
fCAgIDcxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LQogMSBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2dpdC1jdnNpbXBvcnQucGVybCBiL2dpdC1jdnNpbXBvcnQucGVybAppbmRleCBj
YWNiZmMwLi45YjAyODVhIDEwMDc1NQotLS0gYS9naXQtY3ZzaW1wb3J0LnBlcmwKKysrIGIvZ2l0
LWN2c2ltcG9ydC5wZXJsCkBAIC0yOSw4ICsyOSw5IEBAIHVzZSBJUEM6Ok9wZW4yOwogJFNJR3sn
UElQRSd9PSJJR05PUkUiOwogJEVOVnsnVFonfT0iVVRDIjsKIAotb3VyICgkb3B0X2gsJG9wdF9v
LCRvcHRfdiwkb3B0X2ssJG9wdF91LCRvcHRfZCwkb3B0X3AsJG9wdF9DLCRvcHRfeiwkb3B0X2ks
JG9wdF9QLCAkb3B0X3MsJG9wdF9tLEBvcHRfTSwkb3B0X0EsJG9wdF9TLCRvcHRfTCwgJG9wdF9h
LCAkb3B0X3IpOworb3VyICgkb3B0X2gsJG9wdF9vLCRvcHRfdiwkb3B0X2ssJG9wdF91LCRvcHRf
ZCwkb3B0X3AsJG9wdF9DLCRvcHRfeiwkb3B0X2ksJG9wdF9QLCAkb3B0X3MsJG9wdF9tLEBvcHRf
TSwkb3B0X0EsJG9wdF9TLCRvcHRfRSwkb3B0X0wsICRvcHRfYSwgJG9wdF9yKTsKIG15ICglY29u
dl9hdXRob3JfbmFtZSwgJWNvbnZfYXV0aG9yX2VtYWlsKTsKK215ICglc3VibW9kdWxlX3BhdGgs
ICVzdWJtb2R1bGVfdXJsKTsKIAogc3ViIHVzYWdlKDskKSB7CiAJbXkgJG1zZyA9IHNoaWZ0OwpA
QCAtNDAsNyArNDEsNyBAQCBVc2FnZTogJHtcYmFzZW5hbWUgJDB9ICAgICAjIGZldGNoL3VwZGF0
ZSBHSVQgZnJvbSBDVlMKICAgICAgICBbLW8gYnJhbmNoLWZvci1IRUFEXSBbLWhdIFstdl0gWy1k
IENWU1JPT1RdIFstQSBhdXRob3ItY29udi1maWxlXQogICAgICAgIFstcCBvcHRzLWZvci1jdnNw
c10gWy1QIGZpbGVdIFstQyBHSVRfcmVwb3NpdG9yeV0gWy16IGZ1enpdIFstaV0gWy1rXQogICAg
ICAgIFstdV0gWy1zIHN1YnN0XSBbLWFdIFstbV0gWy1NIHJlZ2V4XSBbLVMgcmVnZXhdIFstTCBj
b21taXRsaW1pdF0KLSAgICAgICBbLXIgcmVtb3RlXSBbQ1ZTX21vZHVsZV0KKyAgICAgICBbLUUg
Z2l0bW9kdWxlcy1maWxlXSBbLXIgcmVtb3RlXSBbQ1ZTX21vZHVsZV0KIEVORAogCWV4aXQoMSk7
CiB9CkBAIC04OCw2ICs4OSwyMyBAQCBzdWIgd3JpdGVfYXV0aG9yX2luZm8oJCkgewogCWNsb3Nl
ICgkZik7CiB9CiAKK3N1YiByZWFkX3N1Ym1vZHVsZV9pbmZvKCQpIHsKKwlteSAoJGZpbGUpID0g
QF87CisJb3BlbihteSAkZiwgJy18JywgJ2dpdC1jb25maWcnLCAnLS1maWxlJywgJGZpbGUsICct
LWxpc3QnKQorCQlvciBkaWUgIkZhaWxlZCB0byByZWFkOiAkIVxuIjsKKworCXdoaWxlICg8JGY+
KSB7CisJCS9ec3VibW9kdWxlXC4oXHcrKVwuKHBhdGh8dXJsKT0oLiopJC8KKwkJCW9yIGRpZSAi
VW5rbm93biBzdWJtb2R1bGUgY29uZmlnIGxpbmU6ICRfXG4iOworCQlpZiAoJDIgZXEgJ3BhdGgn
KSB7CisJCQkkc3VibW9kdWxlX3BhdGh7JDF9ID0gJDM7CisJCX0gZWxzZSB7CisJCQkkc3VibW9k
dWxlX3VybHskMX0gPSAkMzsKKwkJfQorCX0KKwljbG9zZSAkZjsKK30KKwogIyBjb252ZXJ0IGdl
dG9wdHMgc3BlY3MgZm9yIHVzZSBieSBnaXQgY29uZmlnCiBzdWIgcmVhZF9yZXBvX2NvbmZpZyB7
CiAgICAgIyBTcGxpdCB0aGUgc3RyaW5nIGJldHdlZW4gY2hhcmFjdGVycywgdW5sZXNzIHRoZXJl
IGlzIGEgJzonCkBAIC0xMTAsNyArMTI4LDcgQEAgc3ViIHJlYWRfcmVwb19jb25maWcgewogCX0K
IH0KIAotbXkgJG9wdHMgPSAiaGFpdm1rdW86ZDpwOnI6Qzp6OnM6TTpQOkE6UzpMOiI7CitteSAk
b3B0cyA9ICJoYWl2bWt1bzpkOnA6cjpDOno6czpNOlA6QTpTOkw6RToiOwogcmVhZF9yZXBvX2Nv
bmZpZygkb3B0cyk7CiBHZXRvcHQ6Okxvbmc6OkNvbmZpZ3VyZSggJ25vX2lnbm9yZV9jYXNlJywg
J2J1bmRsaW5nJyApOwogCkBAIC02MTAsNiArNjI4LDEwIEBAIGlmICgkb3B0X0EpIHsKIAl3cml0
ZV9hdXRob3JfaW5mbygiJGdpdF9kaXIvY3ZzLWF1dGhvcnMiKTsKIH0KIAorIyByZWFkIHN1Ym1v
ZHVsZSBpbmZvCitpZiAoJG9wdF9FKSB7CisJcmVhZF9zdWJtb2R1bGVfaW5mbygkb3B0X0UpOwor
fQogCiAjCiAjIHJ1biBjdnNwcyBpbnRvIGEgZmlsZSB1bmxlc3Mgd2UgYXJlIGdldHRpbmcKQEAg
LTY2NCwxNiArNjg2LDE5IEBAIG9wZW4oQ1ZTLCAiPCRjdnNwc2ZpbGUiKSBvciBkaWUgJCE7CiAK
IG15ICRzdGF0ZSA9IDA7CiAKLXN1YiB1cGRhdGVfaW5kZXggKFxAXEApIHsKK3N1YiB1cGRhdGVf
aW5kZXggKFxAXEBcQCkgewogCW15ICRvbGQgPSBzaGlmdDsKIAlteSAkbmV3ID0gc2hpZnQ7CisJ
bXkgJHN1Ym1vZHVsZXMgPSBzaGlmdDsKIAlvcGVuKG15ICRmaCwgJ3wtJywgcXcoZ2l0LXVwZGF0
ZS1pbmRleCAteiAtLWluZGV4LWluZm8pKQogCQlvciBkaWUgInVuYWJsZSB0byBvcGVuIGdpdC11
cGRhdGUtaW5kZXg6ICQhIjsKIAlwcmludCAkZmgKIAkJKG1hcCB7ICIwIDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBcdCRfXDAiIH0KIAkJCUAkb2xkKSwKIAkJKG1hcCB7
ICcxMDAnIC4gc3ByaW50ZignJW8nLCAkXy0+WzBdKSAuICIgJF8tPlsxXVx0JF8tPlsyXVwwIiB9
Ci0JCQlAJG5ldykKKwkJCUAkbmV3KSwKKwkJKG1hcCB7ICIxNjAwMDAgY29tbWl0ICRfLT5bMF1c
dCRfLT5bMV1cMCIgfQorCQkJQCRzdWJtb2R1bGVzKQogCQlvciBkaWUgInVuYWJsZSB0byB3cml0
ZSB0byBnaXQtdXBkYXRlLWluZGV4OiAkISI7CiAJY2xvc2UgJGZoCiAJCW9yIGRpZSAidW5hYmxl
IHRvIHdyaXRlIHRvIGdpdC11cGRhdGUtaW5kZXg6ICQhIjsKQEAgLTcyMSw3ICs3NDYsNDEgQEAg
c3ViIGNvbW1pdCB7CiAJfQogICAgICAgICAkRU5We0dJVF9JTkRFWF9GSUxFfSA9ICRpbmRleHsk
YnJhbmNofTsKIAotCXVwZGF0ZV9pbmRleChAb2xkLCBAbmV3KTsKKwkjIGFkZCAuZ2l0bW9kdWxl
cyBhbmQgZmluZCBzdWJtb2R1bGUgY29tbWl0cworCW15IEBzdWJtb2R1bGVzOworCWlmICgkb3B0
X0UpIHsKKwkJcHJpbnQgIlVwZGF0ZSAuZ2l0bW9kdWxlc1xuIiBpZiAkb3B0X3Y7CisJCW15ICRw
aWQgPSBvcGVuKG15ICRGLCAnLXwnKTsKKwkJZGllICQhIHVubGVzcyBkZWZpbmVkICRwaWQ7CisJ
CWlmICghJHBpZCkgeworCQkgICAgZXhlYygiZ2l0LWhhc2gtb2JqZWN0IiwgIi13IiwgJG9wdF9F
KQorCQkJCW9yIGRpZSAiQ2Fubm90IGNyZWF0ZSBvYmplY3Q6ICQhXG4iOworCQl9CisJCW15ICRz
aGEgPSA8JEY+OworCQljaG9tcCAkc2hhOworCQljbG9zZSAkRjsKKwkJcHVzaChAbmV3LFswNjQ0
LCAkc2hhLCAiLmdpdG1vZHVsZXMiXSk7CisKKwkJZm9yIG15ICRtIChrZXlzICVzdWJtb2R1bGVf
cGF0aCkgeworCQkJbXkgJHNlYXJjaF9kYXRlID0gJGRhdGUgKyAoZGVmaW5lZCAkb3B0X3ogPyAk
b3B0X3ogOiAzMDApOworCQkJJEVOVnsiR0lUX0RJUiJ9ID0gJHN1Ym1vZHVsZV91cmx7JG19Owor
CQkJb3BlbihteSAkZiwgJy18JywgJ2dpdC1sb2cnLCAiLS1iZWZvcmU9JHNlYXJjaF9kYXRlIiwg
Jy0xJywgJy0tcHJldHR5PWZvcm1hdDolSCAlY3QnKQorCQkJCW9yIGRpZSAiRmFpbGVkIHRvIGV4
dHJhY3Qgc3VibW9kdWxlIGNvbW1pdCBpZDogJCFcbiI7CisJCQkkRU5WeyJHSVRfRElSIn0gPSAk
Z2l0X2RpcjsKKwkJCW15ICRsaW5lID0gPCRmPjsKKwkJCWNsb3NlICRmOworCQkJaWYgKGRlZmlu
ZWQgJGxpbmUpIHsKKwkJCQkkbGluZSA9fiAvXihbXGRhLWZdezQwfSkgKFxkKykkLyBvciBkaWUg
IkZhaWxlZCB0byBwYXJzZSBzdWJtb2R1bGUgbG9nOiAkbGluZVxuIjsKKwkJCQlwdXNoIEBzdWJt
b2R1bGVzLCBbJDEsICRzdWJtb2R1bGVfcGF0aHskbX1dOworCQkJCWlmICgkb3B0X3YpIHsKKwkJ
CQkJbXkgJHN1YmRhdGUgPSBzdHJmdGltZSgiKzAwMDAgJVktJW0tJWQgJUg6JU06JVMiLGdtdGlt
ZSgkMikpOworCQkJCQlwcmludCAiVXBkYXRpbmcgc3VibW9kdWxlICRtIHRvICRzdWJkYXRlXG4i
OworCQkJCX0KKwkJCX0KKwkJfQorCX0KKworCXVwZGF0ZV9pbmRleChAb2xkLCBAbmV3LCBAc3Vi
bW9kdWxlcyk7CiAJQG9sZCA9IEBuZXcgPSAoKTsKIAlteSAkdHJlZSA9IHdyaXRlX3RyZWUoKTsK
IAlteSAkcGFyZW50ID0gZ2V0X2hlYWRyZWYoIiRyZW1vdGUvJGxhc3RfYnJhbmNoIik7Ci0tIAox
LjUuNS4xLjUwOC5nYTAwZjMKCg==
------=_Part_6164_25797891.1213726003019--
