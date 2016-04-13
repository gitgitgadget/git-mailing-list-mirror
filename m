From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/2] Fix relative path issues in recursive submodules.
Date: Wed, 13 Apr 2016 15:45:31 -0700
Message-ID: <xmqqmvoxi0vo.fsf@gitster.mtv.corp.google.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<56FE8898.20906@ramsayjones.plus.com>
	<CAGZ79kYE3E7stNc3Xbzr-qvncLGt4qRPMbv897k5h0B50-Rogg@mail.gmail.com>
	<570E9C46.6080905@ramsayjones.plus.com>
	<CAGZ79kYj+4_6BsrcRRzsvdp_FcRG9VuiJ1tLjSo3D5_uWe2nfQ@mail.gmail.com>
	<xmqqzisxi1w0.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbh4q-w6yt6eHrvcGvH6mhmCJG1WdRSdO6bgpX=iLwARw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:45:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTXW-0000Sc-Je
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbcDMWpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:45:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754726AbcDMWpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:45:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D7A512A97;
	Wed, 13 Apr 2016 18:45:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i55V5DwA0cS9t/o0wiZJ1p9KPts=; b=m4fPQj
	DpUdkF3XFZq832MzupuH+P7d6g3uZP03wRYdXUP23zGeiSx7d/nrX//vV9sJaHkU
	YwZFiliq7DBEB61lbb0tnru6HqP2/ccGprPJ9L5JF+vkO6v1lB63S/o+zZbovXwQ
	qP1hK03HIcUqaiSrzvyT/nZJK8BoUK2dyR9TY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n4SWWtye1Joc5E5xlMyd2Rj+KfQASyEe
	3QMAQy2jcJU1nFXGgt4HnuCKgQWDMtdiP5KXbolfyNQkmMsjJQN9miC2P4pqBnng
	7YhfSCvvzO6vO/L5l7ovh6jrPqX+3zpq8Knd2YDcx59MhBmTUcVTm6rT1syh2Efs
	ac9OT585CJQ=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 25AB612A96;
	Wed, 13 Apr 2016 18:45:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84F1012A93;
	Wed, 13 Apr 2016 18:45:32 -0400 (EDT)
In-Reply-To: <CAGZ79kbh4q-w6yt6eHrvcGvH6mhmCJG1WdRSdO6bgpX=iLwARw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Apr 2016 15:30:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6DF5540E-01C9-11E6-BDF8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291508>

Stefan Beller <sbeller@google.com> writes:

> ... so what is your concern for holding instead of merging?

Nothing specific.  Remember, I may be aware of all the discussion
threads but I am certainly not reading every word in every thread.
When the participants are trustworthy enough, instead of going back
to the list archive (and risk overlooking a message that asks
"please hold off merging this, I have another last-minute update")
to see if everything known has been resolved in a satisfactory way
myself, I'd just ask, which is more efficient _and_ reliable.
