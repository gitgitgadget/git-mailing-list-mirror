From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep while excluding files in a blacklist
Date: Tue, 17 Jan 2012 12:09:36 -0800
Message-ID: <7v4nvurszj.fsf@alter.siamese.dyndns.org>
References: <CA++fsGHGrNQzR-schP0yTXnD4jkYJjHHVk6QoJvfxPX9mguJPQ@mail.gmail.com>
 <CACsJy8A8eWt_wcxWrdjgmkHZpS1bBet7DTT-bRf9zrxfszUtjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dov Grobgeld <dov.grobgeld@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 21:09:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnFLl-00010c-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 21:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab2AQUJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 15:09:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab2AQUJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 15:09:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51013765C;
	Tue, 17 Jan 2012 15:09:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DaR1CZLYNSfgFaruQdhF7O0vmn0=; b=b58yTw
	hdu4R3K66IPhzBCpMI2c3sE42xTYm7zytMQZguzHVXj/TWH65kemSEgWGZFPSvwG
	SWGWXXQGpDiPgL+QOty/zZig3nuDzEfFZecSI6aiZRg2+qofVtPSdMiiR1K7kYTb
	uvDmxLibocw1kLi+llDscSUd15JPaBdVE/bG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sj71gwOH9JnDxKY93OFyHs07VlE3Yedh
	G3cptOXX0uVJwPTHcXyjwQj9f/rMOfHqGgUgwRWhVYB3VHCKXlYakTS99QZiPBO9
	krzEmAmQxh4ZkKcCj3nDxcS5VtDJJXJJpXke/i6mIeBJ8f4iidp4JGUZoU5sgeVa
	gmoi86Ftc5w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 487AF765B;
	Tue, 17 Jan 2012 15:09:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAE6B765A; Tue, 17 Jan 2012
 15:09:37 -0500 (EST)
In-Reply-To: <CACsJy8A8eWt_wcxWrdjgmkHZpS1bBet7DTT-bRf9zrxfszUtjw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 17 Jan 2012 16:19:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E9416D4-4147-11E1-B5FB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188717>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Jan 17, 2012 at 4:14 PM, Dov Grobgeld <dov.grobgeld@gmail.com> wrote:
>> Does git-grep allow searching for a pattern in all files *except*
>> files matching a pattern. E.g. in our project we have multiple DLL's
>> in git, but when searching I would like to exclude these for speed. Is
>> that possible with git-grep?
>
> Not from command line, no. You can put "*.dll" to .gitignore file then
> "git grep --exclude-standard".

No rush, but is this something we would eventually want to handle with the
negative pathspec?
