From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Mon, 14 Apr 2014 15:28:51 -0700
Message-ID: <xmqqtx9vlf4s.fsf@gitster.dls.corp.google.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	<vpqsipkmeum.fsf@anie.imag.fr>
	<D2BF8546-87B4-431A-B86D-6EFAF205279C@gmail.com>
	<vpq4n1zg4f9.fsf@anie.imag.fr>
	<D3916156-0F84-4DD2-833F-64DF675325D3@gmail.com>
	<vpq38hi8oj3.fsf@anie.imag.fr>
	<32c0335e91b9658a9cca007f6851280@74d39fa044aa309eaea14b9f57fe79c>
	<vpq8ur85neh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 15 00:29:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZpN7-000188-8y
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 00:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbaDNW25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 18:28:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbaDNW2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 18:28:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E4077D32A;
	Mon, 14 Apr 2014 18:28:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ilV2kETTEuknyFyPL/AycoAITc=; b=IS41TP
	NsM7VvwU+BNEOwBGlC2H1KwVpuLhdH8VR6/NWA1K8RUiiI9YXIP5VIVlEUyPf4Ne
	sNuEnukzG/IRho/t8Wb88nyTvxaA+huhsd+l618w9DJ5T6HBzZOfo6X6GjEroj/p
	xgA28lsag0X8QmoDifTKd47Mx4hB+cF9s/Vcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQ0wxsQbueR0e3Xs+Ozgs0EfZR1fnQ3P
	N0Rof+7I4mdPrBl7sn7yfuomH8laikz2AVvBXvJGf60nbbS4IGv3ae7VAJEyhzgq
	k1lHvONq+bEl12sC00TGfaSa2mpml89SkCiYN8VWP6f83YTHeAtEnvj9HlQcqONd
	GkhjffyHW8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F3007D327;
	Mon, 14 Apr 2014 18:28:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCB317D322;
	Mon, 14 Apr 2014 18:28:53 -0400 (EDT)
In-Reply-To: <vpq8ur85neh.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	14 Apr 2014 10:24:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29109FD6-C424-11E3-A0BC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246271>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> So I suggest that in the interest of fixing rebase on FreeBSD in an  
>> expeditious fashion, patches 1/3 and 2/3 get picked up (see note  
>> below) now and that the follow-on patch below, after being enhanced to  
>> pass all tests, be submitted separately at some future point.
>
> Seems a good plan to me.

OK, should I take that an Ack on 1 & 2?
