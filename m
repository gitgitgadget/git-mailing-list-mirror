From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] ident: check /etc/mailname if email is unknown
Date: Mon, 03 Oct 2011 09:09:49 +0200
Message-ID: <4E895FBD.8020904@viscovery.net>
References: <20111003045745.GA17604@elie> <7v8vp2iqvc.fsf@alter.siamese.dyndns.org> <20111003061633.GB17289@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:10:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAcf4-0001VW-SU
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab1JCHJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:09:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41895 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1JCHJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:09:57 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RAcer-0002TM-D3; Mon, 03 Oct 2011 09:09:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 956501660F;
	Mon,  3 Oct 2011 09:09:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <20111003061633.GB17289@elie>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182627>

Am 10/3/2011 8:16, schrieb Jonathan Nieder:
> +static int add_mailname_host(char *buf, size_t len)
> +{
> +	FILE *mailname;
> +
> +	mailname = fopen("/etc/mailname", "r");
> +	if (!mailname) {
> +		if (errno != ENOENT)
> +			warning("cannot open /etc/mailname: %s",
> +				strerror(errno));

This warns on EACCES. Is that OK? (Just asking, I have no opinion.)

-- Hannes
