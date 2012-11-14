From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? Subtree merge seems to choke on trailing slashes.
Date: Wed, 14 Nov 2012 12:11:50 -0800
Message-ID: <7vvcd89c6x.fsf@alter.siamese.dyndns.org>
References: <CA+6di1m7OCMjahP9sN3NcYdxLRRi4vmttFa5=pnHrgKp=E4+jQ@mail.gmail.com>
 <CA+6di1nsWOGXjchOc3SZ2FL79zGzgNqjOJyN0zf8Yb8GbXCpbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Jack O'Connor" <oconnor663@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:12:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYjJf-00053u-Mb
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 21:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058Ab2KNULy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 15:11:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932448Ab2KNULx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 15:11:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE0F19F33;
	Wed, 14 Nov 2012 15:11:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bHHWmYqVXy2zJSYJMm/TeSDUfIE=; b=Tma2ro
	3vzSiMsB8dRf4qjXaRgOHgMxHoJZeTpEf6t9U81v/TMDlNZ3KD10ZYVZMnk+I8Vv
	Ys8Uu3O6MtjwZgzOdlTc1arnrRK71TAvKn7dxT2zgebltL3d6dxXjDz33XlbudmQ
	kq+DfBEG77jZ04rwNsJZVjNSjbpw2XQ2psBKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W5qAmmu001dXND2Ep435i/LKixLiyMSp
	5/ADtw8A/6c0RXLJ4BgAdxY1KKoZd2Xmt/LdLnQOCkntVmaD84rhSeTjVuw7fa7J
	I/d1SvY2aOITZKTQTiHdY7XtPwuhv0JiDU5QphWbBntsC2gdlclty5fryzdRoqTr
	5T5appUDgrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAE6C9F31;
	Wed, 14 Nov 2012 15:11:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 273EA9F2F; Wed, 14 Nov 2012
 15:11:52 -0500 (EST)
In-Reply-To: <CA+6di1nsWOGXjchOc3SZ2FL79zGzgNqjOJyN0zf8Yb8GbXCpbA@mail.gmail.com> (Jack
 O'Connor's message of "Tue, 13 Nov 2012 18:17:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 876F2F94-2E97-11E2-A450-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209750>

"Jack O'Connor" <oconnor663@gmail.com> writes:

> Do I have the right list for bug reports? Apologies if not.

Yes.

> On Tue, Nov 6, 2012 at 5:58 PM, Jack O'Connor <oconnor663@gmail.com> wrote:
>>
>> 2) I try to merge more upstream changes on top of that with the
>> following command:
>> git merge --strategy-option=subtree='test/' $upstream_stuff
>> 3) Git fails with an obscure error:
>> fatal: entry  not found in tree daf4d0f0a20b8b6ec007be9fcafeac84a6eba4f0

I'd expect --strategy-option=subtree=./test, ././test (or ./test/
for that matter) would fail in a similar way, too.

What happens if you do not give an unnecessary '/' at the end?

If it works, I'd say that it falls into "dr. it hurts when I twist
my arm this way---don't do it then" category.
