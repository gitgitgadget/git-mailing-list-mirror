From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: move reflog updates into its own function
Date: Mon, 24 Nov 2014 13:50:39 -0800
Message-ID: <xmqqy4r0uv2o.fsf@gitster.dls.corp.google.com>
References: <1416530282-13192-1-git-send-email-sbeller@google.com>
	<CAGZ79kY8FagM_RPMZ9AchBmSK=BWR1A+4JQ7DiG2JmvyvtsPiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:50:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt1X0-0007JG-QO
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbaKXVup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:50:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751570AbaKXVuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:50:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A03F214BE;
	Mon, 24 Nov 2014 16:50:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NFYxAs2McaJIpt3VO71SPk7f/QA=; b=d3GE6R
	kSDqKKSdThkcO/cpcZpiPvFCSyIoxJlzh+lEyohy68A2SZ2fTLsh0ZzO8nYD9T1Y
	KIADlMnCMzFhhqqOiRG61/v+DOLvRFjUEcrpJd1ZmJG+K2C2SBh0MHQPfCWe8rl1
	gg5xrm2RBe04dkgquzb3TR7Orx3GKtA3I7KpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fh2dyhZZa6ptPvYFFUF9lF5K8gCOIVtM
	+x8RwGD0M51xRVchpVDITauafaRBA9FWUgu7IX9LG0eI6D0jttVtG1tUFp5Qeg67
	GRxHBGysLq41rbIkH8MxoD35yfS6TBkRUmQlX9JLLg8tntBblLcnMZARbZ3/fcmb
	HIoIB/u9Mcw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7895A214BD;
	Mon, 24 Nov 2014 16:50:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDB7B214BC;
	Mon, 24 Nov 2014 16:50:40 -0500 (EST)
In-Reply-To: <CAGZ79kY8FagM_RPMZ9AchBmSK=BWR1A+4JQ7DiG2JmvyvtsPiw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 24 Nov 2014 13:24:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEF78AD4-7423-11E4-A572-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260155>

Stefan Beller <sbeller@google.com> writes:

> Anything holding this back?

I do not recall anything objectionable offhand.  Perhaps fell
between the cracks during a patch storm or something.
