From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 02 May 2011 09:46:27 -0700
Message-ID: <7v7ha9oxss.fsf@alter.siamese.dyndns.org>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
 <BANLkTi=NOaWN56qBACoTE2WQWFM3rHXfWA@mail.gmail.com>
 <BANLkTikvYLKKj_Wd0EOxZh+vANxju4CV6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 18:46:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGwGv-0008JW-Vs
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 18:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1EBQqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 12:46:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1EBQqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 12:46:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A2DB4EEF;
	Mon,  2 May 2011 12:48:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JTKapIEfPhnirlR4uD7dYUfowJI=; b=ZG1PNs
	ITXDMm1VLkSgyZ89ljzTjz/MOL5AF3jury9AFoUM+Tn9Y2zggjbWpVR+/1p37LiQ
	ynSmOVMmZuUfN7faTIh8OgnRpr6zAgEwaj5yP7DhEhYDGpoZjvM1sERzJBJ+t39i
	wswuqQSqgbynhhL8gENZFMAsigsQsWLR/R93Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qwzYFmKvIS2Y/z1tnTnpf5VUAZsHxt1t
	X5chKvHCEJS2G00h26upWpCRJpOFav/V5LNCRFL2uGXYvMn62jgeMLOU+NyeBIt2
	sGFfCGNUdax/Oj0I7M+mMw0s5x42Gw4mOLyqZNp92CkPUgcM0+5qmaut83jE0im0
	SEv6YNguVyI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2938A4EEE;
	Mon,  2 May 2011 12:48:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A82D4EEC; Mon,  2 May 2011
 12:48:32 -0400 (EDT)
In-Reply-To: <BANLkTikvYLKKj_Wd0EOxZh+vANxju4CV6Q@mail.gmail.com> (Bert
 Wesarg's message of "Mon, 2 May 2011 14:20:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 067158E8-74DC-11E0-9193-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172601>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>> Can you give a concrete example of how you'd use this? I'm not sure I
>> understand the described use case.
>
> I parse the output of compiling a file, there may be warnings or even
> errors, I collect the given line numbers, and then call 'git grep -p
> -C -n (-@ <lno>)+ -- <path>' to show me what these warnings are about.

What would you do next after doing that?  Open the file in your editor and
jump to the line found by the grep?  Oh, wait, that's the same line as
your compiler already found for you.

And when you open the file in your editor, doesn't it show offending line
in the middle of the screen?  You can even fix it up right there.  Isn't
your editor wonderful?

The extra "grep -@" step in-between looks like a totally made-up use case
that is not interesting nor convincing.
