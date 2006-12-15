X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 12:35:32 +0100
Organization: At home
Message-ID: <elu15f$u0i$2@sea.gmane.org>
References: <200612132200.41420.andyparkins@gmail.com> <20061213225627.GC32568@spearce.org> <m2slfilbfi.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 11:33:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 48
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34495>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvBJX-0003WM-3W for gcvg-git@gmane.org; Fri, 15 Dec
 2006 12:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751953AbWLOLdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 06:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWLOLdQ
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 06:33:16 -0500
Received: from main.gmane.org ([80.91.229.2]:37105 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751953AbWLOLdP
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 06:33:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvBJN-0004QH-O4 for git@vger.kernel.org; Fri, 15 Dec 2006 12:33:09 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 12:33:09 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 12:33:09 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Seth Falcon wrote:

> Shawn Pearce <spearce@spearce.org> writes:
> 
>> Andy Parkins <andyparkins@gmail.com> wrote:
>>> svn cat::
>>> Output the contents of specified files or URLs.  Optionally at a
>>> specific revision.
>>> git cat-file -p $(git-ls-tree $REV $file | cut -d " " -f 3 | cut -f 1)::
>>
>> better:
>>
>>   git cat-file -p $REV:$file
> 
> FWIW, after some amount of git experience, I had a need for git
> cat-file and I found it hard to use.  Why?  Because following the
> pattern of some other commands, I really expected the following to work:
> 
>    git cat-file -p HEAD^2 $file
> 
> Since that is similar to
> 
>    git diff HEAD^^ $file
>    git checkout HEAD $file

You mean

    git diff HEAD^^ -- $file
    git checkout HEAD -- $file

It's not $file, it is $path, and it is limiter. git-cat-file (the name
is certainly historical artefact and it should be git-cat-object) doesn't
support limiters.
    
> Where else uses the colon syntax?

Everything where you have <object> or <tree-ish> you can use colon
syntax. For example:

  $ git ls-tree pu:Documentation
  $ git grep -e --merge next:Documentation
  $ git diff v1.4.2:gitweb/gitweb.cgi gitweb/web:gitweb/gitweb.perl

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

