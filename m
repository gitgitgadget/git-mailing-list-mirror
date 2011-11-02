From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: "git diff" using tag names
Date: Wed, 02 Nov 2011 02:35:59 -0700
Message-ID: <7vty6mkgsg.fsf@alter.siamese.dyndns.org>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
 <20111028165943.2cc8253d@ashu.dyn.rarus.ru>
 <4EB0FFCA020000A100007DE2@gwsmtp1.uni-regensburg.de>
 <20111102132945.582707aa@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>,
	<git@vger.kernel.org>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 10:36:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLXEv-0001Ea-J9
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 10:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab1KBJgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 05:36:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43127 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab1KBJgC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 05:36:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293F54E0B;
	Wed,  2 Nov 2011 05:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IJVj2nnPrxve3CAYGIScSBeurB8=; b=yjCirQ
	Ae9vSrJsEGWi+mmKaVBMJ/p2lPQdThKgyPypDjYiVI2oj8ci6TGpqs4QEtdEl5+c
	QSUdOZYuCb6HMz7NuO7Fd4x+nByBz7Sgi5eQXYivievCHDYTXhwPbIWI60Vxc+40
	TV39LQ36kCNrNalqh2AnB9Tyi0Zxu+sM4spMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NgHi7735M6nhNd2ecEgnVAqJMq8kCz4A
	0rX9G2o9hrak647cJldYTqGhOlYCgnuBvFnIETB4+29gXGJD8LAByqUo3P1Z0VYa
	oLDGTjsL8dsVQXoTxY6WZ1Ptmbh9EVe0qTjOUNuQOMzBu+fAzamCDTUgXKW1kQJn
	uwtQ0aexm/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 206B04E0A;
	Wed,  2 Nov 2011 05:36:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EE254E08; Wed,  2 Nov 2011
 05:36:01 -0400 (EDT)
In-Reply-To: <20111102132945.582707aa@ashu.dyn.rarus.ru> (Alexey Shumkin's
 message of "Wed, 2 Nov 2011 13:29:45 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13947CB8-0536-11E1-BE1D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184623>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

>> Also it seems that both syntaxes work:
>> git diff v0.4..v0.5
>> git diff v0.4 v0.5
> honestly, I do not know the difference (at the moment :))
> may be gurus or manual will help to discover it

The latter is the kosher version, as diff is about two "endpoints" and not
about "ranges". The only reason the former is parsed without erroring out
is because too many people are used to type .. between two things without
thinking, learned the notation from "git log", which _is_ about ranges.
