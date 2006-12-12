X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] Allow building GIT in a different directory from the
 source directory
Date: Tue, 12 Dec 2006 12:50:55 +0100
Message-ID: <457E979F.9060307@xs4all.nl>
References: <eljo2u$pnq$2@sea.gmane.org> <7vbqm9xz8z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 11:51:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <7vbqm9xz8z.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34084>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu6A5-0003P4-Oz for gcvg-git@gmane.org; Tue, 12 Dec
 2006 12:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932220AbWLLLuw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 06:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWLLLuw
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 06:50:52 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:2693 "EHLO
 smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932220AbWLLLuv (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 06:50:51 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kBCBok4O010892 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Tue, 12 Dec 2006 12:50:46 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> 
>> GIT can now be built in a separate builddirectory. This is done as
>> follows:
>>
>>   mkdir build
>>   cd build
>>   $my_git_dir/configure
>>   make
> 
> Somehow making this depend on the use of configure feels wrong,
> since we tried to keep that config.mak.gen built by configure
> strictly optional.  In other words, I think the result of your
> patch should be buildable with or without ./configure in a
> separate directory if we are going to do this.
> 
> Care to explain why it is too cumbersome to handle without
> ./configure magic?

I already tried to explain in a previous thread on the list. 
See 

  http://article.gmane.org/gmane.comp.version-control.git/33487
  
you can still build git in the same directory as source 
without using autoconf, and plain make.

If you insist, I can create a separate

  setup-builddir.sh

to setup the build directory; according to the principle of least
surprise, it should happen in the configure script though.

I still don't understand the problem with autoconf; there are already
plenty of baroque shell scripts in GIT.  I hate writing m4 macros as
well, but that's not a problem for GIT users (ie. people who compile
GIT).

For them, 

  ./configure ; make ; make check ; make install

is actually the standard way to compile stuff.


-- 
