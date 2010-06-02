From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to add daily tags for a central repo?
Date: Tue, 01 Jun 2010 21:40:24 -0700
Message-ID: <7vaareoxmv.fsf@alter.siamese.dyndns.org>
References: <1275369711233-5124575.post@n2.nabble.com>
 <4C04AC1E.7040502@drmicha.warpmail.net>
 <AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>
 <4C04BF33.70300@drmicha.warpmail.net>
 <AANLkTinHU5z5njEpx1S_6DIR5ECauJbzWlcM95wNUVxf@mail.gmail.com>
 <4C04CA4F.40106@drmicha.warpmail.net>
 <AANLkTinpmkLhbBeqtdK9auG6NfqEsHqPWhrpUL18nFsG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Roy Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:40:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfky-0002Sh-DK
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab0FBEke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 00:40:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0FBEkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 00:40:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E9A0B6F17;
	Wed,  2 Jun 2010 00:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=DWV6w8rsnrv12Qnf37EQecM/ja8=; b=CTZTAF+QZb4IPdx9B7ma6SM
	pd8PDwXz167xpSTs9EH2mhjTFH2DW2heM+y7lDIgVMbgrKSe1HGK1xVGCGb6DO7B
	0hGwAXpGWiydWpFPOgZ63Y15bqZ5fc15RVzOI3JRyeyfSQ7yAJZMaQSMgBkxmShC
	N0RGnK2KCQMGxruVCIoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=oQsHcq6OVC+7Vt5YUe6qW5avJngBnq5e1jB4oNU5+FZ3aoZ8J
	FvD3vZaD7ZCkAc+mbC4fajoymlGensFQ7NFmh+zVVabf++DNZTqEXLVNs4DFLJyy
	+DJgrXGGfkfGgClcopJJ49rk9xgOyJ6tEyMbCQXjFC3TyrheP+uiH+T95Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 37046B6F16;
	Wed,  2 Jun 2010 00:40:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B483B6F13; Wed,  2 Jun
 2010 00:40:26 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F90F021E-6E00-11DF-8274-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148199>

Roy Lee <roylee17@gmail.com> writes:

>> * Create a tag for the state of a ref (such as HEAD) on the central repo
>> at a specific date and time.
>
> Yes, for the daily build stuff.

If this is really "the daily build", the easiest is to

 - arrange the "daily build" environment to be kept up-to-date (either
   developers will be pushing into it, or there is another canonical
   central repository developer pushes into, and the daily build
   repository pulls from that canonical central repository via cron just
   before starting to build);

 - tag the version that is being built; and

 - do the "daily build".

Even if the automated "daily build" runs an hour after midnight, I
wouldn't imagine that you would want to grab the version that was the
latest as of midnight, building that slightly stale one, excluding the
development that happened within an our since that version.
