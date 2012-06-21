From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Thu, 21 Jun 2012 10:22:16 -0700
Message-ID: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
References: <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1339469396-29677-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <vpqhau4sixw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 21 19:22:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shl5L-00072G-F2
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 19:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759960Ab2FURWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 13:22:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759949Ab2FURWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 13:22:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 479B5927C;
	Thu, 21 Jun 2012 13:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SPubjyLKzYVY4bbKsHjQOmuz9X4=; b=yVmunY
	B18oK0zeIq6+Ml4hiDMtdjOOKm/DBc/Rg/QvVReGRxYJ20ytCYeotsCyEsz+PiWx
	wIZ8cdEdgWENp5+ZEhwGSWzoPYwgso2E/QzzxcnZZqQMydertjn0+BX0njuFQiE/
	t8hqkyqGkKrbSWi5c5ndKmZkjiEMGkZRwsoks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q5Vh5p+rxz8lWrPep8Y/9wOp8YCEsViP
	tfhrLx2jJcQLe95D7tEz3wxf9/MFlTuZ6eLY2nhJPDu8byLM5Q91D3pZxuYl9whW
	Yv9BLst9O6GjHmGOVgLA79aFfci63d8vvMNh3TKl0a/NMyS4rIa09afmEMsdb5WZ
	l93NC9YRtqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EE60927B;
	Thu, 21 Jun 2012 13:22:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2933927A; Thu, 21 Jun 2012
 13:22:17 -0400 (EDT)
In-Reply-To: <vpqhau4sixw.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 21 Jun 2012 18:55:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6C0B498-BBC5-11E1-ABE0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200410>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> writes:
>
>> Git will be able to read from $XDG_CONFIG_HOME/git/config, a new
>> configuration file following XDG specification. In the order of
>> reading, this file is between global configuration file and system
>> wide configuration file. Git currently does not write to this new
>> configuration file. If $XDG_CONFIG_HOME is either not set or empty,
>> $HOME/.config/git/config will be used.
>
> What happened to this serie? I think all comments have been addressed,
> but I don't see it in pu... Should I resend and Cc Junio ?

If it is ready for testing, please do.  I wasn't interested and was
not paying attention during the feature freeze.
