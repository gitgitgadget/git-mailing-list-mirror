From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Import git-forest
Date: Wed, 02 Apr 2008 14:49:00 -0700
Message-ID: <7vve3053n7.fsf@gitster.siamese.dyndns.org>
References: <1207169895-25949-1-git-send-email-jengelh@computergmbh.de>
 <9aca54e6e106be3f26ae289606b9a47a91806d54.1207169779.git.jengelh@computergmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, kzak@redhat.com
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 00:01:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhB0o-0006pq-Rk
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 00:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761213AbYDBWAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 18:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758938AbYDBWAM
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 18:00:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759032AbYDBWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 18:00:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A40D4F6F;
	Wed,  2 Apr 2008 17:58:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 94FE04EBD; Wed,  2 Apr 2008 17:49:09 -0400 (EDT)
In-Reply-To: <9aca54e6e106be3f26ae289606b9a47a91806d54.1207169779.git.jengelh@computergmbh.de> (Jan Engelhardt's message of "Wed, 2 Apr 2008 22:58:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78719>

Jan Engelhardt <jengelh@computergmbh.de> writes:


    Content-Type: TEXT/PLAIN; charset=ISO-8859-1

> +#	git-??????

Hmmmm...

> +&main();
> +
> +sub main ()
> +{
> +	&Getopt::Long::Configure(qw(bundling pass_through));
> +
> +	&GetOptions(
> +		"all"      => \$Show_all,
> +		"no-color" => sub { %Color = (); },
> +		"no-rebase" => sub { $Show_rebase = 0; },
> +		"style=i"  => \$Style,
> +		"sha"      => \$With_sha,
> +	);
> +	if ($Show_all) {
> +		unshift(@ARGV, "--all", "HEAD");
> +	}
> +	&process();
> +}

This is a Perl script with a curious style.  Your subroutines force the
"funny" parameter semantics to their callers by using prototypes, but
avoid the potential surprises and inconveniences prototypes may cause by
using the &name(...) form when they themselves make subroutine calls,
i.e. not eating their own dog food.

Is it fashionable to make text based tree render these days?  How does
this compare with the git-graph in the nearby thread?  Can they borrow
from each other?
