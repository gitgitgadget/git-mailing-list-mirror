From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: bzr to git syncing
Date: Fri, 28 Aug 2009 18:47:44 +0100
Message-ID: <b2cdc9f30908281047p76c12029u21b100ae6d88fe93@mail.gmail.com>
References: <F84D4C0F-1CEF-4853-84DB-B7927CBE62B3@gmail.com>
	 <b2cdc9f30908280902m22d594bam3c70259d4c296e52@mail.gmail.com>
	 <fabb9a1e0908280919o412baeb1ka69968a93297ca59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d7e744132c7a04723748b3
Cc: git@vger.kernel.org, David Reitter <david.reitter@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh5YI-000300-Fb
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 19:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbZH1Rrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 13:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbZH1Rrp
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 13:47:45 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:37087 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZH1Rro (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 13:47:44 -0400
Received: by ewy2 with SMTP id 2so2342485ewy.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 10:47:45 -0700 (PDT)
Received: by 10.216.85.194 with SMTP id u44mr301998wee.65.1251481664826; Fri, 
	28 Aug 2009 10:47:44 -0700 (PDT)
In-Reply-To: <fabb9a1e0908280919o412baeb1ka69968a93297ca59@mail.gmail.com>
X-Google-Sender-Auth: 173be823a6ef09d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127318>

--0016e6d7e744132c7a04723748b3
Content-Type: text/plain; charset=ISO-8859-1

2009/8/28 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> On Fri, Aug 28, 2009 at 09:02, Alex Bennee<kernel-hacker@bennee.com> wrote:
>> I've attached the fast-import crash I'm seeing. Are you seeing the
>> same sort of failure?
>
> The program you used to generate the stream (I assume git-bzr?) is
> generating an invalid mode, git understands '100644', '100755',
> '120000', and '160000'; the mode in the stream, '040000', is not
> something we understand.

Yeah, it seems in bzr land it mean new directory which we don't care
about. The following patch makes it work. Apologies for failure to
inline but Gmail would just corrupt it if I tried.

I also had to patch the ref check code to accept bzr style branch
names but I suspect that patch should be kept out of the repo.


-- 
Alex, homepage: http://www.bennee.com/~alex/
http://www.half-llama.co.uk

--0016e6d7e744132c7a04723748b3
Content-Type: application/x-httpd-php; 
	name="0001-Handle-new-directory-commands-from-a-bzr-fast-export.patch"
Content-Disposition: attachment; 
	filename="0001-Handle-new-directory-commands-from-a-bzr-fast-export.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyx7ul4e0

RnJvbSA0NDQyZGU2ZmEyNWVmYjI3N2U1MWVmNzYyMzRiZGM4NGQwNjc0NzE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IEJlbm5lZSA8YWxleEBiZW5uZWUuY29tPgpEYXRlOiBG
cmksIDI4IEF1ZyAyMDA5IDE4OjI3OjM3ICswMTAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIEhhbmRs
ZSBuZXcgZGlyZWN0b3J5IGNvbW1hbmRzIGZyb20gYSBienIgZmFzdC1leHBvcnQgc3RyZWFtCgpJ
dCBzZWVtcyB0aGUgYnpyIGZhc3QtZXhwb3J0IGNvbnRhaW5zIGxpbmVzIGxpa2U6CgpNIDA0MDAw
MCAtIGNvbnRlbnQKCldoaWNoIGluZGljYXRlIHRoZSBjcmVhdGlvbiBvZiBhIG5ldyBkaXJlY3Rv
cnkuIE90aGVyIHZhbHVlcyBkbyBleGlzdApmb3Igc3ltbGlua3MgYW5kIHRyZWUgcmVmZXJlbmNl
cyBidXQgSSBoYXZlIHJlZnJhaW5lZCBmcm9tIGRlYWxpbmcKd2l0aCB0aGVtIGhlcmUuCgpBcyBn
aXQgZG9lc24ndCBkZWFsIHdpdGggZGlyZWN0b3JpZXMgYXMgc3VjaCB3ZSB0YWtlIHRoZSBvcHBv
cnR1bml0eQp0byByZXR1cm4gYW5kIGlnbm9yZSB0aGUgY29tbWFuZCBiZWluZyBwcm9jZXNzZWQu
Ci0tLQogZmFzdC1pbXBvcnQuYyB8ICAgIDUgKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zhc3QtaW1wb3J0LmMgYi9m
YXN0LWltcG9ydC5jCmluZGV4IDdlZjk4NjUuLjFjYTg4NGUgMTAwNjQ0Ci0tLSBhL2Zhc3QtaW1w
b3J0LmMKKysrIGIvZmFzdC1pbXBvcnQuYwpAQCAtMTg3NSw4ICsxODc1LDExIEBAIHN0YXRpYyB2
b2lkIGZpbGVfY2hhbmdlX20oc3RydWN0IGJyYW5jaCAqYikKIAljYXNlIFNfSUZHSVRMSU5LOgog
CQkvKiBvayAqLwogCQlicmVhazsKKwljYXNlIDA0MDAwMDoKKwkJLyogc2tpcCBuZXcgZGlyICov
CisJCXJldHVybjsKIAlkZWZhdWx0OgotCQlkaWUoIkNvcnJ1cHQgbW9kZTogJXMiLCBjb21tYW5k
X2J1Zi5idWYpOworCQlkaWUoIkNvcnJ1cHQgKHVua25vd24pIG1vZGU6ICVzIiwgY29tbWFuZF9i
dWYuYnVmKTsKIAl9CiAKIAlpZiAoKnAgPT0gJzonKSB7Ci0tIAoxLjYuNAoK
--0016e6d7e744132c7a04723748b3
Content-Type: application/x-httpd-php; 
	name="0002-Allow-in-a-branch-name.patch"
Content-Disposition: attachment; 
	filename="0002-Allow-in-a-branch-name.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyx7v1rv1

RnJvbSBhMGY4Yjc2MDA4Y2QwNDUxMzAxYzBmOGY0ZWFhYTVmMDBlOWEzNjQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IEJlbm5lZSA8YWxleEBiZW5uZWUuY29tPgpEYXRlOiBG
cmksIDI4IEF1ZyAyMDA5IDE4OjM0OjMxICswMTAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIEFsbG93
IH4gaW4gYSBicmFuY2ggbmFtZQoKSSdtIG5vdCBzdXJlIGFib3V0IHRoaXMgb25lLCBob3dldmVy
IGl0cyBxdWl0ZSBjb21tb24gZm9yIGJ6ciBpbXBvcnRzCnRvIGhhdmUgYnJhbmNoIG5hbWVzIGxp
a2U6CgowLjh+YTEtMHVidW50dTEKCldoaWNoIHRoZW4gY2F1c2VzIGdpdCBmYXN0LWltcG9ydCB0
byBjaG9rZSBhbmQgcHJldHR5IG11Y2ggYW55IFVidW50dQpienIgcmVwb3NpdG9yeSBpbXBvcnQu
IEhvd2V2ZXIgSSBkb24ndCBrbm93IGhvdyBkYW5nZXJvdXMgcmVtb3ZpbmcgdGhlCmNoZWNrIGlz
LiBJIHN1c3BlY3QgaXQgbWF5IGJlIGJldHRlciB0byBzYW5pdGlzZSB0aGUgdGFnIGluc3RlYWQu
Ckhvd2V2ZXIgdGhpcyBwYXRjaCBXRk0gb24gd2hhdCBJIHdhcyBsb29raW5nIGF0LgotLS0KIHJl
ZnMuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3JlZnMuYyBiL3JlZnMuYwppbmRleCBlNDllYWEzLi41ZmJk
NWI3IDEwMDY0NAotLS0gYS9yZWZzLmMKKysrIGIvcmVmcy5jCkBAIC02ODksNyArNjg5LDcgQEAg
aW50IGZvcl9lYWNoX3Jhd3JlZihlYWNoX3JlZl9mbiBmbiwgdm9pZCAqY2JfZGF0YSkKIHN0YXRp
YyBpbmxpbmUgaW50IGJhZF9yZWZfY2hhcihpbnQgY2gpCiB7CiAJaWYgKCgodW5zaWduZWQpIGNo
KSA8PSAnICcgfHwKLQkgICAgY2ggPT0gJ34nIHx8IGNoID09ICdeJyB8fCBjaCA9PSAnOicgfHwg
Y2ggPT0gJ1xcJykKKyAgICAgICAgICAgIGNoID09ICdeJyB8fCBjaCA9PSAnOicgfHwgY2ggPT0g
J1xcJykKIAkJcmV0dXJuIDE7CiAJLyogMi4xMyBQYXR0ZXJuIE1hdGNoaW5nIE5vdGF0aW9uICov
CiAJaWYgKGNoID09ICc/JyB8fCBjaCA9PSAnWycpIC8qIFVuc3VwcG9ydGVkICovCi0tIAoxLjYu
NAoK
--0016e6d7e744132c7a04723748b3--
