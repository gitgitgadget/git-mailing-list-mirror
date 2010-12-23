From: Junio C Hamano <gitster@pobox.com>
Subject: Re: StandardInput Not Continuing Process
Date: Thu, 23 Dec 2010 09:20:10 -0800
Message-ID: <7vbp4c2yph.fsf@alter.siamese.dyndns.org>
References: <AANLkTikBdOLjzJxikXCwTs52RByfNZzKamK+F-JhY0mQ@mail.gmail.com>
 <AANLkTikvrDWYT8h_MCESd9sg4_8ykSOq3XFEsoNsYDuZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chase Brammer <cbrammer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 18:20:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVoq0-0001zj-Tj
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 18:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab0LWRUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 12:20:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0LWRUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 12:20:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 67CD63269;
	Thu, 23 Dec 2010 12:20:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LEi+1VbZ4S20x4f1wPO/aWZK0SA=; b=sOKSud
	SD6E4/g2yWdlnoTcPllUbWqi7y3vEEjMUBZ56vjOq94CVxJtMMaiLdYojcCfx8Ji
	Dg337kSOMg+rwcGfotUO8KGodz/uGZ0ELRT0SjKlNybM6/rHWgOBo2p9u/ZMz6cQ
	LfbaK1/veuqfec5cEnfz74OPgsTbleQNzAvUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YIHaIcOW5W3BNpPwItu8+2IGnSTNQae7
	FvqE+fIPEMc5t0rh0EAyYwsZPg8WUiUxoBBnPzAubCo0L50DjCDOIDpvdFrlm5es
	WC+vQfXKYemjOM8Y0EdpLQWsR1uExJ0ZyNn+Z23Vr2rv2zMuQQCDtw8x/lwborz8
	WeLxYhQYqRc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 459953268;
	Thu, 23 Dec 2010 12:20:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6EEEA3264; Thu, 23 Dec 2010
 12:20:41 -0500 (EST)
In-Reply-To: <AANLkTikvrDWYT8h_MCESd9sg4_8ykSOq3XFEsoNsYDuZ@mail.gmail.com>
 (Chase Brammer's message of "Thu\, 23 Dec 2010 09\:55\:02 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F96BAF6A-0EB8-11E0-96AA-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164133>

Certain things do want a real user sitting at the terminal (or GUI) even
when the standard streams are connected elsewhere, and password input
is one of the obvious things that would explicitly want to read from the
tty.

Perhaps driving whatever script you are writing via "expect" would work?
