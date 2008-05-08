From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: automatically removing missing files beneath a directory
Date: Thu, 8 May 2008 10:12:56 -0700
Message-ID: <7f9d599f0805081012ke0b342ct55a3aac1b37b158a@mail.gmail.com>
References: <7f9d599f0805080939j3ef5e145w9bc2ac94f559b036@mail.gmail.com>
	 <20080508164456.GA29103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1902_1027232.1210266776575"
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 19:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9gi-0001PD-Fd
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 19:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055AbYEHRNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 13:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbYEHRM7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 13:12:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:18069 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbYEHRM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 13:12:58 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1056686rvb.1
        for <git@vger.kernel.org>; Thu, 08 May 2008 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        bh=kiX9Umi4MfAUdC58FK943Ac9dH/muPkm8YerapsxTGo=;
        b=M7rbhTaLw5/O3t3gRzcItbazGvd2fxY/bz1rR5CM1A/bSxosffG9e8h/J3sAhJKF1nQ4IIMv+RkiW0lXzXRJM2C9QcXHuILvm8IicDRY9oB3npLL5daeV+ipqpybcLMlvnOgssY3Of1ihf/U31x5ryo1s39Ok7+qaumDQXdYspk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=pltnWgmgbvNdywiiFvKHpWpUhLLJw0TLfML8Wk1ocaXdiortj/wooG1oLRdjFU2fp5bsNLxRzznFGAffhXtZAo0jkCCmKZpH0RjmH6uo3Tj2R0tzrPe24Z14nkfYvrvx4Pg2SrHTozrqsszdDoLePOjF7lNy04mTlyZ5mkqtWt4=
Received: by 10.141.153.16 with SMTP id f16mr1534069rvo.252.1210266776574;
        Thu, 08 May 2008 10:12:56 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Thu, 8 May 2008 10:12:56 -0700 (PDT)
In-Reply-To: <20080508164456.GA29103@sigill.intra.peff.net>
X-Google-Sender-Auth: 5ca450532db8551a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81539>

------=_Part_1902_1027232.1210266776575
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, May 8, 2008 at 9:44 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 08, 2008 at 09:39:22AM -0700, Geoffrey Irving wrote:
>
>> If I have a subdirectory in a git repository, and I remove some files
>> without telling git, is there is a simple way to automatically run the
>> equivalent of 'git rm' for all the missing files?  git commit -a would
>> work, except that I only want to remove files beneath a particular
>> subdirectory.  git add <directory> does the equivalent operation for
>> adding files, but I don't see a way to automatically remove them
>> without parsing the output of git status.
>
> See "git add -u", which will update the status of all already-tracked
> files in paths you specify. Note that this will also stage changes in
> modified files. If you truly want to just mark all removed files, you
> can do something like:
>
>  git ls-files --deleted -z | xargs -0 git rm
>
> -Peff

Cool.  "git add -u && git add ." does exactly what I want.

This is only indirectly mentioned in the documentation.  If you think
it's reasonable to mention it more explicitly, I've attached a patch.

Thanks,
Geoffrey

------=_Part_1902_1027232.1210266776575
Content-Type: application/octet-stream;
 name=0001-Explicitly-note-in-documentation-that-git-add-u-rem.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffzlblby0
Content-Disposition: attachment;
 filename=0001-Explicitly-note-in-documentation-that-git-add-u-rem.patch

RnJvbSA2OThhMGI3MzQxNjQ3YTBjZTllN2FiYjM2ZmU5MzU3NDAwZTZiYjU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZW9mZnJleSBJcnZpbmcgPGlydmluZ0BuYW1sLnVzPgpEYXRl
OiBUaHUsIDggTWF5IDIwMDggMTA6MDA6MDQgLTA3MDAKU3ViamVjdDogW1BBVENIXSBFeHBsaWNp
dGx5IG5vdGUgaW4gZG9jdW1lbnRhdGlvbiB0aGF0IGdpdC1hZGQgLXUgcmVtb3ZlcyBmaWxlcy4K
Ci0tLQogRG9jdW1lbnRhdGlvbi9naXQtYWRkLnR4dCB8ICAgIDMgKystCiAxIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2dpdC1hZGQudHh0IGIvRG9jdW1lbnRhdGlvbi9naXQtYWRkLnR4dAppbmRleCAzNWU2
N2EwLi5mN2E4YjAzIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2dpdC1hZGQudHh0CisrKyBi
L0RvY3VtZW50YXRpb24vZ2l0LWFkZC50eHQKQEAgLTc0LDcgKzc0LDggQEAgT1BUSU9OUwogCVVw
ZGF0ZSBvbmx5IGZpbGVzIHRoYXQgZ2l0IGFscmVhZHkga25vd3MgYWJvdXQuIFRoaXMgaXMgc2lt
aWxhcgogCXRvIHdoYXQgImdpdCBjb21taXQgLWEiIGRvZXMgaW4gcHJlcGFyYXRpb24gZm9yIG1h
a2luZyBhIGNvbW1pdCwKIAlleGNlcHQgdGhhdCB0aGUgdXBkYXRlIGlzIGxpbWl0ZWQgdG8gcGF0
aHMgc3BlY2lmaWVkIG9uIHRoZQotCWNvbW1hbmQgbGluZS4gSWYgbm8gcGF0aHMgYXJlIHNwZWNp
ZmllZCwgYWxsIHRyYWNrZWQgZmlsZXMgaW4gdGhlCisJY29tbWFuZCBsaW5lLiBGaWxlcyB0aGF0
IGFyZSBtaXNzaW5nIGFyZSByZW1vdmVkIChhcyBpZiAncm0nIGhhZAorCWJlZW4gcnVuKS4gSWYg
bm8gcGF0aHMgYXJlIHNwZWNpZmllZCwgYWxsIHRyYWNrZWQgZmlsZXMgaW4gdGhlCiAJY3VycmVu
dCBkaXJlY3RvcnkgYW5kIGl0cyBzdWJkaXJlY3RvcmllcyBhcmUgdXBkYXRlZC4KIAogXC0tcmVm
cmVzaDo6Ci0tIAoxLjUuNC41Cgo=
------=_Part_1902_1027232.1210266776575--
