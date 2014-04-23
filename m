From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Wed, 23 Apr 2014 12:20:47 -0700
Message-ID: <xmqqa9bbzwc0.fsf@gitster.dls.corp.google.com>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
	<1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
	<38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd2j4-0003Bw-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757324AbaDWTUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:20:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757251AbaDWTUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:20:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39B97D1FA;
	Wed, 23 Apr 2014 15:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RYnvLrEQWl2w4h9/S7I4fVWK8bQ=; b=WEe0yu
	5cQpMrzO9Va54z1Bcr098OWk6jYJpLISDff+N7pPFYcc+OSvyQv2+yIiHprH20g4
	0ec9uAcDUgffEVaH+hD0YZHcy6lnGmN4BEFnCNGMIIjE+QilGNz0uwtaxZGgftuT
	+LcXpiDJ2/sPDeAD3Ia3ngthD+Cj04IiexP4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixyFMwGN8eX/E5djdsgkGWNb0J07lNA3
	qiODJHt3kGfQj5QJzyEp9kq5NJO1j+STKRSmaG1HY2TTx7i4pWjIlKn1kt+AyDPg
	yghXX+wrHsZpaXdiX3P0KLPBekwrbLoSQbPE2PCy26+2RjBX5JyM4dol07g/2yQY
	g0xNoTjjswU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 927E37D1F9;
	Wed, 23 Apr 2014 15:20:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D412C7D1F8;
	Wed, 23 Apr 2014 15:20:48 -0400 (EDT)
In-Reply-To: <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de> (Max Horn's
	message of "Wed, 23 Apr 2014 15:10:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 60739538-CB1C-11E3-B4AB-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246871>

Max Horn <max@quendi.de> writes:

> That said, I don't know what the criteria are for moving something out
> of contrib.

Because we accept stuff to contrib/, with an assumption that it is
to stay there without contaminating the main part of the system, the
quality of stuff in contrib/ can be sub-par and it is very possible
that a lot of clean-ups and fixes are necessary before moving them
out.

> Perhaps it is OK to move an undocumented remote-helper
> with known bugs out of contrib.

We should strive to apply the same criteria as new submission to the
main part of the system.  And inputs from people like you who have
more experiences than others on the list in dealing with hg-to-git
bridging are very much welcomed to identify and document what kind
of breakages there are, and to come up with the solution to them.
