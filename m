From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Performance Issues with Git Rebase
Date: Mon, 13 Oct 2014 10:25:37 -0700
Message-ID: <xmqqlhoj51bi.fsf@gitster.dls.corp.google.com>
References: <B82B660D4887C042850326C2BC65FE035D56CA14@G4W3227.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Crabtree\, Andrew" <andrew.crabtree@hp.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:25:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdjNQ-0003ri-NN
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 19:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbaJMRZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 13:25:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752634AbaJMRZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 13:25:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8C9113889;
	Mon, 13 Oct 2014 13:25:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PcKE+9J2EVC0fTifzGG9gVApfts=; b=b/Gxz6
	DHYocuCEfolnt2pEgIXIYL0vhEbWJ4uzyDm4kfvAkcWeaCj+z0W934OXBeNd6fzk
	sBC4K935EukdE+2P7aReyXyOQ+Ee35/6j3PtDITYo5an2/SXfWw3yFvdSHpnOV7j
	HhDXxSHDVWQuCcJAoxzYKsO5hcNBl/QMViKC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bhM3zOxi6bgbCYoPd/pKBMO1n8nVVgbr
	M9XYbDiLTCo7Ii71gvFVGVyrv62FDx8LXGSSVQVlefxiqm2lgdYk3iN7kTNTqNNx
	5+uMD7XNupQbSDbWQ7Yz/lFjLpDYFNJ0rZ0QPLXNi3lLyIxut46o9B4znX7odcfp
	Cwd4CpNvUTQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFBDB13888;
	Mon, 13 Oct 2014 13:25:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42FAA13886;
	Mon, 13 Oct 2014 13:25:38 -0400 (EDT)
In-Reply-To: <B82B660D4887C042850326C2BC65FE035D56CA14@G4W3227.americas.hpqcorp.net>
	(Andrew Crabtree's message of "Sun, 12 Oct 2014 01:29:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F2DE875C-52FD-11E4-A41D-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Crabtree, Andrew" <andrew.crabtree@hp.com> writes:

> I'm getting the same output with both the triple and double dot for my
> specific case, but I have no idea if that change makes sense for all
> cases or not.  Any guidance?

The difference only matters if any of your 4 patches have been sent
to your upstream and accepted and appear among the 4665 changes they
have.

The --cherry-pick option is about cross checking the combinations of
4 x 4665 and filter out matching ones (if any).
