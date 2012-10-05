From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ignore on commit
Date: Thu, 04 Oct 2012 19:44:40 -0700
Message-ID: <7vwqz5vdrb.fsf@alter.siamese.dyndns.org>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
 <506DEC50.7090402@obry.net>
 <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
 <CAH5451mpJw4+noUF+FkZJS+Y2oq2ThFeG7wSOCdbVaMQPNgUJA@mail.gmail.com>
 <CANgJU+XSYWObCsGVnWwaaSB9iZQnfU_y095uzEm5-YXMaUoU_w@mail.gmail.com>
 <CAMK1S_jfdW3BepELgPPoUf3qWwmU-o3o8OpMVimdfkERUJkymQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Marco Craveiro <marco.craveiro@gmail.com>, pascal@obry.net,
	git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 04:45:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJxuR-0005Fe-Az
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 04:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab2JECor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 22:44:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756650Ab2JECor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 22:44:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EAF29D7D;
	Thu,  4 Oct 2012 22:44:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WRBM3XdIF1V11gTTXKKiD6NA32E=; b=NRCw9y
	P0EFrF62c6NY2EETcX1ZdevNpgOkET22Qw2+k4DT/8werRiNhNt5mbfWcUhnngpw
	vPRXc4aQvBUJwbG8Yg73gNdlJ0FB8hWDsXii1PQN2IBEBHWUOElChGZdBLhRDbW1
	cfp7H+mP9TL5PjIbQc20zEeKPvGxXlMuyQPmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KlPDSWrFtZq2ViVz6azBrK7q7gNkYh+S
	mJ8lKDP5MBdWAX0Ot2GhHSb/avnE19WqDK4wk/B9TC8Mca5juyxHY+pxz1QSKcAM
	CDQhUQUdZiOJi2rJbql0UFMOFr2YK86sF8Heq5YiK6TxmJuf4CALSzC094DrjuR1
	2IloWoIhJ14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AE8D9D74;
	Thu,  4 Oct 2012 22:44:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 586709D73; Thu,  4 Oct 2012
 22:44:44 -0400 (EDT)
In-Reply-To: <CAMK1S_jfdW3BepELgPPoUf3qWwmU-o3o8OpMVimdfkERUJkymQ@mail.gmail.com> (Sitaram
 Chamarty's message of "Fri, 5 Oct 2012 07:50:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F38BA30-0E96-11E2-98DF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207065>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>> Git ignore doesn't ignore tracked files.
>
> would 'git update-index --assume-unchanged' work in this case?  Didn't
> see it mentioned in any of the replies so far (but I have never used
> it myself)

The assume-unchanged bit is *not* an instruction to tell Git to
ignore changes.  It is your *promise* that you will not change it,
and tells Git that it is free to use the contents from the working
tree and the contents in the index interchangeably, taking whichever
is more convenient for Git to handle.

So, no, it might appear to work in some cases, but you are playing
with an undefined behaviour.
