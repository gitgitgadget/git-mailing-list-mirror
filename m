From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git's behaviour during a 'both added' merge conflict
Date: Thu, 22 Mar 2012 11:49:38 -0700
Message-ID: <7vaa38xygt.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqrqz+HZGJHWp6YEWKJeXO2jYDw-qYfAdtHhDvYVmeTD1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:49:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAn54-0005Fq-K2
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759035Ab2CVStl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:49:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759033Ab2CVStk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:49:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3F7762BF;
	Thu, 22 Mar 2012 14:49:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WChnMmkN3Rc9S+G/GXxHmMoOMU0=; b=VmZEFy
	yVU1km+mLLjsR6rdBTgpKyS7cU147Kj8hqCZdw1ixf0YMRBbOjtUlrboqao+WQ6R
	DPVftpdOK0mU72a4StSe9ssMSUf+qEMkh8RHPtH3UKCku9YZaB5Io5KBxlCD1MFl
	G6Tgy9Z1wU/p9fu7M8SPKIWk/s+m6yZtnppSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ls/sjIcEAmDSqm0boJueGu8MS+v6bqTt
	Loy1EyqORt0QNCNmuruUU7XOaHtYHzl+TAH0wl+rwZuAMyVfg7BkPG52Dv/4Ru24
	bzQ1hH/BWb9LtfOqM/op8U5SBtHJRfneWK5iv/9PvgO44dR7adwPrpOpSt13eWLr
	xfUEQEbrL6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB6362BE;
	Thu, 22 Mar 2012 14:49:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61E1262BB; Thu, 22 Mar 2012
 14:49:39 -0400 (EDT)
In-Reply-To: <CAFsnPqrqz+HZGJHWp6YEWKJeXO2jYDw-qYfAdtHhDvYVmeTD1w@mail.gmail.com> (Jeremy
 Morton's message of "Thu, 22 Mar 2012 14:23:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C761729A-744F-11E1-9E67-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193681>

Jeremy Morton <jeremy@configit.com> writes:

> I've noticed that when you're merging and there is a 'both added'
> merge conflict, git creates the .LOCAL and .REMOTE files for the
> merge, but not the .BASE file.

Strictly speaking, git doesn't, but I think mergetool may.

You may find this thread interesting:

  http://thread.gmane.org/gmane.comp.version-control.git/188776/focus=188867

which resulted in ec245ba (mergetool: Provide an empty file when needed,
2012-01-19); that change is in v1.7.9.1 and upwards IIRC.
