From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --simplify-merges returns too many references
Date: Tue, 15 Jan 2013 15:48:58 -0800
Message-ID: <7vk3re0zyt.fsf@alter.siamese.dyndns.org>
References: <CABURp0q0nhka+ivrs3+m+3C1N+FfTq2zJ=1rWp34tfGNQ3b30g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:49:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvGG3-0006Mc-Op
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758858Ab3AOXtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 18:49:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758656Ab3AOXtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:49:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40C3EA010;
	Tue, 15 Jan 2013 18:49:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9vzACl3ceAazGdZBG0EZ2t1tWHo=; b=pWLz5v
	Gt0h0ZG8Cd1EatyfcH9el6Bytjm3ND0NPaOSPZbqA3LPDW2A9FE9hM/LFxl4Bw7x
	4Z7Qg2hpM7NoVgS60NSQwp4U7pbOrUm4P0bOb3luHwCcAY3Lw0Z89wpkDrjCpXVL
	avyAXDc99xM/fIVatyKRAIdVmwmuC/2TlGKXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GMS8p2qyjnlrURnwvfxEvGeKCH8rs3cq
	vx3QAhObEUrbESCIXCCUB9ud3DHrQ9XDQfa37QLws3EWxNfWaqjVV4xc3EJZpk9d
	mJF011VCw2gMm4dC/drUYt5cx1ItZIHTNqmojoBR/2CWyGDagZG0bl4ZJVVGH34u
	T5V2YOxwDGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 351E4A00E;
	Tue, 15 Jan 2013 18:49:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2193A00B; Tue, 15 Jan 2013
 18:49:00 -0500 (EST)
In-Reply-To: <CABURp0q0nhka+ivrs3+m+3C1N+FfTq2zJ=1rWp34tfGNQ3b30g@mail.gmail.com> (Phil
 Hord's message of "Tue, 15 Jan 2013 18:12:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22A3732E-5F6E-11E2-8DB9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213692>

Phil Hord <phil.hord@gmail.com> writes:

> But with --simplify-merges, I see _more_ commits.
>
> $ git log  --simplify-merges --oneline -- builtin/stripspace.c
> 634392b Add 'contrib/subtree/' from commit ...
	> 497215d Update documentation for stripspace
	> c2857fb stripspace: fix outdated comment
	> 81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory
> 610f043 Import branch 'git-p4' of git://repo.or.cz/fast-export
> b4d2b04 Merge git-gui
> 0a8f4f0 Merge git://git.kernel.org/pub/scm/git/gitweb
> 98e031f Merge git-tools repository under "tools" subdirectory
> 5569bf9 Do a cross-project merge of Paul Mackerras' gitk visualizer

After indenting away what should be shown, I notice all these extra
are merges without any common ancestors.

Just an observation; I didn't think things through.
