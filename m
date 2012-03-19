From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: A better git diff --word-diff (--word-diff-regex) ?
Date: Mon, 19 Mar 2012 10:58:19 +0100
Message-ID: <4F67033B.2060904@viscovery.net>
References: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 10:58:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9ZMD-0002LU-CC
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 10:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758725Ab2CSJ6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 05:58:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4406 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758646Ab2CSJ6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 05:58:24 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S9ZM4-0005sy-Rd; Mon, 19 Mar 2012 10:58:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C26B81660F;
	Mon, 19 Mar 2012 10:58:19 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193423>

Am 3/19/2012 10:44, schrieb Piotr Krukowiecki:
> is there a way to configure --word-diff to be a more programming
> language friendly? For example if I add one parameter to a function
> declaration, I'd like to see only the addition of the parameter as the
> change. But currently it shows much more.
> 
> For example if
>   void foo(int x);
> is changed to
>   void foo(int x, int y);
> I'd like to see only ",int y" as the change, not "x, int y);".
> 
> I think I'd like to ignore all white spaces and tokenize text on word
> boundaries and see the diff between the tokens. This way if I e.g. add
> a missing ";" it'll be shown as the only change.

Start with

   git config diff.wordregex '[[:alnum:]]+|[^[:space:]]'

Adjust to your likings.

-- Hannes
