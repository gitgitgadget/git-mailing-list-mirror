From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] gitweb: Improve ctags, introduce categories
Date: Fri, 29 Apr 2011 14:31:23 -0700
Message-ID: <7v8vuswxqs.fsf@alter.siamese.dyndns.org>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:32:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFvI9-0008No-RF
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 23:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933152Ab1D2Vbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 17:31:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab1D2Vbq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 17:31:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9C2A5085;
	Fri, 29 Apr 2011 17:33:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=syEMGiy9Mp/3gVUEYsPwN1UnJ3c=; b=Pqzjwm
	wL9tZ8SMwvduxQ411P4rnmv1pCdYeyXO2geS0TmPmP75FIA5UXxOGLh8czKS610+
	fAXGR0ZBPCLsh8Vs9ES1oPburFDAdQb9bjm0NSgMGEEUvQa5UWwvZJiENluOiguB
	EUis64ONdG2O4Lg2i8ioyKquy/WzKqPyRhtcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z3Vus0d8As2BYPeKQ2a+0l4j2QXgE5j/
	CfBrG46dy5ak5YD810Iop7LYM8353PpBEMjc9w3e1+OtSp8lkOPrxss8niYAOGwl
	toS0ugDK2wbvXdefphOZA981U8npKj0MoRriVc40MFJtUA4UmRZwPAIT4uaN2p42
	eSM9MUur4kI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D7B55083;
	Fri, 29 Apr 2011 17:33:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A6F9507F; Fri, 29 Apr 2011
 17:33:28 -0400 (EDT)
In-Reply-To: <1304099521-27617-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Fri, 29 Apr 2011 19:51:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 585CC8C6-72A8-11E0-AFAC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172495>

A tangent. It is curious why [PATCH 2/6] alone ended up with an encoded
"Subject" header, like this:

  Subject: =?UTF-8?q?=5BPATCH=202/6=5D=20gitweb=3A=20Change=20the=20
   way=20=22content=20tags=22=20=28=27ctags=27=29=20are=20handled?=

The message actually has the above as a long single line, as can be seen
at http://article.gmane.org/gmane.comp.version-control.git/172479/raw

Just being curious.

The headers suggest that sending MUA was git-send-email speaking to gmail
SMTP.  Did we introduce bugs to send-email recently?
