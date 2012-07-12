From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 3/6] t4012: Actually quote the sed script
Date: Thu, 12 Jul 2012 14:15:30 +0200
Message-ID: <4FFEBFE2.5030206@in.waw.pl>
References: <20120711221241.GA21342@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Strasser <eclipse7@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 14:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpIJ6-0004Zo-44
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 14:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab2GLMPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 08:15:38 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:51128 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807Ab2GLMPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 08:15:38 -0400
Received: from zopt1.fuw.edu.pl ([193.0.81.24] helo=[10.33.8.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SpIIx-0004W2-Tb; Thu, 12 Jul 2012 14:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <20120711221241.GA21342@akuma>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201357>

On 07/12/2012 12:12 AM, Alexander Strasser wrote:
> The nested quoting is not needed in this cases, thus the previous
> version did work just fine. Never the less the usage is misleading,
> so just achieve nested quoting by using double quotes instead. Lower
> the probability of breakage in the future and make the code easier
> to read.

Hi,

I have some spelling corrections (minor, but since you intend to re-roll
anyway, I'll post them), and one more thing which could be corrected
(below).

3/6: s/Never the less/Nevertheless/
4/6: s/masquerading/masking/     (masquerade means to "mask oneself")

>  	 if git apply --stat --summary broken 2>detected
>  	 then
>  		echo unhappy - should have detected an error
> @@ -79,7 +79,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
>  '
>  
>  test_expect_success 'apply detecting corrupt patch correctly' '
> -	 git diff --binary | sed -e 's/-CIT/xCIT/' >broken &&
> +	 git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
>  	 if git apply --stat --summary broken 2>detected
>  	 then
>  		echo unhappy - should have detected an error
I think this can be changed to:
   test_must_fail git apply --stat --summary broken 2>detected

-
Zbyszek
