From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lf_to_crlf_filter(): tell the caller we added "\n" when
 draining
Date: Mon, 19 Dec 2011 12:23:09 -0800
Message-ID: <7v7h1smhua.fsf@alter.siamese.dyndns.org>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
 <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
 <20111125170219.GD10417@beez.lab.cmartin.tk>
 <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
 <20111128104812.GA2386@beez.lab.cmartin.tk>
 <7viplggoq9.fsf@alter.siamese.dyndns.org>
 <7vaa6sgmt3.fsf_-_@alter.siamese.dyndns.org>
 <Pine.GSO.4.63.1112191114010.4136@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing list <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 21:23:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcjk0-0005Oe-TI
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 21:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab1LSUXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Dec 2011 15:23:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab1LSUXL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2011 15:23:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 568A45154;
	Mon, 19 Dec 2011 15:23:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OOIeC5I5gmiW
	1eRJa1lBprUBQTY=; b=CPOMa51bE0SkO2d/Zgu7f+8bYtxmVh4WK/rwOdjxMpVj
	4mLmdrAJFv5SwsUM/jwauAG5wz7PX8C+xRcPhslAMRhuksLoBS/PvZbSqUUInxua
	JhqAhmccwRN9XhkMlGw+IIG2MyX2iQ5WI9R+VE3Io+2wT0MQXhut29YUQMI5k5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FWrux9
	v6y5rUleKmFMXjNrcqAjOHZ4g5Edh3vQ9rr/1Zl2UfiRycKteuptm3kbkmJUxEdi
	3oPk7EgH8wWB3ATA8obH7MNAuqyLf3VYfWbRMvzz+vmL1wdKFSD3kw3nMQQOPawR
	3drvBMcEXtcx6BGmXWnLmOVZcUQTw0pnMB7dA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E27E5153;
	Mon, 19 Dec 2011 15:23:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D769B5152; Mon, 19 Dec 2011
 15:23:10 -0500 (EST)
In-Reply-To: <Pine.GSO.4.63.1112191114010.4136@shipon.roxen.com> ("Henrik
 =?utf-8?Q?Grubbstr=C3=B6m=22's?= message of "Mon, 19 Dec 2011 11:19:19 +0100
 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4540FF34-2A7F-11E1-85E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187470>

Henrik Grubbstr=C3=B6m <grubba@roxen.com> writes:

> We probably ought to have a corresponding test in the testsuite.
> A blob consisting of a singe 'A' followed by 8192 linefeeds should
> be sufficient to trigger the problems.

Sounds good. Please make it so.
