From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Tue, 23 Jul 2013 10:09:30 -0700
Message-ID: <7vppu98aph.fsf@alter.siamese.dyndns.org>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
	<CALkWK0kmcQ1ws143H7O6q9kRmdBxMDVYBWVBKp+0Hy0acpn7VA@mail.gmail.com>
	<20130723090659.GB9639@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 23 19:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1g5m-0004JJ-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 19:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933436Ab3GWRJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 13:09:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933409Ab3GWRJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 13:09:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE75B301ED;
	Tue, 23 Jul 2013 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RALk4pJphKQOPwxzY8c9a3o3j7A=; b=LEKOje
	shABBML47WENo1o1uLF3ahyBYVid3Hua+cBWMKUOaXaFrSZuM/JL4aqOTJtRclpN
	ywoyZdVKdorL/tEwMXEa5/S2VDmncK3S+FbgYfgqBoMiwdRRdanAzrig0MqAieVM
	PpT+ggXnh1sb2qwGNoJ79CE1KzHbTyeTZfJDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfGyRAt0BQqbcBXX+UsXwbBLRjz4QYea
	Vv/7ctejnvw4u3cAbkYGKMhq9upf47YYSiZEkks6/d9NKiv97JOceQfAHAQGFAbK
	/s/F9ILM8ZcAzZEC9mEpcTxvwzt2rwZ3ALxVBwzCDkbyIcVxksYJJKYOPuJsNuYz
	k6GVmiQI7MY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4857D301EC;
	Tue, 23 Jul 2013 17:09:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45202301E8;
	Tue, 23 Jul 2013 17:09:33 +0000 (UTC)
In-Reply-To: <20130723090659.GB9639@suse.cz> (Miklos Vajna's message of "Tue,
	23 Jul 2013 11:07:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A50AE1D6-F3BA-11E2-90D3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231045>

Miklos Vajna <vmiklos@suse.cz> writes:

>> How is --ff-only overwriting merge.ff=only here?  Was it a typo?
>
> Yes, it's a typo in the test name. Thanks for spotting that!

Thanks, will do this:

Subject: [PATCH] t7600: fix typo in test title

Spotted by Ram, confirmed by Miklos.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7600-merge.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 3ff5fb8..10aa028 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -502,7 +502,7 @@ test_expect_success 'option --ff-only overwrites --no-ff' '
 	test_must_fail git merge --no-ff --ff-only c2
 '
 
-test_expect_success 'option --ff-only overwrites merge.ff=only config' '
+test_expect_success 'option --no-ff overrides merge.ff=only config' '
 	git reset --hard c0 &&
 	test_config merge.ff only &&
 	git merge --no-ff c1
-- 
1.8.3.4-985-g5661af8
