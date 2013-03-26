From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Tue, 26 Mar 2013 15:33:40 -0700
Message-ID: <7vd2ulsse3.fsf@alter.siamese.dyndns.org>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-3-git-send-email-gitster@pobox.com>
 <20130326185559.GB26462@sigill.intra.peff.net>
 <20130326203914.GA29167@sigill.intra.peff.net>
 <7v7gktubsp.fsf@alter.siamese.dyndns.org>
 <20130326212948.GA1340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 23:34:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKcRX-0001SE-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab3CZWdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:33:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab3CZWdn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:33:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2BCABF4F;
	Tue, 26 Mar 2013 18:33:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/850XD7NSKBxernwVKMwd30QZgk=; b=ML0NFu
	wnZiqePPNg0JptJjsp3GK37kS43Kni4IWfaN9o//5zbbgX5VaUOj5J1qfwMlboii
	JZxVN+tLWb6om9kcrq/AfHb7A6DZUZiUzS7y6cOmCtw2ltp42UiVmAvnpwB7f+39
	L0l2Jk+7Eoi4Tykx1WHKNm9yeobewkdwH09gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=prx0aw7wuDBH3TBb0616Kfe7zB8E1355
	zHO1L/hXY5V9J/fFimHVuGOK+B4ga2JQ6G0C9PhlJOPVqw72K97kpVi1WpDCH74v
	kSieofdjvmhUQvDQ094ED/jCZdyISXf5XILA5rLwzI8czutH3lYEHMzm+284kmW5
	8mVYVminXfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7856BF4E;
	Tue, 26 Mar 2013 18:33:42 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 668B4BF4C; Tue, 26 Mar 2013
 18:33:42 -0400 (EDT)
In-Reply-To: <20130326212948.GA1340@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 26 Mar 2013 17:29:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3678B098-9665-11E2-995F-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219226>

Jeff King <peff@peff.net> writes:

> So I think your series is the right direction, but we would want to
> factor out the allocation code and use it from match_pathname, as well.

I am deep into today's integration cycle, so perhaps in the meantime
you can help with a follow-up patch ;-)?
