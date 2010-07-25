From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] gitweb: move highlight config out of guess_file_syntax()
Date: Sun, 25 Jul 2010 19:53:04 -0400
Message-ID: <4C4CCE60.1080301@mit.edu>
References: <1280000767-31895-1-git-send-email-asedeno@mit.edu> <201007260135.35059.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 01:53:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdB0M-0000aY-UR
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 01:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab0GYXxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 19:53:09 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:48736 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438Ab0GYXxI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 19:53:08 -0400
X-AuditID: 1209190c-b7c0dae000000a0c-7b-4c4cce65785a
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 14.FC.02572.56ECC4C4; Sun, 25 Jul 2010 19:53:09 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6PNr7UC007018;
	Sun, 25 Jul 2010 19:53:07 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6PNr59C019199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Jul 2010 19:53:06 -0400 (EDT)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id D421414C012; Sun, 25 Jul 2010 19:53:05 -0400 (EDT)
Received: from [18.238.2.136] (JABUN.MIT.EDU [18.238.2.136])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id B5B5814C011;
	Sun, 25 Jul 2010 19:53:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <201007260135.35059.jnareb@gmail.com>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAARVG7TA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151798>

On 7/25/2010 7:35 PM, Jakub Narebski wrote:
> BTW. is this something _you_ needed (and what did you need to configure
> / to put in $GITWEB_CONFIG file), or just a generalization?


This is something I was using in previous versions of gitweb, though
with the older (pre-592ea41) syntax. (I had applied the older
highlighting patches, and was quite happy to see them merged.)

Before, $GITWEB_CONFIG contained lines like:

  $highlight_type{'\.lisp$'} = 'lisp';

As of 1.7.2, with syntax highlighting merged and refactored (592ea41),
access to the hashes that define syntax highlighting mappings was lost.
Moving the hashes out into the config area lets $GITWEB_CONFIG contain
lines like:

  $highlight_ext{'lisp'} = 'lisp';
  $highlight_basename{'GNUmakefile'} = 'mak'
