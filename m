From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 22 Sep 2014 14:23:29 -0700
Message-ID: <xmqqk34vjqni.fsf@gitster.dls.corp.google.com>
References: <20140920134048.18999.79434.chriscool@tuxfamily.org>
	<20140920134515.18999.58095.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:23:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWB56-0001sz-HA
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 23:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbaIVVXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 17:23:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50340 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887AbaIVVXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 17:23:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA7903C7D7;
	Mon, 22 Sep 2014 17:23:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w/Pm1woHZwh096UmaTp7Psr5c60=; b=mMxPP5
	3dTSZa+E0UnOLlyuIWCEd/xAN47EeV8m+xDTrDERrSzoRXCBEN8EdqJGJ74wIRp4
	I3unDYR0NCfLbzNbsGUajX4f5BUlGIr5RNrjSQW+um4eKlfx2aU9Tq8QxxOQe/Gj
	cckaVKQQLuXITn10FrYmeS2SKZ6Ku/x+WM2Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uVyvMWYS2k1RXyJ3Hn37BZs13gtRyO06
	dkBy03OYZ5j24Y63+56Yo0rcE74ocqdrpzHXLdIxoB8zPe60fhodJKMmpr42mKPM
	KhWVpbQk6tOMuL94QG6+ozGNS66MzzFB6YZ70vn7F/PWT4pByVIwkoXr0zwx9Gm+
	MZanqL7LFys=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ABFED3C7D6;
	Mon, 22 Sep 2014 17:23:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1EA823C7D4;
	Mon, 22 Sep 2014 17:23:31 -0400 (EDT)
In-Reply-To: <20140920134515.18999.58095.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 20 Sep 2014 15:45:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B384EF3E-429E-11E4-971C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257386>

This has quite a few "trailing whitespace" errors in the patch in
the documentation part.  It would mean that people who try to follow
along the examples would have difficult time deciphering where
trailing whitespaces are necessary.

For example

> +* Configure a commit template with some trailers with empty values,
> +  then configure a commit-msg hook that uses 'git interpret-trailers'
> +  to remove trailers with empty values and to add a 'git-version'
> +  trailer:
> ++
> +------------
> +$ cat >commit_template.txt <<EOF
> +> ***subject***
> +> 
> +> ***message***
> +> 
> +> Fixes: 
> +> Cc: 
> ...

This presents the example in the least useful way.  The leading "> "
are coming from $PS2 so people cannot cut & paste to follow along on
their interactive shell session, but cutting and pasting from a
machine-readable copy of the document would be the only way to
preserve the trailing SP on lines that begin with Fixes:, Cc: and
friends.  On the other hand, those who type each line while
eyeballing the documentation (because it is not cut-and-paste ready
due to $PS2) may not spot the trailing SP on these lines.

Can we think of a way to make the necessary trailing SP stand out?
