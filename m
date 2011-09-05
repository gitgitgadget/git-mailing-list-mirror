From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push output goes into stderr
Date: Sun, 04 Sep 2011 17:57:53 -0700
Message-ID: <7v8vq3ztym.fsf@alter.siamese.dyndns.org>
References: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 02:58:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0NW7-00017z-9d
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 02:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab1IEA56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 20:57:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829Ab1IEA54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 20:57:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76D505B07;
	Sun,  4 Sep 2011 20:57:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mb6zJrlEp2vLwlsJCxrxKYRAPK4=; b=QhZ6E2
	QURhDA3SpI5j6E2v27CUS4ZLrQ1bY2ec4nd2GEl8HuH4Op5bs1bMF9S+e3H2CpN3
	D1/fNGfgNYOuD8ZWNlpcHKGgEfph225M9+9hWydB5HQ/hFKDSZWM/hhVOmyVqU2h
	5gJ4TyMwbDGKurYs/s8tN7ql7JXdxSo2dMKVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BuhoRASAzcXMQ8FNekQOvr5M9jyCfEI6
	W0GddQzZ1tRkgF3/2SIkKOT5aVvLSfejgo6L7DKdaL56SGSolUA9BSTuiSMkI1S8
	cXDqOj/eFc+3m/1HVRHaivFLPozhfmMalfB1N5rsvGJet8UrXvsdgGRx4/TxCaZb
	KiOo64veDkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E48B5B06;
	Sun,  4 Sep 2011 20:57:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1F815B05; Sun,  4 Sep 2011
 20:57:54 -0400 (EDT)
In-Reply-To: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com> (Lynn
 Lin's message of "Sun, 4 Sep 2011 17:26:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16C2F248-D75A-11E0-BD06-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180707>

Lynn Lin <lynn.xin.lin@gmail.com> writes:

> When I create a local branch and then push it to remote. I find that
> the output without error goes into stderr, is this expected?

Progress output are sent to the stderr stream.

In general, any program or script is buggy if it assumes that some output
that are emitted to the standard error output from programs it invokes
indicates an error (IIRC, that includes tcl/tk).
