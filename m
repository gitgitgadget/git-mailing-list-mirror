From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 21:51:05 -0700
Message-ID: <7vtxv18ax2.fsf@alter.siamese.dyndns.org>
References: <20120913170943725232.01d717ef@gpio.dk>
 <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Bauer <jens-lists@gpio.dk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 06:51:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCNs6-0004pp-TD
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 06:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198Ab2INEvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 00:51:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2INEvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 00:51:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F32A948E;
	Fri, 14 Sep 2012 00:51:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AIkvE3JRl0EhVnoExxT6Q2vCXZs=; b=D3R4Ao
	7K1370RSme3XMkU7imCT84sdIllCJqv9lQ98S3dznhhFZ519nu1QOVtQ6uAz9M2L
	o7bk7S4b6OEFeKCTsb7Pq7bQib53nHYl3C1vR+tEtOhDFHQunhaM6NncpD/khYjw
	oGFFja0ehz/MD6K6rctVza5dcboKg4c/1MFNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mPLqa1k/4I/uX5gfCIV1PDd+7wtwEDot
	eaZOPBXNMev2H9zVXU45lnDwMe3ZGCMg/WBpOP1n1oskh9CZDU/v7MwYzeWstp4f
	KElDgm8iwlLhrT5yjuXx8+Zf8EL8GtupLW6ECu2pQVwWdc7hnppCg1csXXAdwGiA
	V/6n23zgh8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D26D948D;
	Fri, 14 Sep 2012 00:51:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD5AA948C; Fri, 14 Sep 2012
 00:51:07 -0400 (EDT)
In-Reply-To: <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com> (David
 Aguilar's message of "Thu, 13 Sep 2012 21:06:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBFA35D2-FE27-11E1-B28D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205452>

David Aguilar <davvid@gmail.com> writes:

> git doesn't really even support LF.

At the storage level that is correct, but the above is a bit of
stretch.  It may not be "support", but git _does_ rely on LF when
running many text oriented operations (a rough rule of thumb is
"does 'a line' in a file matter to the operation?").  Think about
"git diff" and "git blame".
