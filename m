From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Tue, 14 Feb 2012 11:25:09 -0800
Message-ID: <7vpqdh6wve.fsf@alter.siamese.dyndns.org>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <7vehtyec64.fsf@alter.siamese.dyndns.org> <20120213203709.GA31671@ecki>
 <7vhayuctwm.fsf@alter.siamese.dyndns.org> <20120214092048.GC1762@ecki>
 <7vaa4l8diz.fsf@alter.siamese.dyndns.org>
 <20120214190515.GB12072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:25:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxO06-00067r-VX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 20:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab2BNTZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 14:25:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757004Ab2BNTZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 14:25:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DA4769FB;
	Tue, 14 Feb 2012 14:25:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U0Oib0xTS9W+1G7+W+I7/mMVMEc=; b=CXushw
	sd/BgtmLc+/iVJE3V4F3od5P4UMIUTlyQKpxtapcxXJofJWxqeWNY2ZaJKKmYZEO
	48IyzkSUkIeMQdDlsACozPLmi2OC6H/jPNWreLJSHk8LJBrms0d5GfCIAw4Dr+52
	MPaRFk1lXcQBrOg/N1vngeEwcUim89cbhhf+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VnC/sKp+QAJuSntGwKhnrbTE+RBMNTPw
	Kkq/GrxXxvnFlIIT0ZzVKWi4xgBbR+KrOtb/F7gD7vDwXsunM1TCFNmR1lfM8e1+
	V8qBuu3WFfNT77Y5SRVCvzMUakjJcim5MbEY6E8MJ4JFVSIuFhmd+YTgb+0S4pUV
	+OK2Kd2zlDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B3969FA;
	Tue, 14 Feb 2012 14:25:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56EA469F6; Tue, 14 Feb 2012
 14:25:11 -0500 (EST)
In-Reply-To: <20120214190515.GB12072@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 14 Feb 2012 14:05:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CDA4AF4-5741-11E1-AAE7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190737>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 14, 2012 at 10:40:04AM -0800, Junio C Hamano wrote:
>
>> I do not think tilde in $PATH is expanded by exec*p family to begin with,
>> so it is not "dash" but POSIX, I would think.  It is bash that is harming
>> other programs, by trying to be more helpful, encouraging this user
>> mistake to add ~ literally on the PATH.
>
> Hmm. There is an interesting ramification for run-command's "use_shell"
> optimization....
> But if your shell handles PATH entries differently, then there is a
> difference.

Yeah, I agree; that is exactly what I meant by bash harming users by
trying to be more helpful.
