From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] test-string-list.c: Fix some sparse warnings
Date: Mon, 17 Sep 2012 10:15:36 +0200
Message-ID: <5056DC28.60809@alum.mit.edu>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Sep 17 10:16:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDWUz-0005tl-2m
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 10:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab2IQIPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 04:15:45 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:60751 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709Ab2IQIPk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 04:15:40 -0400
X-AuditID: 1207440d-b7f236d000000943-17-5056dc2cf164
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 61.9E.02371.C2CD6505; Mon, 17 Sep 2012 04:15:40 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8H8Fbv3031515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Sep 2012 04:15:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5054AA62.2040603@ramsay1.demon.co.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqKtzJyzA4NBCNouuK91MFg29V5gt
	dk9bwObA7HHxkrLH44knWD0+b5ILYI7itklKLCkLzkzP07dL4M54vK6TpeAXT8WV9x8YGxiv
	cnUxcnBICJhInN6U38XICWSKSVy4t56ti5GLQ0jgMqPEy3nzmSCc40wSc7/cZwOp4hXQlLi9
	+zkjSDOLgKpE30MOkDCbgK7Eop5mJhBbVCBEYsblycwQ5YISJ2c+YQGxRYBqFs87CRZnFvCT
	OL+ljx3EFhZwlHh+fh1Yr5CAkUTL7KVgNqeAscSSh5fYIep1JN71PYDqlZfY/nYO8wRGgVlI
	VsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCGBy7uD8f86
	mUOMAhyMSjy8xpPCAoRYE8uKK3MPMUpyMCmJ8n6/ARTiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wvsrEijHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgnXgbqFGwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKfxxcBIBUnxAO0NAGnnLS5IzAWKQrSeYtTl
	uPtxxX1GIZa8/LxUKXFek1tARQIgRRmleXArYGnqFaM40MfCvJkgo3iAKQ5u0iugJUxASxZ+
	CgJZUpKIkJJqYOT1kxdmfDRPMqYnrFbAO+bSPJWnJR9fap987djI/G2Rj/XFzyv5tjay1Bfd
	UmSMbrNIqbo4I9b0QA6XaXTNpx/iC6PNAlLCdaxOy/f5rFi7P+PJ0xMffczSTnvF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205664>

On 09/15/2012 06:18 PM, Ramsay Jones wrote:
> 
> In particular, sparse complains as follows:
> 
>         SP test-string-list.c
>     test-string-list.c:10:6: warning: symbol 'parse_string_list' was not \
>         declared. Should it be static?
>     test-string-list.c:18:6: warning: symbol 'write_list' was not \
>         declared. Should it be static?
>     test-string-list.c:25:6: warning: symbol 'write_list_compact' was not \
>         declared. Should it be static?
>     test-string-list.c:38:5: warning: symbol 'prefix_cb' was not \
>         declared. Should it be static?
> 
> In order to suppress the warnings, since the above symbols do not
> need more than file scope, we simply include the static modifier
> in their declaration.

Thanks for fixing this.

Is there some documentation about how to run sparse on the git codebase?
 I naively tried "make sparse" and ended up with zillions of errors like

/usr/include/unistd.h:288:54: error: attribute '__leaf__': unknown attribute
/usr/include/unistd.h:294:6: error: attribute '__leaf__': unknown attribute
/usr/include/unistd.h:298:6: error: attribute '__leaf__': unknown attribute
/usr/include/unistd.h:306:6: error: attribute '__leaf__': unknown attribute
/usr/include/unistd.h:338:18: error: attribute '__leaf__': unknown attribute
/usr/include/unistd.h:347:6: error: attribute '__leaf__': unknown attribute
/usr/include/unistd.h:418:36: error: attribute '__leaf__': unknown attribute
/usr/include/unistd.h:423:50: error: attribute '__leaf__': unknown attribute

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
