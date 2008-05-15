From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 v2] cvsexportcommit: chomp only removes trailing
 whitespace
Date: Wed, 14 May 2008 19:27:23 -0700
Message-ID: <7vk5hwi9o4.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805141526160.30431@racer>
 <7vskwkojhy.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805141936410.30431@racer>
 <alpine.DEB.1.00.0805142327520.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 04:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwTD0-0004hW-PU
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 04:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbYEOC1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 22:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbYEOC1d
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 22:27:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYEOC1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 22:27:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4CE95E63;
	Wed, 14 May 2008 22:27:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 307325E5E; Wed, 14 May 2008 22:27:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805142327520.30431@racer> (Johannes
 Schindelin's message of "Wed, 14 May 2008 23:30:43 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 77F96A70-2226-11DD-A45E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82170>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -210,7 +210,7 @@ if (@canstatusfiles) {
>  	my $basename = basename($name);
>  
>  	$basename = "no file " . $basename if (exists($added{$basename}));
> -	chomp($basename);
> +	$basename =~ s/^\s+(.*?)\s*$/$1/;

Isn't this no-op for a basename that does not begin with a whitespace?
Don't you want to still strip trailing whitespaces in such a case?
