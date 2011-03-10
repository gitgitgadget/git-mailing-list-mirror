From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using libgit2 code in git.git as a Google Summer of Code
 project?
Date: Thu, 10 Mar 2011 11:27:30 -0800
Message-ID: <7vlj0m4vz1.fsf@alter.siamese.dyndns.org>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
 <20110310101332.GC26851@elie>
 <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
 <20110310115549.GA31046@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vicent Marti <tanoku@gmail.com>, libgit2@librelist.com,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 20:27:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxlWZ-0001WE-RG
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 20:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab1CJT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 14:27:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab1CJT1q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 14:27:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B05C33531;
	Thu, 10 Mar 2011 14:29:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Acr/rqlo0NXbv5BZdWw4gUATI4=; b=HlC/Nl
	OBTP7JNiXRqZSDfEPWIXeiKGuvU3Ebzthijmq1aWCdYDP5ZfeJaLYEmwdfTbZcvF
	mPkEctYDzEWOmZhY2oAs8jguJlmZ61zZdqpfcdE1FKCDfm+0/IOyfrYdVPrDrzBX
	KvqMwmBoz/L2lW3xSfnuskTXxFnT3dHpC6pM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=itzkxm6TBq5q0FGZcHYyflwKQxgyV0WP
	VAfM8CulJtvKUe1SJkS/7P0+JJBGQ1WjECIViR5yVKvH3EIfW7FaftSPj918xIwS
	kfanjZtWykC7xul3ajl7cDIzjjBzEBqWhw3/DBn18g5tyzgB9de6O2bAvLS2O0QR
	n2DFHdN0WvY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E9023527;
	Thu, 10 Mar 2011 14:29:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA61F3525; Thu, 10 Mar 2011
 14:29:00 -0500 (EST)
In-Reply-To: <20110310115549.GA31046@elie> (Jonathan Nieder's message of
 "Thu, 10 Mar 2011 05:55:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA9BCB24-4B4C-11E0-A3A6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168845>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I think that right now it would be a quite daunting task to start
>> replacing parts of git.git with libgit2. The architecture changes
>> required would be quite significant, because of the way that git.git
>> and libgit2 are designed (Unix-only, non-reentrant/cross-platform,
>> reentrant)

How big a performance penalty does libgit2 have to pay to depart from many
"we run once and let exit take care of cleaning up after us" patterns used
in git.git primarily in order to avoid the housekeeping cost?
