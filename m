From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] The design of new pathspec features
Date: Mon, 28 Jan 2013 21:07:20 -0800
Message-ID: <7vlibctw53.fsf@alter.siamese.dyndns.org>
References: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 06:07:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U03Q9-0004aN-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 06:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab3A2FHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 00:07:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab3A2FHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 00:07:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52E008450;
	Tue, 29 Jan 2013 00:07:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UKqvs/azqLLfyPh/XFRenysRtyM=; b=JS8i6w
	aEnnewDXIC0zsBkUdLDWCuFQ1lx2XLRJXhDnEjmu+fwQkrrAW67I1gEQUfwzxKuM
	zHHtjNFZB59jAJzUG+O+lmg0pJl2yslDNHJXOszRxmskZojv77EaccF7OsZdP07A
	Kc3zVfJWmtNlyvhdpn/VNLvH6PLECu8+K2sqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IN3XPECvGUkwrI4bP277i65q1T34bvJP
	im0MAaOf9b2mdG3//+wpl1ckmTe4INCG+/61zjwB1fWpsVh2Z/mNKze8R78mwm+V
	DJe6hYX3Xps/8BpOVFQKUz+yzs/DbWCKFnlJ6Z6OE7YheRrZzG3UxcOFSQbMEzrS
	6FQcJVrJNhI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46644844F;
	Tue, 29 Jan 2013 00:07:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 942DF844E; Tue, 29 Jan 2013
 00:07:22 -0500 (EST)
In-Reply-To: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal> (Duy
 Nguyen's message of "Tue, 29 Jan 2013 11:35:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3A76114-69D1-11E2-BB3C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214901>

Duy Nguyen <pclouds@gmail.com> writes:

> For those who haven't followed closely, some coming changes allow us
> to extend current pathspec syntax. We should soon be able to do
> case-insenstive matching for example, or introduce "**" wildcard that
> is currently used by gitignore. I just want to discuss about the new
> syntax and behavior.
>
> Many of these are already implemented in [1]. But I don't want you to
> bother with buggy code yet. I'll resend it soon after 1.8.2.

I think I agree with everything up to the "fnmatch(~FNM_PATHNAME)"
part, from a quick read.

Thanks for writing this up.
