From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: cleanup binary images usage
Date: Tue, 19 Jul 2011 12:03:25 -0700
Message-ID: <7v39i29jpe.fsf@alter.siamese.dyndns.org>
References: <1311096107.8532.39.camel@vivanov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Vitaliy Ivanov <vitalivanov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 21:03:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjFZu-00076E-DC
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 21:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab1GSTD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 15:03:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab1GSTD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 15:03:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3FC940E8;
	Tue, 19 Jul 2011 15:03:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBgv1gj1nEIDzVjG53rbgHxZOvE=; b=h6hFkM
	7FDEjEIYP0SBpx3hlp8FQgGt2q6B/w+5/lZADbbMv87v5XxAKPolIvmtsEgk7t2M
	y1gFFvs0NwnfFvaNU7sKPwRSJWoNbzpkvt7TqQqfcdcZor17xaiFA8Usd/LUxRae
	ZH9+lwJFP5BNVp7v8yAfC1eTNzrCEJTN2WZzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f2g7r+UMgk35ZmhWTBhgF8PDI9sEJFMx
	Z1i+94NTz2dTQSP4Qyq+MYe4r1+9kurD+9Bk2XliQVseeZHfE/6REUyVwzyNzuk0
	4w8tn/Gsh6AGsAUn0fj9A8atZ9nD1//Ng9vswLvzeihHfGpA68MPXuRRQfZqUpQV
	E06nlSokMo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B51640E6;
	Tue, 19 Jul 2011 15:03:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D6A440E5; Tue, 19 Jul 2011
 15:03:27 -0400 (EDT)
In-Reply-To: <1311096107.8532.39.camel@vivanov> (Vitaliy Ivanov's message of
 "Tue, 19 Jul 2011 20:21:47 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8B520FC-B239-11E0-AC0B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177493>

Vitaliy Ivanov <vitalivanov@gmail.com> writes:

> ---
>>From bff3916939fcd226278a2e983ddc77bb711296e7 Mon Sep 17 00:00:00 2001
> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> Date: Tue, 19 Jul 2011 20:07:08 +0300
> Subject: [PATCH] tests: cleanup binary images usage

Thanks.

Drop the above five lines and replace them with a single "-- >8 --" line.
The lone "---" line is especially harmful as it tells our tools to stop
reading anything below when finding your commit log message.

> Images are being shared between tests and this is OK.
> By this patch I name images independently of tests plus
> remove unneeded images.

The point of these test vector files are that they are binary and it is
secondary that they happen to be images.

Perhaps like this.

  Hi, list,

  Extra and redundant explanation that you could have just let your
  proposed commit log message speak for itself comes here, if you really
  need one.

  -- >8 --
  tests: cleanup binary test vector files

  The test4012.png test vector file that was originally used for t4012 to
  check operations on binary files was later reused in other tests, making
  it no longer consistent to name it after a specific test. Rename it to more
  generic "test-binary-1.png".

  While at it, rename test9200b to "test-binary-2.png" (even though it is
  only used by t9200).

  Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
  ---
  <<diffstat and patch here>>

> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
> ---
>  t/t3307-notes-man.sh           |    6 +++---
>  t/t4012-diff-binary.sh         |    2 +-
>  t/t6023-merge-file.sh          |    2 +-
>  t/t6027-merge-binary.sh        |    2 +-
>  t/t9200-git-cvsexportcommit.sh |   14 +++++++-------
>  t/test-image1.png              |  Bin 0 -> 5660 bytes
>  t/test-image2.png              |  Bin 0 -> 275 bytes
>  t/test4012.png                 |  Bin 5660 -> 0 bytes
>  t/test9200a.png                |  Bin 5660 -> 0 bytes
>  t/test9200b.png                |  Bin 275 -> 0 bytes
>  10 files changed, 13 insertions(+), 13 deletions(-)
>  create mode 100644 t/test-image1.png
>  create mode 100644 t/test-image2.png
>  delete mode 100644 t/test4012.png
>  delete mode 100644 t/test9200a.png
>  delete mode 100644 t/test9200b.png

Also have you considered using "format-patch -M" to send this patch?
