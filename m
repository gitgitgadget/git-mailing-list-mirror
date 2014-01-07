From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/17] remove_dir_recurse(): handle disappearing files and directories
Date: Tue, 07 Jan 2014 09:27:21 -0800
Message-ID: <xmqq8uurg0sm.fsf@gitster.dls.corp.google.com>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
	<1389015935-21936-14-git-send-email-mhagger@alum.mit.edu>
	<xmqqy52tht2l.fsf@gitster.dls.corp.google.com>
	<52CBD1D5.5080701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:27:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0aRE-00077Y-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbaAGR1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:27:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbaAGR12 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:27:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30D926082F;
	Tue,  7 Jan 2014 12:27:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y9MtjWn4SkKVEZnt1H2PloYO1mY=; b=xaPknr
	MpbH4ns9/bBb7+stViHb1Edti2jy6LQC2LtRhYYvxibYfURNUUDWj/92ppmp/utq
	PdBW2jbpVYhnczz1Xf13U0whsBmUS9QgkFJ5b8GlHwYuXtPMDbkG35+1xbiXOUGG
	jrdW7z+ElThL1di098Jtn6rS8cSQrF8NiBY98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1rmZlqPOA+45ZcivT+cKUavNZpKGINh
	OMtaflYzoiPyBfQ1Y4uI3/bq6GKN4X1ufv5WE7nB/LmzkTcAUexoMZ4YxfeEsDOF
	A7QP7pJ2V6vVa77HCbj4tx45jwCLFNSKpr5PM0usFEe5pWuxSTJY5jKJNpZa2WiQ
	XwuXY2lP7tg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6416082C;
	Tue,  7 Jan 2014 12:27:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 035B060824;
	Tue,  7 Jan 2014 12:27:22 -0500 (EST)
In-Reply-To: <52CBD1D5.5080701@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 07 Jan 2014 11:07:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F80CA4B6-77C0-11E3-A717-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240114>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I'm not sure I understand your point.  Please note that the
> REMOVE_DIR_KEEP_TOPLEVEL bit is cleared from flags before this function
> recurses.  So in recursive invocations, keep_toplevel will always be
> false, and the rmdir(path->buf) codepath will be permitted.  Does that
> answer your question?

Yes; thanks.
