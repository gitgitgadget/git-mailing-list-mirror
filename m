From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 23:33:58 -0800
Message-ID: <7v3a1oyrkp.fsf@alter.siamese.dyndns.org>
References: <20100129012350.GD20488@spearce.org>
 <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
 <20100129183705.GB22101@spearce.org>
 <7vockc45ut.fsf@alter.siamese.dyndns.org>
 <7vmxzw15dt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 08:34:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb7qT-00085h-IX
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 08:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab0A3HeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 02:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475Ab0A3HeM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 02:34:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0A3HeL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 02:34:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D787695DAB;
	Sat, 30 Jan 2010 02:34:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fqnYuKS9bwPnAW2DiVdHu76/8b8=; b=jm34ev
	UOa9bicCxcwcKK3N+WtQFNICbiSlCSxIREOrGm/aYrC8t5Pu1u3nb3sxOXojW5pe
	SZcwchcH1+N6vBSqsT3OJXuWx62xeZy7tszLS/FWwUquPWe86w2WQH9DCC4E3KKU
	Qrha7IUytp/pbZJ1831UbWj6r6ouXS72xElt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hu48rSv7gR/bpET/3sP5xAOLvMIsWBNs
	qf1ZfeiCyMiVKFY6VmWpjCQJwKYcACy4r4JyQInL7uRgZWDO6Bwje5dne2IgVrtD
	FthVb3JRLSmsORKTsA4DceylmC/ihXIC5KsFATb1yyZxfndJd5ngUFjTcqqULX1Y
	DEyK/yTBBYY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 977E795DAA;
	Sat, 30 Jan 2010 02:34:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF61E95DA6; Sat, 30 Jan
 2010 02:34:00 -0500 (EST)
In-Reply-To: <7vmxzw15dt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 29 Jan 2010 22\:19\:42 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D84EE156-0D71-11DF-BCFC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138459>

I'll queued this with a result of my conflict resolution to 'pu' for now
but please double check after I push it out.

You may want to add the new option to the output from "cmd -h" and
probably description of the configuration in the doc before any of this
gets official.
