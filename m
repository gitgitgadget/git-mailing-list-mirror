From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/10] Stop starting pager recursively
Date: Tue, 28 Feb 2012 19:37:04 -0800
Message-ID: <7vr4xewbrz.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-3-git-send-email-pclouds@gmail.com>
 <7v4nua25cz.fsf@alter.siamese.dyndns.org>
 <7vipiqzsd8.fsf@alter.siamese.dyndns.org>
 <CACsJy8DJM5hwWnTs2rkhCa7a=vKRRsLMjZGBotmDDpAaGG+Sxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 04:37:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2aLs-0004wV-4T
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 04:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030716Ab2B2DhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 22:37:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757567Ab2B2DhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 22:37:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD45468C3;
	Tue, 28 Feb 2012 22:37:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aWdEVbSQc0+h6t+r+S5q3pyuUYE=; b=wKvA43
	85kZrtGuIHnch9idADNYJoLpVYJM8od82/RW1AvuoIKCpghe5Bbl622/P0A63GCL
	ft77HBKZdH+OM7GouFhMHIhqjJyB4xZlfUR0XqEc0RUeXlgHASBv7pZa9EX9vna0
	1oQOr62I6+lbmW5G0c6fIzOMIEuJxEh9tZc6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f9o4Y2kT8EAPDLonJPj0YR9u41P1n+f+
	jkMiE/th+RNnkdVdrVAXHdN+t3DjmySebQWAgyYgbsfdGXXjDXVi2iWaKG9iJT/J
	S+rmmzz1ae6/byMnNL/dFkYTIS1QN7SRm9jADIENvZMKqkuC0ChtUKKOAJMe4pU9
	pTt4ngCvRgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4B0E68C2;
	Tue, 28 Feb 2012 22:37:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D7B468C1; Tue, 28 Feb 2012
 22:37:06 -0500 (EST)
In-Reply-To: <CACsJy8DJM5hwWnTs2rkhCa7a=vKRRsLMjZGBotmDDpAaGG+Sxw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 29 Feb 2012 08:54:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6DF5DAA-6286-11E1-AA25-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191805>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It does improve that situation, or at least it stops git from forking
> frantically.

That "at least" sounds suspicious ;-) Do you mean that there is other
breakages in that mode of operation?
