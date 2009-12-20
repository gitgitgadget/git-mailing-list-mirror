From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: abort cleanly if the editor fails to launch
Date: Sat, 19 Dec 2009 23:24:10 -0800
Message-ID: <7vmy1ecdlx.fsf@alter.siamese.dyndns.org>
References: <4B2CC133.9010704@gmail.com>
 <7v8wcy7kyc.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0912192156030.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 20 08:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMG9T-00039E-Eu
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 08:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbZLTHYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 02:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbZLTHYV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 02:24:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZLTHYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 02:24:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 327F9A8FAB;
	Sun, 20 Dec 2009 02:24:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbzIftvNIf905jb/PazkXQxenHY=; b=tsJZIK
	Fdo6AHmYuxFtiMqInSdwyXJzPaabAjBWKAP0POkNqnV4buaiNc6zxuJ0kFdp2Ovh
	pxm4ZDml/2BW9G8ZstDsa/l8iy6APS1f65CoM7QVC2UA70ez2m+iQbnMQDKw9y3l
	SxonJhdm0cpHoCBGnGV8fkKoq81wnjIc6kWj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VY/4K7Dr8pmEwgH2P91DsW4L62cFs6yp
	ZQgOwiYMA6JvqltXzMaHADL66xFwWYkRCFOWZ6u7okrMLcgqt7nMYBybzoNmOpxB
	dzas6IT0e9aF6YDzC3UiIHKn/f2BtAoPnE2EzkjVFuMzjEo8ON27zSHKRqsd1fv+
	EYTeLiqtCMA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01D4BA8FAA;
	Sun, 20 Dec 2009 02:24:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E6BA7A8FA9; Sun, 20 Dec 2009
 02:24:12 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0912192156030.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat\, 19 Dec 2009 21\:57\:16 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE861910-ED38-11DE-A57E-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135522>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The non-existent editor also aborts with a non-zero status.

Thanks; that is a good point.  Perhaps we might want to say what editor we
tried to run in the error message.

>> An editor that can exit with non-zero status on demand could use this
>> codepath to abort the rebase,
>
> Removing all lines of the edit script will abort an interactive rebase.

I guess you replied too fast without reading the message to the end ;-)
