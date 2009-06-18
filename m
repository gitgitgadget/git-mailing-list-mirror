From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH resend] Test cccmd in t9001-send-email.sh and fix two bugs
Date: Thu, 18 Jun 2009 12:11:39 +0200
Message-ID: <200906181211.39440.markus.heidelberg@web.de>
References: <1245223062-27132-1-git-send-email-bonzini@gnu.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 12:11:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHEar-0002fI-8i
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 12:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758645AbZFRKLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 06:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757672AbZFRKLX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 06:11:23 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35935 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758750AbZFRKLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 06:11:21 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 65738103D6537;
	Thu, 18 Jun 2009 12:11:23 +0200 (CEST)
Received: from [89.59.73.110] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MHEaZ-00075X-00; Thu, 18 Jun 2009 12:11:23 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1245223062-27132-1-git-send-email-bonzini@gnu.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+G+G9UzVooqzk649AKZ0apkCpVR62cfQT3kevr
	hnSLST+yWLaFp3J7Mpwk0HJfaQERZGIFqZCyyXMYuH2gCmkldm
	d/Gl0KZHsXd8ctAeIR3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121827>

Paolo Bonzini, 17.06.2009:
> The first bug is that the --suppress-cc option for `cccmd' was
> misspelled as `ccmd' in the code.

> +++ b/git-send-email.perl
> @@ -334,7 +334,7 @@ if (@suppress_cc) {
>  }
>  
>  if ($suppress_cc{'all'}) {
> -	foreach my $entry (qw (ccmd cc author self sob body bodycc)) {
> +	foreach my $entry (qw (cccmd cc author self sob body bodyccc)) {

Additionally you incorrectly changed bodycc to bodyccc.

Then I noticed that the documentation mentions ccbody, but the code uses
bodycc.
The author seemed to intend using bodycc, since it is also used in the
tests and the commit message (3531e2703d, send-email: --suppress-cc
improvements, 2009-02-15), but besides the documentation, ccbody is used
in the bash completion.

>  		$suppress_cc{$entry} = 1;
>  	}
>  	delete $suppress_cc{'all'};
