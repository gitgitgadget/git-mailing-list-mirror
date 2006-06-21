From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] send-email: Use setlocale in addition to $ENV{LC_ALL} to set locale
Date: Wed, 21 Jun 2006 12:33:18 +0200
Organization: At home
Message-ID: <e7b796$lj$1@sea.gmane.org>
References: <7v3bdy5178.fsf@assigned-by-dhcp.cox.net> <11508811631669-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 21 12:33:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft01e-0003Mb-Fn
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 12:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWFUKdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 06:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWFUKdb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 06:33:31 -0400
Received: from main.gmane.org ([80.91.229.2]:16298 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751491AbWFUKda (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 06:33:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ft01U-0003Ko-Md
	for git@vger.kernel.org; Wed, 21 Jun 2006 12:33:24 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 12:33:24 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 12:33:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22255>

Jakub Narebski wrote:

> $ENV{LC_ALL} = 'C'; does not change locale used by strftime.
> Use setlocale( LC_ALL, 'C' ); instead.

>  # most mail servers generate the Date: header, but not all...
>  $ENV{LC_ALL} = 'C';
> -use POSIX qw/strftime/;
> +use POSIX qw/strftime setlocale LC_ALL/;
> +setlocale( &LC_ALL, 'C' );

Perhaps instead of 
  setlocale( &LC_ALL, 'C' );
we should use
  setlocale( &LC_ALL, '' );
(i.e. set the LC_ALL behaviour according to the locale environment
variables). I'm not that versed in locale, POSIX and Perl.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
