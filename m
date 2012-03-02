From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 04/10] column: add dense layout support
Date: Fri, 02 Mar 2012 09:37:17 -0800
Message-ID: <7vwr72ewfm.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-5-git-send-email-pclouds@gmail.com>
 <7vty2azudf.fsf@alter.siamese.dyndns.org>
 <CACsJy8CdmK0827qjiW6-tCkhpGK5Prkhb=bt7wPgAuSsf1qpDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 18:37:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3WQ2-0002Lo-KD
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 18:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265Ab2CBRhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 12:37:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351Ab2CBRhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 12:37:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B8207623;
	Fri,  2 Mar 2012 12:37:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=leQFoYJAdK1bK1UOizlQM+u6e2w=; b=TAKhOE
	8TlglLbyd3lV4tWL6fw7tR2GCDETjs/D6uVY+a+J4QJr5KbfXRytXTMzrFARUW8/
	4S00Vnl6NYoAnaWgGYQJDM+R4GnI0QgkhitwRJ2a3+ri6aM5x7xY6EEpR8R/o0iE
	SCYgRKkGQRSCWArTRDhA6yqTiOn+3oqtBZDAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fWvKGG2ELFlj8KQTzNief12vWFBWP2M0
	G4MpZ1HBeWYBTfrjFP5kjAJNZfBdPTCAqFoh1rb98MJj64P2ikJUVh8fMn8YTOsr
	USQGZFP7w4N5YNlgFwXVE3xr0Q1S0xUCFAqSBkf/kb2kY+rMJrL4yziS9YehFo64
	Fj+hKhVbLgM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 526C17622;
	Fri,  2 Mar 2012 12:37:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD4287621; Fri,  2 Mar 2012
 12:37:18 -0500 (EST)
In-Reply-To: <CACsJy8CdmK0827qjiW6-tCkhpGK5Prkhb=bt7wPgAuSsf1qpDw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 2 Mar 2012 19:47:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BFBA3F2-648E-11E1-A041-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192054>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I reserve the 4 bits for strategies to fill the layout.
> ... Maybe
> COL_LAYOUT_COLUMN, COL_LAYOUT_ROW, COL_WIDTH_DENSE (and
> COL_WIDTH_EQUAL) would be better names

OK, so these 4-bits are more like layout-bits?  That makes sense.
