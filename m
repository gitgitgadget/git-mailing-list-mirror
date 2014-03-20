From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] ls_colors.c: enable coloring on u+x files
Date: Thu, 20 Mar 2014 10:41:53 -0700
Message-ID: <xmqq7g7ozs0u.fsf@gitster.dls.corp.google.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395310551-23201-4-git-send-email-pclouds@gmail.com>
	<vpqpplhks7n.fsf@anie.imag.fr>
	<CACsJy8DP3buUjT95LwG+Kd70KL67xqEubrHfu9Mqx1RNa-ER2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:42:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgyf-0004p2-I6
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 18:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758756AbaCTRl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 13:41:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbaCTRl4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 13:41:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B740E741AD;
	Thu, 20 Mar 2014 13:41:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FQ1DBWRRvl1w
	YxbS51pwiM0/ksE=; b=bRGaZYeVxcmhRSe1W35zdL/VmUtgf6mDuXJsDikHOuh4
	h6Pek0wHs7A6p0dVktMlKUDwHMuF6ojtg/f1dbqN8M48eFii6ebjkmWaeeJZSIGT
	bSnJVMVuytLi3nMmN9V8/5VDR+bVg2uKxROvZ4KgJC5tGsDHbbIr2yACXy3h+BU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GB+VaZ
	bZpzR1hwiqB+V5RnaasTPloOI+6UQrekGunjYk9tNwzDQTrk9+mud+/zHIT+zIk7
	KrxSd6f3JanC3Hk5BARxwx2ijvEQhOLMfLjPxUyz21+B58iS7ztSV4VJNNVcSz0a
	vdmqwncJVX+MZz5cuO2hoyD9PS8Wv/XkVyGK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B75741AC;
	Thu, 20 Mar 2014 13:41:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E510E741AA;
	Thu, 20 Mar 2014 13:41:54 -0400 (EDT)
In-Reply-To: <CACsJy8DP3buUjT95LwG+Kd70KL67xqEubrHfu9Mqx1RNa-ER2Q@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 20 Mar 2014 19:14:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED7F4106-B056-11E3-9B0C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244564>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 20, 2014 at 6:46 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> git-compat-util.h does not seem to carry S_IXUGO. Anyway as far as =
Git
>>> is concerned, we only care one executable bit. Hard code it.
>>
>> Why not use S_IXUSR instead of a hardcoded value? (already used in
>> path.c, so shouldn't be a problem wrt portability)
>
> Hmm..maybe cache.h does something to that macro. Will drop this patch
> and include cache.h.

Why even include cache.h for S_IXUSR?

In the context of the patch I see S_ISGID mentioned and other S_*
st_mode things are already in use in this function before this step,
and presumably you are using them without problems, no?
