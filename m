From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: don't infloop for an empty input file
Date: Sun, 26 Feb 2012 15:58:08 -0800
Message-ID: <7vty2dcflb.fsf@alter.siamese.dyndns.org>
References: <87399y24wt.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Feb 27 00:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1nyq-0004cn-Rd
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 00:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab2BZX6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 18:58:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381Ab2BZX6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 18:58:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1CF07B5A;
	Sun, 26 Feb 2012 18:58:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+SRHbNYs83rtg6F9fJGw3xshjY=; b=WDY53M
	FH1r8J0Jey7Cl55zh6b5QZVDpEccibG4qeNMg7STOSRerAtviiBDeOssguRfAN3q
	OWDy2TGLUBLO0wlSdhZOO9NC3W99N4/1esuwaLskSC7gQMYW5oBaYANZjrTTgvkl
	m3hhSENfW1X8Gk54QOufqqpf0fB89OlmMf5Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IGsjxwLCE7OlyWNpNES9bTKe7uh1MKvc
	kqGdwlcRx5LBLEUwnmx7F4DGRRa8Uk7ZV7VBJhGkncQ+iIJe3cq1eZ1QyezjhrGA
	xi1q+08D2qkZpGc8zeNj7ZU8qFRSTI/tHhndBiVMNW3ZU6GfiCUsxdpJE9xSueAH
	lWLadlZJuuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D98647B59;
	Sun, 26 Feb 2012 18:58:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D0D27B58; Sun, 26 Feb 2012
 18:58:10 -0500 (EST)
In-Reply-To: <87399y24wt.fsf@rho.meyering.net> (Jim Meyering's message of
 "Sat, 25 Feb 2012 18:34:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC7F0672-60D5-11E1-AB55-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191584>

Jim Meyering <jim@meyering.net> writes:

> Today, "git am" surprised me.
> I mistakenly ran it on an empty file and it went into an infinite loop.

Yeah, that is an embarrassing regression in 1.7.7.

Thanks for noticing.
