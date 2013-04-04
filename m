From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] diffcore-pickaxe: respect --no-textconv
Date: Thu, 04 Apr 2013 19:03:58 +0200
Message-ID: <vpqip42qlc1.fsf@grenoble-inp.fr>
References: <vpqd2uay9rq.fsf@grenoble-inp.fr>
	<20130404160359.GA25232@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 19:04:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNnam-0007Cr-5z
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 19:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763555Ab3DDREJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 13:04:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57380 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763528Ab3DDREI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 13:04:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r34H3u9i024059
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Apr 2013 19:03:57 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UNnZv-00079j-2M; Thu, 04 Apr 2013 19:03:59 +0200
In-Reply-To: <20130404160359.GA25232@ruderich.org> (Simon Ruderich's message
	of "Thu, 4 Apr 2013 18:03:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Apr 2013 19:03:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r34H3u9i024059
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365699838.77576@q3bNXzHBsY6GazWqzIUF1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220035>

Simon Ruderich <simon@ruderich.org> writes:

> This patch should fix it.

It does.

> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -78,7 +78,6 @@ static void fill_one(struct diff_filespec *one,
>  		     mmfile_t *mf, struct userdiff_driver **textconv)
>  {
>  	if (DIFF_FILE_VALID(one)) {
> -		*textconv = get_textconv(one);
>  		mf->size = fill_textconv(*textconv, one, &mf->ptr);
>  	} else {
>  		memset(mf, 0, sizeof(*mf));

I don't understand why this is needed (not rethorical, I just didn't
investigate), but the rest of the code looks straightforward and
correct.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
