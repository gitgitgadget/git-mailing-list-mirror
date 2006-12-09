X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Allow building GIT in a different directory from the source directory
Date: Sat, 9 Dec 2006 02:16:39 +0100
Message-ID: <20061209011639.GA8010@steel.home>
References: <elc6j2$vej$1@sea.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 01:17:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <elc6j2$vej$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: ZqgRkeZGgetKAxzfFxneiEkkSelZ6isc-+pCFo1VqfW5uFfexNoCE1
X-TOI-MSGID: fdefeb19-612b-4fcb-89f1-93fc88484082
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33784>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsqpk-0007fk-1g for gcvg-git@gmane.org; Sat, 09 Dec
 2006 02:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947615AbWLIBQx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 20:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761337AbWLIBQx
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 20:16:53 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:35038 "EHLO
 mailout04.sul.t-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1761336AbWLIBQw (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 20:16:52 -0500
Received: from fwd35.aul.t-online.de  by mailout04.sul.t-online.com with smtp
  id 1Gsqpe-0001uD-01; Sat, 09 Dec 2006 02:16:50 +0100
Received: from tigra.home
 (ZqgRkeZGgetKAxzfFxneiEkkSelZ6isc-+pCFo1VqfW5uFfexNoCE1@[84.163.109.21]) by
 fwd35.sul.t-online.de with esmtp id 1GsqpU-1cOV4C0; Sat, 9 Dec 2006 02:16:40
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 1FE38277AF; Sat,  9 Dec 2006 02:16:40 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GsqpT-000809-FV; Sat, 09 Dec 2006 02:16:39 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys, Fri, Dec 08, 2006 18:15:25 +0100:
> -my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm');
> +
> +$src_prefix = '';
> +if (!($ENV{'PERL_SRCDIR'} eq "")) {
> +    $src_prefix = $ENV{'PERL_SRCDIR'} . "/"
> +}

Hurts my eyes :)

    $src_prefix = defined($ENV{PERL_SRCDIR}) ?  "$ENV{PERL_SRCDIR}/": '';

could be shorter, unless you want (you do) strict syntax check.
