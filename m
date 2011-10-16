From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg.c: Fix an "dubious one-bit signed
 bitfield" sparse error
Date: Sat, 15 Oct 2011 20:19:42 -0700
Message-ID: <7vbothtt7g.fsf@alter.siamese.dyndns.org>
References: <4E99C713.4090802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Oct 16 07:13:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFJ2C-0002mg-VA
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 07:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab1JPFNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 01:13:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab1JPFNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 01:13:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F78A2B08;
	Sun, 16 Oct 2011 01:13:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Fn6jyH991kGbIgWt9kHN1eshnOE=; b=tczm2l9pFiTAAl2PX3cM
	GKRt+XzUKLuBol3+/F5rgNhLVaWhbK9nC0KMAirbh6GPUlaMKHYR9CDMx0Fblrcn
	6hLlx3+1fJHUwciyutHzflo7GY3b7o9HIGPWpqJkOxIkcFYInYAtY9x+1lClax/W
	lgWdtVnVpdiaF38duYHUEDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ORsrJHMCcYuzVbZaL4C/oiSI/DlFpbY12P3/BT+Vge2jI/
	3QY88oTHX3dnOqIIfBMEi1ErTDOuyJfflVSoykTctuG7pDMNh7xLQTWqCOpyBpLV
	8tB0oxBDe9aV9WHc9wReqf8T6iBqWdw/Ro0Z24dOn3tCb0PrkpFvPJmqmqGB8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07F442B07;
	Sun, 16 Oct 2011 01:13:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 961E02B06; Sun, 16 Oct 2011
 01:13:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89542DEC-F7B5-11E0-AA57-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183689>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>  struct origin_data {
>  	unsigned char sha1[20];
> -	int is_local_branch:1;
> +	unsigned int is_local_branch:1;

Thanks, I overlooked this one.
