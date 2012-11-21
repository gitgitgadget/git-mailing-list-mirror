From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 11/15] remote-testgit: make clear the 'done' feature
Date: Wed, 21 Nov 2012 10:11:21 -0800
Message-ID: <7vy5hu3h11.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-12-git-send-email-felipe.contreras@gmail.com>
 <29291552-880A-4FEB-88E0-A73A1C7742F7@quendi.de>
 <CAMP44s0o1eP+aeT0AHu4uP1NPLqJq56qUDb-+F_x5NjoJCnf+A@mail.gmail.com>
 <EA56F0CC-7C93-491F-A076-4A1AA9593ED0@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:14:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFkr-0004Kn-Lz
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab2KUTOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732Ab2KUTOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A1469620;
	Wed, 21 Nov 2012 14:14:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Roi6bXLWB7IReCn0hn0ZwtoQbNM=; b=eUocVHzoY1V+dF/vTNdY
	Ms8lNr3TgIoIu1B30dz14fnBMWPauoYFuJwYEcSkm73a8V7dBgp5vKZbhBKa1P7n
	ytPPYxjNC6eCe5SUPC8YPhd9eJQAY99SHdj3CMK/L2QLBcoNkbqJts7CPU/s/JsR
	4TAfBz8j6LP736HrS3RZ6lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=uoAnw/cjAgYpYJ4PEVYBT2hRtM6ohWiCmOhgSVPe5OMb7h
	oXhq9FZWTgtHRSpHyf6ZjeuE87ZAXMeUbsSdM6KGo+TP/rVkct3pUZKQ8KoIr+S4
	lC2IZic3BrTTWoUOAx3+8w8aLo9QslPKusRnG3psw8Z85hndcUCunZNoNUVPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 461B4961F;
	Wed, 21 Nov 2012 14:14:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB278961D; Wed, 21 Nov 2012
 14:14:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6847902-340F-11E2-858E-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210155>

Max Horn <max@quendi.de> writes:

> Aha, now I understand what this patch is about. So I would suggest this alternate commit message:
>
>   remote-testgit: make it explicit clear that we use the 'done' feature
>
>   Previously we relied on passing '--use-done-feature ' to git fast-export, which is
>   easy to miss when looking at this script. Since remote-testgit is also a reference
>   implementation, we now explicitly output 'feature done' / 'done' to make it
>   crystal clear that we implement this feature.

I'd state it like this, but I may have guessed what Felipe intended
incorrectly.

    remote-testgit: advertise "done" feature and write "done" ourselves
    
    Instead of letting "fast-export" advertise the feature and ending
    its stream with "done", do it ourselves.  This way, it would make it
    more clear to people who want to write their own remote-helper to
    produce fast-export streams without using "fast-export
    --use-done-feature" that they are supposed to end their stream with
    "done".
