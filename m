From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git grep needle rev' attempts to access
 'rev:.../.gitattributes' in the worktree
Date: Tue, 09 Oct 2012 11:59:54 -0700
Message-ID: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
References: <5073E87D.9020100@viscovery.net>
 <CACsJy8BFmUr5_E47900T6j9Lgdvj96_dNbo2LHP5hLYq3w7ZLA@mail.gmail.com>
 <20121009120144.GA8780@do> <20121009124144.GB12465@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 21:00:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLf2H-0003EZ-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 21:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632Ab2JIS77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 14:59:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756595Ab2JIS75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 14:59:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9548A8ED7;
	Tue,  9 Oct 2012 14:59:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6yZEUEQYbHfuYiWWzo0wdd7NvJ0=; b=lKYQgh
	Da2/SYmWpLX71LZYtdapaIrjM+6fbKhr8BR5j3jtUuX8Uqn1Qf/qCjSrakBiiBqV
	VP1jRr/WI2NuTPF5Ep4j78+QZaoRpxnORlv3aUcxez22n97zamx/uwNhT//wbSRd
	G5Wa0VLNMgfywCNgWNHQzCFPjexwmqg4SztaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iyOhQuISB9B17MfpYfT+f2byUp1RU87K
	lhSlTTi+JkeK3WQAx8kx45SsfK2A2kSeQ2PSQP52ayelP5/JQ9H4n1tWQNfx4WPr
	XdqE/cY+nr3o2kqhEsui/aiwed33gKe6/uUQyM72OdXWIIvArfzqQ0VzfZPth3lG
	jaF7zVEe8SM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 823BA8ED6;
	Tue,  9 Oct 2012 14:59:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E07098ED4; Tue,  9 Oct 2012
 14:59:55 -0400 (EDT)
In-Reply-To: <20121009124144.GB12465@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 9 Oct 2012 08:41:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83E20A74-1243-11E2-A13C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207337>

Jeff King <peff@peff.net> writes:

> I think we just need to have callers of grep_source_init provide us with
> the actual pathname (or NULL, in the case of GREP_SOURCE_BUF). That is
> where the information is lost.

Yes.  I agree that is the right approach.
