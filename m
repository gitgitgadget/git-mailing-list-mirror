From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/9] Add tests for git cat-file
Date: Tue, 23 Oct 2007 08:59:19 +0200
Message-ID: <471D9BC7.2070702@viscovery.net>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkDjl-00088H-1m
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXJWG7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 02:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbXJWG7Z
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:59:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33262 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbXJWG7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 02:59:24 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IkDjE-0003Mb-2P; Tue, 23 Oct 2007 08:59:04 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B538B6C4; Tue, 23 Oct 2007 08:59:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1193118397-4696-2-git-send-email-aroben@apple.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62115>

Adam Roben schrieb:
> +    test_expect_success \
> +        "$type exists" \
> +        "git cat-file -e $hello_sha1"

You mean $sha1 here, right?

> +    test_expect_success \
> +        "Type of $type is correct" \
> +        "test $type = \"$(git cat-file -t $sha1)\""

This should escape the $(...) in all the tests. Like this:

         "test $type = \"\$(git cat-file -t $sha1)\""

> +test_expect_success \
> +    "Reach a blob from a tag pointing to it" \
> +    "test \"$hello_content\" = \"$(git cat-file blob $tag_sha1)\""

And use single quotes without escaping the double-quotes here.

-- Hannes
