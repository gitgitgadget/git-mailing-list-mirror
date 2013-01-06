From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] api-allocation-growing.txt: encourage better variable
 naming
Date: Sun, 06 Jan 2013 12:58:54 -0800
Message-ID: <7vy5g6m3jl.fsf@alter.siamese.dyndns.org>
References: <20130106152716.GB2396@pacific.linksys.moosehall>
 <1357486505-21357-1-git-send-email-git@adamspiers.org>
 <7v38yenjgy.fsf@alter.siamese.dyndns.org>
 <20130106205207.GA6552@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 21:59:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrxJP-0003y3-FM
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 21:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab3AFU67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 15:58:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085Ab3AFU66 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 15:58:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77595B6D1;
	Sun,  6 Jan 2013 15:58:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1SkTsCataUfmxEJqq6HasgRLfYg=; b=Ql0UA6
	IGQTIsMYCAUq1NeN375e+wYbeUry7ApANi99zYWcSeoYDXxSfkBLI5uIhcc5sUcA
	2CTqeE2H7R6I7ePdOhNzYIC/wRK8vox2fsNsE1q0WFKB4y6sCjfpAE6VH4CM6A/m
	ayTmJIkxbgHFefZYqCe7PEUPFR0VkAXIPge34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bdHhal1K4GfpoevtNetUo4XclYFTAyve
	fuHtkJMhxmB+dqaNbf+GIwInKjnTva8vymvuTV/mxeFAUnE7Ix4zhxc1+5DQLYtD
	bWXj4HKfj2JNOBTihJIVOmvscqLsmKaJgOLg3yOFKdh3Qpl0lYjKlyZrnohqa5eT
	v+ovNE8Gwfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68813B6D0;
	Sun,  6 Jan 2013 15:58:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1806B6CE; Sun,  6 Jan 2013
 15:58:56 -0500 (EST)
In-Reply-To: <20130106205207.GA6552@pacific.linksys.moosehall> (Adam Spiers's
 message of "Sun, 6 Jan 2013 20:52:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2F06EE8-5843-11E2-97DC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212841>

Adam Spiers <git@adamspiers.org> writes:

>> Sounds good.  To follow "not type but contents", a further rewrite
>> with s/array/item/ is even better, no?
>
> I agree.

Thanks for a quick response; let's do this then.

-- >8 --
From: Adam Spiers <git@adamspiers.org>

The documentation for the ALLOC_GROW API implicitly encouraged
developers to use "ary" as the variable name for the array which is
dynamically grown.  However "ary" is an unusual abbreviation hardly
used anywhere else in the source tree, and it is also better to name
variables based on their contents not on their type.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-allocation-growing.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-allocation-growing.txt b/Documentation/technical/api-allocation-growing.txt
index 43dbe09..542946b 100644
--- a/Documentation/technical/api-allocation-growing.txt
+++ b/Documentation/technical/api-allocation-growing.txt
@@ -5,7 +5,9 @@ Dynamically growing an array using realloc() is error prone and boring.
 
 Define your array with:
 
-* a pointer (`ary`) that points at the array, initialized to `NULL`;
+* a pointer (`item`) that points at the array, initialized to `NULL`
+  (although please name the variable based on its contents, not on its
+  type);
 
 * an integer variable (`alloc`) that keeps track of how big the current
   allocation is, initialized to `0`;
@@ -13,22 +15,22 @@ Define your array with:
 * another integer variable (`nr`) to keep track of how many elements the
   array currently has, initialized to `0`.
 
-Then before adding `n`th element to the array, call `ALLOC_GROW(ary, n,
+Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
 alloc)`.  This ensures that the array can hold at least `n` elements by
 calling `realloc(3)` and adjusting `alloc` variable.
 
 ------------
-sometype *ary;
+sometype *item;
 size_t nr;
 size_t alloc
 
 for (i = 0; i < nr; i++)
-	if (we like ary[i] already)
+	if (we like item[i] already)
 		return;
 
 /* we did not like any existing one, so add one */
-ALLOC_GROW(ary, nr + 1, alloc);
-ary[nr++] = value you like;
+ALLOC_GROW(item, nr + 1, alloc);
+item[nr++] = value you like;
 ------------
 
 You are responsible for updating the `nr` variable.
-- 
1.8.1.302.g0f4eaa7
