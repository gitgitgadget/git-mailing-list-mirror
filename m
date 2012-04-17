From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 08:50:01 -0700
Message-ID: <7vty0inys6.fsf@alter.siamese.dyndns.org>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino> <20120416221531.GA2299@goldbirke>
 <CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:50:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKAfc-0001S3-2y
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 17:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229Ab2DQPuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 11:50:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45241 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213Ab2DQPuF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 11:50:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB30D5619;
	Tue, 17 Apr 2012 11:50:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Xo7q443GIAcT
	x5rZvjV5A+pzLEs=; b=tuPUmb+DZSU3wQSN06XGqc54pCANVeTkaAAWTyP8fwJR
	ysEpcVmmSrJPCFsJ9FifUR3s+BbRkS5ehbw8mw/fDVUCl1QdOeTJfkH3cTlaRduy
	TSuiIietLQSSSnXtqBSU+Hg3KOChfbeBtrtXrm/j4lNXJqXC3F3HVN0EbHrho1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PrEDTh
	k1a9hU4hrWHlF/D7mmMZtekj3qvvzIHo0sPsz8bci6+hCcOlw9mxLoAaAFnzOmv5
	2SwUCBSs5i3vMFTGWgzFwzj+Ip/taM69dYofisN1VBAHqseis4zfFLlSOAaU8OeM
	COW+whwrA2Cs7FGGw1sbGzuXV6MRvob5epg3k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5F35617;
	Tue, 17 Apr 2012 11:50:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F8845614; Tue, 17 Apr 2012
 11:50:03 -0400 (EDT)
In-Reply-To: <CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 17 Apr 2012 01:33:25 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEF47CAC-88A4-11E1-BA01-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195767>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> 2012/4/17 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>> On Sun, Apr 15, 2012 at 04:37:18PM -0500, Jonathan Nieder wrote:
>>> Felipe Contreras wrote:
>
>>> A name like __git_complete should work, presumably.
>>
>> And foo_wrap() should also fit into those namespaces.
>
> Yeah, I don't have a problem with that, just forgot about it.
>
> But git_complete I think is different.

Is git_complete something the user types interactively, or is it meant =
to
be used in their .bashrc to help them complete arguments to their custo=
m
scripts that take arguments similar to Git Porcelains?
