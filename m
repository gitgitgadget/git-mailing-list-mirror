From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Introduce CHERRY_PICK_HEAD
Date: Thu, 17 Feb 2011 11:58:44 -0800
Message-ID: <7vpqqqbfgr.fsf@alter.siamese.dyndns.org>
References: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
 <1297876835-70613-1-git-send-email-jaysoffian@gmail.com>
 <20110216214236.GC2615@elie>
 <AANLkTimBExej1mF=4UuTszcSoKy_xnj7bB3BaT5ze2vH@mail.gmail.com>
 <20110216230250.GF2615@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 20:59:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqA0F-0003i0-BV
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 20:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab1BQT67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 14:58:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41602 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab1BQT65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 14:58:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 749E231F7;
	Thu, 17 Feb 2011 15:00:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=q0HHnRjx07OKB7ZRToBH3zHwVcY=; b=GuD+fLnACIWIJZA0ipyD4RK
	tkt4CEWIvsXxp8ZLcrv2mhCgQAG23irnF/wp3eMKTFiigauxCxxrUytLiKdIj0W7
	cTbWRWPZMdYDidq41VplE9YedM2e2tIct8ARAUUBXmBcTHJ/ACOLvgdIS1nA6gdV
	gB9UcbvZHOCnwdeAiXjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ZopR8cxLRK6x+Ub2lOMTAvtGPTPEgpYnb7qDfMOFlzP8PCkuP
	JVrHfEDFg1BrfrYhnccyL+c7jTmtlp402KL3lgf5oZyemSn8Uz4B7xX2tnuhoRl7
	1fmOQeYmxH6HEHzQSA7ig6pdGIziqye+myyuraoYLjfPrShLxnvw9uUV+M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5FD631EF;
	Thu, 17 Feb 2011 14:59:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9118431EE; Thu, 17 Feb 2011
 14:59:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F880C68-3AD0-11E0-87A3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167107>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Wait, does this mean that -c/-C/--amend/CHERRY_PICK_HEAD overrides
> GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE?
>
> *checks*
>
> Yes, it does.  The behavior is carried over from v0.99~185
> (git-commit-script: get commit message from an existing one,
> 2005-06-25), but imho it is wrong.

Hmph, -c/-C/--amend is like giving the identity with --author from the
command line so overriding the values from the environment variables
sounds like the right thing to do.

Where am I confused?
