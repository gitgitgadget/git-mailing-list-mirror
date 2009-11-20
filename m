From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/lib-http.sh: Enable httpd tests by default.
Date: Fri, 20 Nov 2009 00:03:15 -0800
Message-ID: <7vd43d7hdo.fsf@alter.siamese.dyndns.org>
References: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com>
 <1258680123-28684-2-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jaysoffian@gmail.com,
	drizzd@aon.at, gitster@pobox.com, spearce@spearce.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 09:03:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBOSy-0005in-IH
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 09:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbZKTID3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 03:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbZKTID2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 03:03:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbZKTID2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 03:03:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E20C9F12F;
	Fri, 20 Nov 2009 03:03:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UzS9ptgiDaNkgeYiddR8pzGsiGY=; b=tdIZU6
	2cuJTJZ+xgfUB4i/KD0Tqr0s03qHq8acaQWyIIIM/ovEICgb7ywQhnDLqE+qhWmr
	CAJ54SfNZ53J6Yc7NA/QZiiTrnGaFKHQK2Vcbs9yo0rPxqmMdFpLddTLUEs1eHh5
	lt/7B8/y8R7UT1sfguEb/DvnMj761zz0IVv6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n/Ph89Y7kDxCIC7sUhAP/RJWBJ34iEQX
	RndqDdL88sG4XTVD4Y5q91ICIlj80Q0dPM7WfngOPemnP8fgTQqSE6xM2COEl15t
	K3cRDnGF9TFR9VZm5ahyk1bvAWJxtQ6sU0Rds3UR9QwkiEalw/cJKcoDl2+LJm5R
	tVhCmG/tDrY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C5F3A9F12E;
	Fri, 20 Nov 2009 03:03:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 603C49F126; Fri, 20 Nov 2009
 03:03:17 -0500 (EST)
In-Reply-To: <1258680123-28684-2-git-send-email-tarmigan+git@gmail.com>
 (Tarmigan Casebolt's message of "Thu\, 19 Nov 2009 17\:22\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2EB8D17C-D5AB-11DE-AACD-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133313>

Tarmigan Casebolt <tarmigan+git@gmail.com> writes:

> With smart http, git over http is likely to become much more common.
> To increase testing of smart http, enable the http tests by default.

Sorry, but no test that listens to network ports should be enabled by
default; otherwise it will break automated, unattended tests people have
already set up randomly, depending on when the port happens to be
available for use by the tests.
