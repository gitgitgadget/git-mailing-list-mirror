From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] commit: add tests of commit races
Date: Wed, 11 Feb 2015 10:10:26 -0800
Message-ID: <xmqqk2zouxnx.fsf@gitster.dls.corp.google.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-7-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kYmgeXt1k22h3fbDR04BTHOQRxryNVSJDOL2DC5yLLHpw@mail.gmail.com>
	<xmqq1tlxwpgi.fsf@gitster.dls.corp.google.com>
	<54DB6F9C.7060600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLbkB-0000wp-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 19:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbbBKSKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 13:10:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752429AbbBKSKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 13:10:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5AFB36BAC;
	Wed, 11 Feb 2015 13:10:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GRrIUK0eB+XYNhTzCkAs+CHUNBc=; b=Wlq2Me
	NEbvWesHGV3JoFj71Yq6z81m3YU1QuvYJXjnDt3Qs2ZHrVx1d5m420Dtk5BfLF9F
	gkpp0J4dAj93x0UXnw0xcQ7UczY8IQBAOfxzZQjVM9JUkcepxPtrMVwEVVEwG9e3
	G8ugd2LkOaR9SHO7nQk+1xyRDmDFfP9am1VM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VAUaj1ChqC1MP3LrxxT39ItVfjYiT+tv
	1MqzEGRPcCp9GxsqUEcAmVC7dsVIPQUbBiwP3Yungmc1CU6ipA7yCboN8DBKyh66
	FeXmzvyGAQFI8SeXpeMQ+VeLpNZPtpdikjvNcKmXJbE1t8Cyi+OkLTL18rmLTcug
	CgljPxK7f8k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC16036BAA;
	Wed, 11 Feb 2015 13:10:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6283836BA9;
	Wed, 11 Feb 2015 13:10:27 -0500 (EST)
In-Reply-To: <54DB6F9C.7060600@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 11 Feb 2015 16:05:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 41BD7520-B219-11E4-A356-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263684>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On the other hand, there's this [1] and this [2] from the FSF, which
> recommend a copyright blurb at the beginning of every source file.
> Though actually the recommendation is to include a GPL blurb too, not
> just a naked copyright line like I used. But I get the feeling that the
> FSF's recommendation is more for ideological than for legal reasons.

It is relatively recent (late 1980s) that US became part of Berne
Convention (1886).  Before that you had to write Copyright and All
Rights Reserved (or Todos Derechos Reserrvados) in Buenos Aires
days.

It is not surprising to see the more cautious practice from the
older days in recommendations by an old organization like FSF.

>>> Is there a reason you did not append the tests in 7509 ?
>> 
>> Hmph.
>
> I don't know what "Hmph" means in this context.

"Hmph, it might deserve more thought, but I do not have opinion
right now".
