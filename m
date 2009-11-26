From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 16:02:57 -0800
Message-ID: <7v8wdup2z2.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <7vtywiqmbs.fsf@alter.siamese.dyndns.org>
 <20091125222625.GB2861@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:03:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRpI-0003N5-Sq
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbZKZADA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbZKZADA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:03:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024AbZKZAC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:02:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6560DA165C;
	Wed, 25 Nov 2009 19:03:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eTV4kpfGO3BF38CHAn0n6+L+Ieg=; b=R7FvXi
	E5atO8fM/fZP9y//qEEHIm63udRGSMdr2ZD3RiQXQujfKI0Ucha2LcJXxqSuOLtf
	20NcUWGHR2B47wQFUX1cjUMhPU7r7ceEU5K2Wb6K+GBUZCQ72xzMzAlAHN2fk3BS
	YMqRL2Gfi9ija8IUFmOty65sDHJQ2vLVPFpkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pyEQHdHlJZMfdQ2LvGaiw85GkKNtMZU9
	ml9tKSexZ4YJiR5Ny01nuDQrTNvBtCRbC2AQajc498zypQXUBEmRPnPRtHynTMnm
	Q6N0Bt4mWl5CAmiV9cg7EJOI0q5pFVOTH8teQFws4LwnNzY2hpWJp2xf3YE8W/BK
	2C1yjvx8wa4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44AC7A1659;
	Wed, 25 Nov 2009 19:03:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2980DA1657; Wed, 25 Nov 2009
 19:02:58 -0500 (EST)
In-Reply-To: <20091125222625.GB2861@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 25 Nov 2009 17\:26\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10712246-DA1F-11DE-B959-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133711>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 25, 2009 at 02:19:35PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > ... That is, I don't want to have to remember "git grep
>> > --full-tree" or "git grep /" every time
>> 
>> But that cuts both ways.  If you change the default to full-tree,
>> people will forget to put "." every time when asking to limit to the
>> current directory.
>
> I know. Which is why I am arguing for a configuration option.

Yeah; what is your take on tr/reset-checkout-patch topic, by the way?  I
do not particularly like a configuration that changes the behaviour of a
command in a drastic way---it will make helping others much harder, but I
guess it should be Ok?

This may sound like an OffTopic, but because we _are_ discussing
consistency, it matters.
