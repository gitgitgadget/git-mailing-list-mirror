From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git bisect old/new
Date: Wed, 13 Jun 2012 10:30:00 -0700
Message-ID: <7vzk87glwn.fsf@alter.siamese.dyndns.org>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <CAP8UFD1mgKNQRZpuqYgyL__DGpoZ3cOGJC0amoqWT+1Bn_0iTg@mail.gmail.com>
 <7v1ull5bld.fsf@alter.siamese.dyndns.org>
 <CABURp0rWu0GtmSrLV+qEQJVYOt8p=B4bQtG3fzKh2f0fTGHwOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:30:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SerOW-0008Nd-98
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 19:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2FMRaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 13:30:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab2FMRaF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 13:30:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BAC082FE;
	Wed, 13 Jun 2012 13:30:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T8AcTSGy//2y1hC/zVFCBHYdTJA=; b=MXkRTE
	Dwm7reEfP/2Jry+tlGmgdpNcHKgJH/wh0lZkOBaarZVnYSIrAJgzgb7+3Oc3/r/a
	tLVPC98jtDDGDDoFAw1PAnHDP0PFPv6WLhxdKFFUzMGpgGrD02MlTG/H4eS2rXIp
	v/4zZu96TzhR22yufIaMXGImFJEBrAIw3uQsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qKz3MTDcT4QxN2xhYZh6tku7Wjqfacq4
	/1xLYvOrdmhtgGbMsfJ4xZvnfCPm8KZJrbQVlYbk6P13gJq9kkX+6f+k3ikUXCuY
	JDmPOPOHl5vcJtqHTg9jOewB/MQzwyuRMOawZA8jNXO2ZGHwpG/LIGYD58aYWxIR
	s+ZQ7UJKVck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C4BB82FC;
	Wed, 13 Jun 2012 13:30:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4504082FA; Wed, 13 Jun 2012
 13:30:02 -0400 (EDT)
In-Reply-To: <CABURp0rWu0GtmSrLV+qEQJVYOt8p=B4bQtG3fzKh2f0fTGHwOQ@mail.gmail.com> (Phil
 Hord's message of "Tue, 12 Jun 2012 15:41:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 684B9C26-B57D-11E1-96B1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199909>

Phil Hord <phil.hord@gmail.com> writes:

> On Tue, Jun 12, 2012 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Why not? It is not like we will be adding any more synonym pair
>> beyond good/bad, so...
>
> Previously we discussed using yes/no, among others.
> http://permalink.gmane.org/gmane.comp.version-control.git/182496

Yes, but didn't we dismiss yes/no and others as no better than
bad/good after discussing?
