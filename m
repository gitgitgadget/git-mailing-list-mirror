From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Fri, 22 Mar 2013 13:42:13 -0700
Message-ID: <7vehf76uai.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
 <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
 <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
 <7vsj3pdcm5.fsf@alter.siamese.dyndns.org>
 <CALkWK0kHFHtsy1Eh+jnY-JNSDUYd2xtiavhPNjaT8H3mJvYZkA@mail.gmail.com>
 <20130322182550.GF12223@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 21:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ8nV-0002xA-3J
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 21:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422993Ab3CVUmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 16:42:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422937Ab3CVUmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 16:42:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80584B0B5;
	Fri, 22 Mar 2013 16:42:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1s40PN50tWGMxCVi7rKSrICv0hQ=; b=ZK29uq
	rXQjAm3k0CJXYp7+o4wrKi4DvfDYoPmLUyxhtpxUNnuaGCkbcz17VVd4AK/CZx8p
	GZgGZdebvGRWTfXRLpiChrBEXbCCdbp0HRCzDDuKn4JwP49ymei68TGg2Vv+6kBP
	tiMWPhiecnlAhniPAHIQbjoBckCqWL8Kdh1wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trtqu56CX4RVLXFSHHAeVgYmXsUTCcqX
	hq/vFSKlKnDIg/XoT+4yd6D8JrtZDe0BS5hzRtV5BFF6hNV+IdWxLeJphhdzny+x
	0jv1efI2vDwY89CzjtsrWN08xigys197IySEcVy22Xg4lk84TExfrZcL3A6JRano
	g54VaJ/kP1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7426EB0B4;
	Fri, 22 Mar 2013 16:42:15 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EADA9B0B1; Fri, 22 Mar 2013
 16:42:14 -0400 (EDT)
In-Reply-To: <20130322182550.GF12223@google.com> (Jonathan Nieder's message
 of "Fri, 22 Mar 2013 11:25:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAC89B12-9330-11E2-BAFC-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218842>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> I'd really to have that final 'git continue' in Git 2.0.  Can someone
>> attempt to break up the migration path into manageable logical steps
>> that we can start working on?
>
> Is there any deadline or migration path needed?  Depending on the
> design, it might be possible to do without backward-incompatible
> changes, meaning the migration path is "whatever someone feels like
> implementing first lands first".

FWIW, I am not convinced yet why we would even want "git continue"
in the first place, so I won't be the one who would be suggesting a
migration path.
