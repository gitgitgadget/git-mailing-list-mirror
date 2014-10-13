From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: add an option for writing to a temporary directory
Date: Mon, 13 Oct 2014 12:24:41 -0700
Message-ID: <xmqqk3433h8m.fsf@gitster.dls.corp.google.com>
References: <1413047085-12398-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 21:24:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdlEj-0005to-Ll
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 21:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbaJMTYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 15:24:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753340AbaJMTYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 15:24:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF1C915EA0;
	Mon, 13 Oct 2014 15:24:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h25pQVVB1/vBSuW/fvwqkzpJgdg=; b=hOXUdo
	xfhGzGrPN0CyK73jfBih8zVc2vFBQY3/DO7Vlx71zx9P8TLN1gBxdSq+ZYCCvVqz
	28MDlamaMruDyBWR/66pMprdkD0Br4/L5kaNk9qblSSO2PVR+9+b4Bq0F8j7+lB0
	Hni/TClxePQsF0pz8mNzu+0xYQa3TiOEQxZzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCeOQX/F3qKBQLcDXnI+j2EhYY0R2miy
	6uLbnCSOgpI4Z1Pem5JYgCfSw5wv5MwKQGnL2vxmTz5ezCKod4eH6dNIJ/jjZYRM
	M1PaR2wMUnmazru9DTs+wG0scldRvfSd9t8oscyHj5hkdPMzZp+Cuh/lStA2+M4q
	bEI3DQkn46o=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B552915E9F;
	Mon, 13 Oct 2014 15:24:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 396CA15E9E;
	Mon, 13 Oct 2014 15:24:43 -0400 (EDT)
In-Reply-To: <1413047085-12398-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sat, 11 Oct 2014 10:04:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 95996664-530E-11E4-9F65-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Teach mergetool to write files in a temporary directory when
> 'mergetool.writeToTemp' is true.
>
> This is helpful for tools such as Eclipse which cannot cope with
> multiple copies of the same file in the worktree.

With this can we drop the "change the temporary file name" patch by
Robin Rosenberg?

http://thread.gmane.org/gmane.comp.version-control.git/255457/focus=255599

Message-Id: <1408607240-11369-1-git-send-email-robin.rosenberg@dewire.com>
