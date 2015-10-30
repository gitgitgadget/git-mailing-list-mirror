From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with gdb
Date: Fri, 30 Oct 2015 11:32:49 -0700
Message-ID: <xmqqlhakky0e.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
	<20151026191724.GE7881@google.com>
	<alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
	<xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510301925360.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:33:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEUC-0002xK-4U
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760065AbbJ3SdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:33:07 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753661AbbJ3SdG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:33:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0035024B41;
	Fri, 30 Oct 2015 14:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5xXetZ3WgShGku1PbBwfa/V30MA=; b=eFWJZN
	Ow4dmlTSPCDeJ353DgO0HFPbo6ovB3tri0hI86HWCNlRluiEXRnseCplbAXLUJls
	Iclka/1SU5TSWkfi8d98sei0GmxtdbLUHq3vMCDa7EtGcAc3q3HzH57dYFWmq6DK
	KmhP2BVXs29+AReHFuhFUg4DBn2mjUSJMR5a8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mi4orweGR8zDIiQw6CyAXa9Gk5c0YepJ
	JIvgVHc31gdQE7fAEunoqaaaYFaqflSHCC7jkwyYxhJZ+F1b4IcYD81ONysPgl36
	Db9vc3ZuqTGM+e7EbRk6rQn7mARkQPZnoOSrXfCtVI9L/rFBUp4d3zD4HRu4GAMO
	bsZ6P81MMJg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA34724B40;
	Fri, 30 Oct 2015 14:33:04 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7473A24B3F;
	Fri, 30 Oct 2015 14:33:04 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1510301925360.31610@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Fri, 30 Oct 2015 19:27:34 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8652852-7F34-11E5-A98F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280514>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 27 Oct 2015, Junio C Hamano wrote:
>
>> It can be called GDB=1, perhaps?
>
> No, this is way too generic. As I only test that the environment
> variable's existence, even something like GDB=/usr/opt/gdb/bin/gdb would
> trigger it.
>
> I could be talked into GDB_GIT=1, though.

As I said in another message, I have no preference myself over the
name of this variable (or making it a shell function like Duy
mentioned, which incidentally may give us more visual pleasantness
by losing '=').

I'd just be happy as long as the feature becomes available, and I'd
leave the choice of consistent and convenient naming to others who
have stronger opinions ;-)
