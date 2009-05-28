From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-svn clone problem
Date: Thu, 28 May 2009 09:47:16 +0200
Message-ID: <op.uumqk2gt1e62zd@merlin.emma.line.org>
References: <20090527221601.GA12914@mail.oracle.com>
 <86d4c5e00905271911g58cccc1bwd4b881541db6f7a5@mail.gmail.com>
 <20090528024153.GH12914@mail.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Joel Becker" <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:47:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9aKq-00018s-KE
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 09:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbZE1HrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 03:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbZE1HrS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 03:47:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:45155 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752863AbZE1HrS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 03:47:18 -0400
Received: (qmail invoked by alias); 28 May 2009 07:47:18 -0000
Received: from unknown (EHLO mandree.no-ip.org) [85.183.213.241]
  by mail.gmx.net (mp021) with SMTP; 28 May 2009 09:47:18 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/07MEnneP0RJqEm3qXQwVL7W+KTD20fVwDStXXwS
	qC+WFgW8e48Zr3
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id D167494606;
	Thu, 28 May 2009 09:47:16 +0200 (CEST)
In-Reply-To: <20090528024153.GH12914@mail.oracle.com>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120166>

Am 28.05.2009, 04:41 Uhr, schrieb Joel Becker <Joel.Becker@oracle.com>:

> On Wed, May 27, 2009 at 07:11:01PM -0700, Deskin Miller wrote:
>> The problem here isn't with git-svn; rather, it is with the svn
>> repository at oss.oracle.com claiming a nonsensical UUID.  svn uses
>> UUIDs behind the scenes to identify each repository, and git-svn does
>> the same thing.  When doing git svn init (or clone, which is just init
>> && fetch) the svn server sends back a UUID which identifies it.  When
>> I use wireshark and expand the first HTTP packet back from a good svn
>> server, I see something like the following embedded in the xml tree:
>>
>> <lp3:repository-uuid>
>> 612f8ebc-c883-4be0-9ee0-a4e9ef946e3a
>> </lp3:repository-uuid>
>>
>> However when I do the same with oss.oracle.com I see
>>
>> <lp2:repository-uuid>
>> ????????-????-????-????-????????????
>> </lp2:repository-uuid>
>>
>> git-svn tries to play along for a while, but the bottom line is that a
>> string of question marks isn't a UUID.
>>
>> There's more about svn's use of UUIDs in the svn book.  Perhaps the
>> admin of oss.oracle.com can correct this UUID problem so one can use
>> git-svn with this repository.
>
> 	Is this some new feature of svn that git-svn has decided to
> require?  We're running subversion 1.4.4 there, and git-svn used to work
> against those repos.
> 	Hmm, it's only a couple of very old repos with this problem -
> they were probably created with subversion 1.1 or 1.0.  I found how to
> fix it.  Thanks.

Hi Joel,

could you share a pointer to or outline of the solution with the list, for  
the completeness of the (searchable) archives?

Thanks.

-- 
Matthias Andree
