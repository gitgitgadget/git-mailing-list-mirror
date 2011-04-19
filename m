From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 00/11] gitweb: Change timezone in dates using
 JavaScript
Date: Mon, 18 Apr 2011 18:01:10 -0700
Message-ID: <7vei4z6omh.fsf@alter.siamese.dyndns.org>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:01:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBzK4-0001qk-Sm
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 03:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab1DSBBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 21:01:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1DSBBX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 21:01:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED4EF5D68;
	Mon, 18 Apr 2011 21:03:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oDU75fNb4EABja7/sc0YgFknB3o=; b=WqsEys
	P5taHX270jo4vwhCPV9bOfRzOV1umR8qMofcc8lCj7HMyY/6MHm6Lzn1Oco4E1BU
	iJbZ8pLAsmwzrLXy93HJZw0wsmlaBV8zKxMMI/2c3vzrfUOKvfRdoGJceZbB9nZK
	Qgwy2/iXZmw3eWBsNULOFFxBaOXbj7s7dn9zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jjLzz2c8Gvd/Xkk0LYm0mvcCjmqDB9+d
	hfZ4bAmaOECgUCEmvLhlZt9+Oj9xH1EwVzUEk3W/t19GJ2YjNdjgKj7UY6UsXPHr
	ZsMftYTB7XhpapTjvXr7ACgQrpL1KlP2gbHXRLQL2f0LbQsHVfZthZC0W/lc6kgU
	vmqBHmLwU2o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB8155D64;
	Mon, 18 Apr 2011 21:03:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7651C5D63; Mon, 18 Apr 2011
 21:03:12 -0400 (EDT)
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Fri, 15 Apr 2011 16:43:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFA37D8E-6A20-11E0-B676-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171769>

This seems to break the build like this, by exposing a lack of dependency
somewhere in the Makefile:

    ...
    SUBDIR gitweb
make: *** No rule to make target `gitweb/static/gitweb.js', needed by `git-instaweb'.  Stop.
make: *** Waiting for unfinished jobs....
