From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] remote-hg: support for notes
Date: Thu, 29 Aug 2013 11:45:15 -0700
Message-ID: <xmqqa9k049qc.fsf@gitster.dls.corp.google.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7Df-0005nu-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab3H2SpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:45:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200Ab3H2SpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:45:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FBAA3DA3B;
	Thu, 29 Aug 2013 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ifCOaAR5TGyeyMpZnCn4FopZWsc=; b=K7EwvV
	Zy8V/iX1a/72L3I2EQ/eRr7kR3m2mOd+eefq3y+9HLck/uAGeGgBlIeWqtxjW07b
	zqNnWNBARfCDRVKBhWNrvrZooOq010eU11r8TPmYbruwMJTZp4q5WnOKxVekRXT8
	BOLON6S5dHjSd4KnPbf2pSi3pr5wa7hmWu/dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JaCR/oS8sTWI2EsO/4WyZ175Tc8O9ayq
	5CgRG2KFOYUOeU3hduwOJh7PxhrEuG/Oh66YuxymeX1lsXC/qj/PZieSTsDN6ztL
	pyMxOU4BcLiMVB8aSiK+cYEKHLQIwZ/ZW5YHMh/DbLD4YHcDAF74EPXIJoQ7peKV
	D72U0a4wQgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 738ED3DA3A;
	Thu, 29 Aug 2013 18:45:18 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC9B03DA38;
	Thu, 29 Aug 2013 18:45:17 +0000 (UTC)
In-Reply-To: <1377717793-27170-9-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 28 Aug 2013 14:23:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 264EC7AC-10DB-11E3-ACFB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233333>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> @@ -629,6 +657,7 @@ def do_import(parser):
>          print "feature import-marks=%s" % path
>      print "feature export-marks=%s" % path
>      print "feature force"
> +    print "feature notes"

The remaining patches in the series seem reasonable, but this patch
seems to rely on an undefined feature "notes", whose design has not
been discussed here.  Will queue without this one for now.
