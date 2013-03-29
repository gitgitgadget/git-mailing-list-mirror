From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reading remote reflogs
Date: Fri, 29 Mar 2013 15:58:19 -0700
Message-ID: <7v8v55n790.fsf@alter.siamese.dyndns.org>
References: <1364595928.30202.4.camel@localhost>
 <7vd2uhn7u1.fsf@alter.siamese.dyndns.org>
 <1364597780.30202.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 23:58:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULiG2-00055d-QK
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 23:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242Ab3C2W6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 18:58:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757227Ab3C2W6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 18:58:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E156FE80;
	Fri, 29 Mar 2013 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kEimzbsAWbp8Ba2p+Mu6J0HYvus=; b=YRYkXe
	EFmyDVg3wwF0p6kmE/mlCzADn9jxLCD74h0gcTUZ9Fazlu3cpUy4IeeRot2/U3b0
	muVqU8Lm6D9uX6sJ5xhEdQDv51W1JbXBxJtBQ3VoSptUxCKfl/xvChmEcKalsGMI
	1yXD8MrDSv1370eCf4isLqFWahdYsV3hAvujo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vCXaullV5twe/KHbHWlo6BC5cPcDtpOg
	NwAwGMR7cOjDjM3CD5XE3Uc2zOUHIA4A8SIWjvU7JL4v6Vn4S6CESUxzn5icfz36
	2Zghwzeqtl2kBqjEuVnZRP6B6MYogaFLFRXoydvZURLxZWQVyilVrLyHwwF/zAH/
	9RZgNaHg4F0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02716FE7F;
	Fri, 29 Mar 2013 22:58:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79A83FE7D; Fri, 29 Mar 2013
 22:58:21 +0000 (UTC)
In-Reply-To: <1364597780.30202.7.camel@localhost> (Dennis Kaarsemaker's
 message of "Fri, 29 Mar 2013 23:56:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 274F785C-98C4-11E2-AA2C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219538>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On vr, 2013-03-29 at 15:45 -0700, Junio C Hamano wrote:
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>> 
>> > ... Mirrored repositories don't
>> > maintain a reflog, even with core.logAllRefUpdates = true,...
>> 
>> Are you sure about this?  When log_all_ref_updates is not set, by
>> default we do not log for bare repositories, but other than that, we
>> do not do anything special with respect to reflogs.
>
> I was, as I tried the recipe below, though with a different repo. Must
> have goofed something up, as it works now. Thanks for the braincheck :)
>
> That gives me a reasonable approximation of distinct pushes if I pull
> the mirror often enough.

Instead of polling, why not "git push --mirror" whenever the
original gets updated?
