From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Tue, 26 Apr 2011 22:39:28 -0700
Message-ID: <7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <7vwrig9ta7.fsf@alter.siamese.dyndns.org>
 <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
 <7vsjt49stq.fsf@alter.siamese.dyndns.org>
 <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QExTS-0002X7-H9
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001Ab1D0Fji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 01:39:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1D0Fjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 01:39:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 242E55DE8;
	Wed, 27 Apr 2011 01:41:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/dH61jMYnuejIJ48lqNQcaERUUI=; b=jhM+v6
	VdgmESkLD+yPMpsbdpERQw9PNBj1vmCPub2Inr1ImLrvnrjbt6MtzbRRWjyNPyk+
	u5uDqdLcJhQfHPZ+418xum477y7dL6koX973cR8BQTSDmYsDnWDcRy2HWEBo14uT
	V0RRKBJBuv5QwpcxLx2gX2DMOjWhO5JHZo0Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lIAgWUK0xb7iFeCsk5diVfBbFJN+HU3R
	ooN0BytkWBC5sycrHl48IP4B3TyLKeiuRJMo2MNImz5Cv+y30iNJwYiOQnb6fmxB
	R0CwAMFaRciq+Xne8jWHT1uYs1P6O5FgCmoVdZCJzPP6FNHd0Ftn0CY7F/MrhMeP
	sh0SCq1+zTQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFA705DE7;
	Wed, 27 Apr 2011 01:41:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F2E4D5DE6; Wed, 27 Apr 2011
 01:41:32 -0400 (EDT)
In-Reply-To: <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com> (Jon
 Seymour's message of "Wed, 27 Apr 2011 15:33:57 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03E4B25E-7091-11E0-9C31-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172176>

Jon Seymour <jon.seymour@gmail.com> writes:

> My thoughts about this are inspired by how the node project manages
> packages with its npm package manager and also the fact that I have
> several ideas on the boil at the moment that would definitely benefit
> from a standard way to manage these concerns.

Sounds like you have a plan ;-)

It would be ideal if you can arrange things so that the only thing the
user needs to do is to point your package manager to one subdirectory of
contrib/ and everything necessary would be installed...
