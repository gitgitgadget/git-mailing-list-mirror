From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Using git with http behind proxy with authentification?
Date: Mon, 25 Jul 2005 17:14:33 -0500
Message-ID: <1122329673.4378.4.camel@localhost.localdomain>
References: <42E21A33.6010804@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 00:17:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxBGK-0003ms-Cz
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 00:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVGYWQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVGYWQy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 18:16:54 -0400
Received: from zealot.progeny.com ([216.37.46.162]:55004 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S261212AbVGYWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 18:14:37 -0400
Received: from dhcp-2-246.progeny.com (dhcp-2-246.progeny.com [192.168.2.246])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 2BAF663782; Mon, 25 Jul 2005 17:14:34 -0500 (EST)
To: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <42E21A33.6010804@de.bosch.com>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-07-23 at 12:21 +0200, Dirk Behme wrote:
> In the past, for bk I used
> 
> $ export http_proxy=http://user:password@someproxy.some.where:8080/
> 
> which worked. But no luck with cogito/git.
> 
> Looking into recent cogito/git, the reason for this seems to be that 
> cogito/git uses a combination of wget in scripts and curl in compiled 
> executables. Having a look to cg-pull script, this script uses wget. 
> Then, it calls git-http-pull if it thinks that http should be used. 
> Looking at http-pull.c shows that there curl is used for http access. If 
> I understand it correctly from man pages, wget understands user:password 
> syntax of http_proxy environment, but curl doesn't. As I understand it 
> curl understands only 'someproxy.some.where:8080' and wants the user and 
> password given as parameter of curl_easy_setopt. The curl_easy_setopt 
> man page tells something about CURLOPT_PROXYUSERPWD parameter.
> 

For git itself everything is curl only now as far as I know. That's new
as of hours after you sent this.

Git turns on .netrc for doing 401 http auth. I wonder if curl will
consult .netrc for 407 proxy credentials as well?

Somebody would have to read code and/or try it.

--
Darrin
