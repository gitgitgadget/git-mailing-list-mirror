From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 5/5] git-remote-mediawiki: Add preview subcommand into git mw.
Date: Thu, 20 Jun 2013 11:45:04 +0200
Message-ID: <vpqhagtazfj.fsf@anie.imag.fr>
References: <1371712593-6210-1-git-send-email-benoit.person@ensimag.fr>
	<1371712593-6210-6-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 20 11:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpbQb-00040b-To
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 11:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157Ab3FTJpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 05:45:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33850 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab3FTJpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 05:45:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5K9j3Bt017911
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Jun 2013 11:45:03 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UpbQO-0007in-JG; Thu, 20 Jun 2013 11:45:04 +0200
In-Reply-To: <1371712593-6210-6-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 20 Jun 2013 09:16:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 20 Jun 2013 11:45:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228474>

benoit.person@ensimag.fr writes:

> +	for (@{ $html_tree->extract_links() }) {
> +		my ($link, $element, $attr) = @{ $_ };
> +		my $url = url($link)->canonical;
> +		$element->attr($attr, URI->new_abs($url, $remote_url));

Actually, this breaks some relative links, like table of content links,
because you consider them relative to URLs like http://example.com/wiki/
but not http://example.com/wiki/index.php/My_Page.

Ideally, links pointing to stg like "#anchor" should not be modified.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
