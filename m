From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Mon, 09 Dec 2013 13:11:32 -0800
Message-ID: <xmqqr49lwwzf.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
	<CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
	<5281DB46.2010004@bbn.com> <5282977b2ecd_3b98795e785e@nysa.notmuch>
	<xmqq38n1guo8.fsf@gitster.dls.corp.google.com>
	<xmqqob5pfa6j.fsf@gitster.dls.corp.google.com>
	<52a2f1c59de6f_29836d5e9830@nysa.notmuch>
	<xmqqbo0pyc2u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq87L-0001rb-0D
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab3LIVLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:11:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753993Ab3LIVLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:11:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19EDD5959E;
	Mon,  9 Dec 2013 16:11:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fi7usBJOK0GJS7JF0yvgzcHYMMo=; b=vim65d
	2H65FV0Nu8VucXHZj0Cre6kNGsnL5zA2E+VNRjaIuENPBzhELtYC2K4W5h7pc0OR
	I2pwHrhoiC6HCVO1v2lk9YlVnTBdogMU5iCA7+eiZj7rA/1ykiv7C+PU/51T5UWZ
	KcLW7BZrokxK2Md84Z8H6HbNJTuRSgzwbfRvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pun97/G64tyZ0vbisKqSymkPqX2mrTs3
	WbPlq6Ppnm1lze7wRBIRUwnB8HzzVqoACZLm65XNhSyNL4RuNOCnwMJznEJrqpjz
	WGHUpgo/jTex+eQSC0ZmdKW7IgmMiaCkxl3Rl5+o8gh6q2Jb/kztRjGaEzxmwjjk
	uufazivwl6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2FA25959B;
	Mon,  9 Dec 2013 16:11:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F412D59596;
	Mon,  9 Dec 2013 16:11:36 -0500 (EST)
In-Reply-To: <xmqqbo0pyc2u.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 Dec 2013 13:00:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7D451DDC-6116-11E3-B36D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239102>

Junio C Hamano <gitster@pobox.com> writes:

> A refspec consists of one or more elements, each of which has
> right and left hand side separated by a colon, i.e. RHS:LHS, and
>
>  1) is determined by the RHS
>  2-a) is determined by the LHS
>  2-b) is determined by the correspondence between RHS-to-LHS.

Heh, I got my right and left the other way around ;-)
