From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] git-bisect: allow bisecting with only one bad commit.
Date: Tue, 17 Apr 2007 07:07:10 +0200
Message-ID: <200704170707.10938.chriscool@tuxfamily.org>
References: <7vzm5pw7ju.fsf@assigned-by-dhcp.cox.net> <20070404071202.483030b8.chriscool@tuxfamily.org> <7v7isqkoa3.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:59:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdfmQ-0001RV-0s
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbXDQE67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXDQE67
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:58:59 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55807 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868AbXDQE66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:58:58 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 00230B92C5;
	Tue, 17 Apr 2007 06:58:57 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <7v7isqkoa3.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44725>

Hi Junio,

You wrote:

[...]
> -test_expect_success 'bisect does not start with only one bad' '
> +test_expect_success 'bisect starts with only one bad' '
>  	git bisect reset &&
>  	git bisect start &&
> -	git bisect bad $HASH4 || return 1
> -
> -	if git bisect next
> -	then
> -		echo Oops, should have failed.
> -		false
> -	else
> -		:
> -	fi
> +	git bisect bad $HASH4 &&
> +	git bisect next
>  '

Ok, this is the purpose of your patch to make the above work.

> -test_expect_success 'bisect does not start with only one good' '
> +test_expect_success 'bisect starts with only one good' '
>  	git bisect reset &&
>  	git bisect start &&
>  	git bisect good $HASH1 || return 1

But I don't understand the need to change the above comment when the test 
code for starting with one good commit is not changed.

Thanks,
Christian.
