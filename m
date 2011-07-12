From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 15/17] revert: Remove sequencer state when no commits are pending
Date: Tue, 12 Jul 2011 11:56:14 +0530
Message-ID: <CALkWK0=5ExB0a_VKY=F6m-q4rx0F-uzCgGywj5zsgY5qWxVZjA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-16-git-send-email-artagnon@gmail.com> <7vvcv8bjmf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWQb-0000fr-Q7
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab1GLG0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:26:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57607 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab1GLG0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:26:36 -0400
Received: by wyg8 with SMTP id 8so3030762wyg.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=USVwruiW3OlSMQ5XZygxRH5Xdxy2Hh8EvAucO3loxmc=;
        b=ukMkubVJYQAQ/7RyyAiD2TXWvEsF3ZfyuQ9fe2lXv98/lisk1LGVXIB81cW7TCR7ry
         wkN4m28H1amKdE9A0gHIGjDipa20EQewpEW1ylIJPgGVXejzyqD/jw9RiTVSJdDyM0MO
         CtR6FB+wb9ySRbbdLpYVj2ZNiAgcniJnvY8nI=
Received: by 10.216.233.211 with SMTP id p61mr4630183weq.107.1310451995506;
 Mon, 11 Jul 2011 23:26:35 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 23:26:14 -0700 (PDT)
In-Reply-To: <7vvcv8bjmf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176927>

SGkgSnVuaW8sCgpKdW5pbyBDIEhhbWFubyB3aXRlczoKPiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8
YXJ0YWdub25AZ21haWwuY29tPiB3cml0ZXM6Cj4+IGRpZmYgLS1naXQgYS9idWlsdGluL3JldmVy
dC5jIGIvYnVpbHRpbi9yZXZlcnQuYwo+PiBpbmRleCBmOWY1ZTNhLi4zOTM2NTE2IDEwMDY0NAo+
PiAtLS0gYS9idWlsdGluL3JldmVydC5jCj4+ICsrKyBiL2J1aWx0aW4vcmV2ZXJ0LmMKPj4gQEAg
LTk5MCw4ICs5OTAsMTggQEAgc3RhdGljIGludCBwaWNrX2NvbW1pdHMoc3RydWN0IGNvbW1pdF9s
aXN0ICp0b2RvX2xpc3QsIHN0cnVjdCByZXBsYXlfb3B0cyAqb3B0cykKPj4gwqAgwqAgwqAgZm9y
IChjdXIgPSB0b2RvX2xpc3Q7IGN1cjsgY3VyID0gY3VyLT5uZXh0KSB7Cj4+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHNhdmVfdG9kbyhjdXIsIG9wdHMpOwo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXMgPSBkb19waWNrX2NvbW1pdChjdXItPml0ZW0sIG9wdHMpOwo+PiAtIMKgIMKgIMKgIMKgIMKg
IMKgIGlmIChyZXMpCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJlcykgewo+PiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICghY3VyLT5uZXh0KQo+PiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIEFuIGVycm9yIHdhcyBlbmNvdW50ZXJlZCB3aGls
ZQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBwaWNr
aW5nIHRoZSBsYXN0IGNvbW1pdDsgdGhlCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAqIHNlcXVlbmNlciBzdGF0ZSBpcyB1c2VsZXNzIG5vdyAtLQo+PiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiB0aGUgdXNlciBz
aW1wbHkgbmVlZHMgdG8gcmVzb2x2ZQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKiB0aGUgY29uZmxpY3QgYW5kIGNvbW1pdAo+PiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKi8KPj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZW1vdmVfc2VxdWVuY2VyX3N0YXRlKCk7Cj4+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiByZXM7Cj4+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgfQo+PiDCoCDCoCDCoCB9Cj4KPiBJdCBtYXkgYmUgdXNlbGVzcyBmb3IgLS1jb250
aW51ZSwgYnV0IHdvdWxkbid0IC0tYWJvcnQgbmVlZCBzb21lIGNsdWUgb24KPiB3aGF0IHlvdSB3
ZXJlIGRvaW5nPwoKSm9uYXRoYW4gcG9pbnRlZCB0aGlzIG91dCB0b28uICBJJ2QgbGlrZSB0byBr
bm93IHdoYXQgeW91IHRoaW5rIG9mIHRoZQphbHRlcm5hdGl2ZXMKMS4gTGF5ZXJpbmcgYSBoYWNr
IG9uIHRvcDogd3JpdGluZyAuZ2l0L3NlcXVlbmNlci90by1yZW1vdmUgb3IKc29tZXRoaW5nIGFz
IHVnbHkuCjIuIFRlYWNoaW5nICJnaXQgY29tbWl0IiB0byByZW1vdmUgdGhlIHNlcXVlbmNlciBz
dGF0ZSBpbnN0ZWFkLgoKQWN0dWFsbHksIGFuICItLWFib3J0IiBjYW4gYmUgdGF1Z2h0IHRvIHdv
cmsgZXZlbiBoZXJlIGJ5IHJlYWRpbmcKLmdpdC9zZXF1ZW5jZXItb2xkL2hlYWQsIGJ1dCB0aGF0
J3MgYXJndWFibHkgdWdseSB0b28uCgotLSBSYW0K
