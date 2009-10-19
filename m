From: "Rolf Bjarne Kvinge" <RKvinge@novell.com>
Subject: Re: Unapplied patches reminder
Date: Mon, 19 Oct 2009 13:57:29 +0200
Organization: Novell
Message-ID: <op.u11p53ryk71drc@linux.home>
References: <20091019052030.6117@nanako3.lavabit.com>
 <7vzl7ogtxs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=----------Deh0UO6WqGgSIwaZJn3BxV
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 13:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzqpn-000347-7i
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 13:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZJSLzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 07:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbZJSLzU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 07:55:20 -0400
Received: from vpn.id2.novell.com ([195.33.99.129]:58164 "EHLO
	gwia-smtp.id2.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750846AbZJSLzT (ORCPT
	<rfc822;groupwise-RKvinge@novell.com;0:0>);
	Mon, 19 Oct 2009 07:55:19 -0400
Received: from linux.home ([::ffff:149.44.117.250])
	by gwia-smtp.id2.novell.com with ESMTP; Mon, 19 Oct 2009 13:42:51 +0100
In-Reply-To: <7vzl7ogtxs.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/10.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130691>

------------Deh0UO6WqGgSIwaZJn3BxV
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit

On Mon, 19 Oct 2009 01:31:59 +0200, Junio C Hamano <gitster@pobox.com> wrote:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Junio, I saw these patches and thought what they try to do were
>> sensible, but I don't them in your tree. I didn't see much discussion
>> on most of them, either.
>>
>> Because I don't read C very well, I may have listed some patches
>> here that you may have discarded because the code was no good, and
>> if so I apologize for wasting your time, but I thought at least
>> some of them should be salvaged.
>> ...
>> From: "Rolf Bjarne Kvinge" <RKvinge@novell.com>
>> Subject: git rev-list --pretty=raw strips empty lines
>> Date: Tue, 06 Oct 2009 14:33:37 +0200
>> Message-ID: <op.u1do6bq5k71drc@linux.lacasa>
>>
>>     It seems like the --pretty=raw format strips off empty newlines from
>>     the beginning of log messages, while I'd expect the raw format to
>>     not do any transformations (just as the documentation says: "The
>>     'raw' format shows the entire commit exactly as stored in the commit
>>     object").
>>
>>     The below changes works for me, not sure if I'm right about this
>>     though (my first time here ;-)
>
> I do not recall seeing this one; most likely it was lost in the noise,
> especially because it did not look like a patch submission, without having
> anything resembling a commit log message.
>
> I think the change itself is an uncontroversial one, even though this
> really changes the behaviour.

My specific need is to be able to get out the exact same log message as I committed, another way of getting the same result would be to implement --pretty=xml (along the lines of subversions 'svn log --xml'). This would prevent behavioural changes. And yes, I'm willing to implement it if you agree it's a good idea.

Regarding the previous patch I just found that it's not complete - git would still print lines with only whitespace as empty lines (i.e. stripping off the whitespace). I'm attaching a revised patch that fixes this issue, but since I found the resulting code slightly ugly, I also found an easier approach: in pretty_print_commit (pretty.c) just print the commit message buffer and return.

Rolf

-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
------------Deh0UO6WqGgSIwaZJn3BxV
Content-Disposition: attachment; filename*0="0001-pretty.c-Don-t-do-any-transformatio";
 filename*1="ns-when-using-the.patch"
Content-Type: application/octet-stream; name*0="0001-pretty.c-Don-t-do-any-transformatio";
 name*1="ns-when-using-the.patch"
Content-Transfer-Encoding: Base64


------------Deh0UO6WqGgSIwaZJn3BxV
Content-Disposition: attachment; filename=0001-pretty.c-special-case-raw-format.patch
Content-Type: application/octet-stream; name=0001-pretty.c-special-case-raw-format.patch
Content-Transfer-Encoding: Base64

RnJvbSA0ZmE5ZTRjMWMxMzNmYmUzNDIzYzk3OWVmZDU3MjJkZDdiZDVkNTMwIE1v
biBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSb2xmIEJqYXJuZSBLdmluZ2Ug
PFJLdmluZ2VAbm92ZWxsLmNvbT4KRGF0ZTogTW9uLCAxOSBPY3QgMjAwOSAxMzoz
MToxNyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIHByZXR0eS5jOiBEb24ndCBkbyBh
bnkgdHJhbnNmb3JtYXRpb25zIHdoZW4gdXNpbmcgdGhlICdyYXcnIGZvcm1hdC4K
CldoZW4gZm9ybWF0dGluZyBjb21taXRzIHdpdGggdGhlICdyYXcnIGZvcm1hdCwg
cHJpbnQgdGhlIGNvbW1pdCBleGFjdGx5IGFzCnN0b3JlZC4KClNpZ25lZC1vZmYt
Ynk6IFJvbGYgQmphcm5lIEt2aW5nZSA8Ukt2aW5nZUBub3ZlbGwuY29tPgotLS0K
IHByZXR0eS5jIHwgICAgNSArKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcHJldHR5LmMg
Yi9wcmV0dHkuYwppbmRleCBmNTk4M2Y4Li45NmRhYzlhIDEwMDY0NAotLS0gYS9w
cmV0dHkuYworKysgYi9wcmV0dHkuYwpAQCAtOTE1LDYgKzkxNSwxMSBAQCB2b2lk
IHByZXR0eV9wcmludF9jb21taXQoZW51bSBjbWl0X2ZtdCBmbXQsIGNvbnN0IHN0
cnVjdCBjb21taXQgKmNvbW1pdCwKIAkJcmV0dXJuOwogCX0KIAorCWlmIChmbXQg
PT0gQ01JVF9GTVRfUkFXKSB7CisJCXN0cmJ1Zl9hZGQoc2IsIG1zZywgc3RybGVu
IChtc2cpKTsKKwkJcmV0dXJuOworCX0KKwogCXJlZW5jb2RlZCA9IHJlZW5jb2Rl
X2NvbW1pdF9tZXNzYWdlKGNvbW1pdCwgJmVuY29kaW5nKTsKIAlpZiAocmVlbmNv
ZGVkKSB7CiAJCW1zZyA9IHJlZW5jb2RlZDsKLS0gCjEuNi41LnJjMi4xNy5nZGJj
MWIuZGlydHkKCg==

------------Deh0UO6WqGgSIwaZJn3BxV--
