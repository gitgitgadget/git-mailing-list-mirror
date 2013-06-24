From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] t/t5528-push-default: generalize test_push_*
Date: Mon, 24 Jun 2013 00:28:14 -0700
Message-ID: <7v7ghkdl2p.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-5-git-send-email-gitster@pobox.com>
	<CALKQrgeSbY3spjTp_m7kgt4TkFi8B5pNpLQ8wvDD+qkCYa+Mww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 09:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1CO-0002fr-9a
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab3FXH2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:28:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab3FXH2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:28:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C2BF28965;
	Mon, 24 Jun 2013 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t1SoUiyt4zY+oIdOznqxwpw7KHs=; b=PCc2sc
	1KsUElnF1UXl7PQeAzXCTshlzqhwYZvcIsD4cuGvffKJw6bwJdcmIpLnzrsqHlYE
	qgxUcBV9NvQcmuYqh4tgJgPdiBgU0Gwy46LuOiyCKzHG8jb4a/nj491Vi4SU1srn
	aSuim+9PwBIljERdonSFrcQs50d4BO5yupaKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWASdFeydf0YXBmExdKuywGgkiN260no
	udv10UmMzaY+9aO/lCYqRbGc3EyNrWT1PyCV3BGfH6U1+G2YAirPI/CJZTLm7wUK
	XrRlPFWQE+eQLVCDTO+j5DCE65m5Sx3Cweu96ZQ349diJqwX9pFHVjgNBC7USTvV
	puBWq3AZloo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370E628962;
	Mon, 24 Jun 2013 07:28:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9405D28956;
	Mon, 24 Jun 2013 07:28:15 +0000 (UTC)
In-Reply-To: <CALKQrgeSbY3spjTp_m7kgt4TkFi8B5pNpLQ8wvDD+qkCYa+Mww@mail.gmail.com>
	(Johan Herland's message of "Mon, 24 Jun 2013 08:58:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2678394-DC9F-11E2-9154-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228782>

Johan Herland <johan@herland.net> writes:

>> +       git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
>
> Isn't  ${3:-repo1} a bashism?

I do not think so.  But now I looked at it again, I think I would
use ${3-repo1} form in this case myself.  No caller passes an empty
string to the third place.
