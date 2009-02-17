From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] config: Trivial rename in preparation for
 parseopt.
Date: Mon, 16 Feb 2009 17:45:00 -0800
Message-ID: <7v3aedet0j.fsf@gitster.siamese.dyndns.org>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gerrit Pape <pape@smarden.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 02:46:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZF2w-0004B2-GP
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 02:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZBQBpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 20:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbZBQBpO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 20:45:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbZBQBpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 20:45:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 94D162B499;
	Mon, 16 Feb 2009 20:45:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5F60C2B496; Mon,
 16 Feb 2009 20:45:07 -0500 (EST)
In-Reply-To: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 17 Feb 2009 02:54:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DED955A-FC94-11DD-BF0F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110292>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When using the --list option general errors where not properly reported,
> only errors related with the 'file'. Now they are reported, and 'file'
> is irrelevant.
> ...
> @@ -299,10 +300,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
>  			if (argc != 2)
>  				usage(git_config_set_usage);
> -			if (git_config(show_all_config, NULL) < 0 &&
> -					file && errno)
> -				die("unable to read config file %s: %s", file,
> -				    strerror(errno));
> +			if (git_config(show_all_config, NULL) < 0)
> +				die("error processing config file(s)");

Does the author of 93a56c2 (git-config: print error message if the config
file cannot be read, 2007-10-12) have any comment on this change (cc:ed)?
