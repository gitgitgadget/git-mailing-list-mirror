From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 15:18:24 -0700
Message-ID: <7vwr64s72n.fsf@alter.siamese.dyndns.org>
References: <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino> <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328215704.GB10795@sigill.intra.peff.net>
 <20120328220731.GC10795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD1CK-0001NP-T1
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 00:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758795Ab2C1WS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 18:18:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758072Ab2C1WS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 18:18:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECC777A0D;
	Wed, 28 Mar 2012 18:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p/t0SHcJUY51FLOPs7eCQjkWyMs=; b=uPS6Sx
	yw+vo/Ofz5APHz28L/LunTyikNafHDXErdM+L8tiwFDPwoYUAqIWNXnrjmCeCMuH
	3V8MQI9YH+p6A3KQ3Alc6X4aYOAhMBhgNb8GM4GX9pW79wP9AUptSQq8iv5DRqyx
	pmxBd5pbrQMblI7MdobXtit3T/1plf8jbxF1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KqCrqAJ7AP8/TF4v1ORrm8nkmtSSxOkL
	KiCYFLNsKXIo4go+o+fld+/TnlANz5oozgVqKr2W/shwehS7Y70bsi60gd1njQQa
	8YcOpN8TEvOilHh2Di7LuVae3M9gGaa59peW6CmRR76S65qNsfqCaOCeVu5L+urP
	8L/uYaNlBfs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E467A7A0B;
	Wed, 28 Mar 2012 18:18:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 643BC7A05; Wed, 28 Mar 2012
 18:18:26 -0400 (EDT)
In-Reply-To: <20120328220731.GC10795@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Mar 2012 18:07:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F08A2B34-7923-11E1-8B17-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194211>

Jeff King <peff@peff.net> writes:

> # this patch
> + git does-not-exist
> git: 'does-not-exist' is not a git command. See 'git --help'.
> + git yes
> yes
> + git no
> fatal: cannot exec 'git-no': Permission denied
> + git alias-yes
> yes
> + git alias-no
> fatal: cannot exec 'git-no': Permission denied

Looks sane and clean.
