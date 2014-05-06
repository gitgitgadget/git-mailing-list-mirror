From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Tue, 06 May 2014 17:19:34 -0500
Message-ID: <53695ff6b1535_747f1521308c5@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5363edc954f8e_70ef0f30c24@nysa.notmuch>
 <20140502214817.GA10801@sigill.intra.peff.net>
 <xmqqy4yed0jq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 00:30:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhnsX-0003I2-D5
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 00:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbaEFWaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 18:30:21 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39495 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbaEFWaV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 18:30:21 -0400
Received: by mail-ob0-f177.google.com with SMTP id gq1so176408obb.22
        for <git@vger.kernel.org>; Tue, 06 May 2014 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=oERfoMRDlgIFPt9rnJ1CX3dL3BDp5VT05ff8DO53tLg=;
        b=FFQkXtc++/Zz0yMRCzY+tF7HEf8JB7C3tErZwpXGvzv+zCXCqKpTL05HBxNVAusT3D
         T/yshBIExnoMCB5x8DLdSJ+InANIYo2IC0yOkN2xcLNJf95bJt87ZIwwu3aBOtskNeve
         nEwiyX6YtZsfmWRw3fEMr/9oc6Eoh1PJYK0RoVLDD0hL/Ki+OSfFRgRY4XCOpvNpduuW
         vx4S1KFv7OJvr6sBa1RTe1iC0MuMB6bVnDcg9o0SdZ88LaQQ/KEI965gkWE+fTNV90lI
         Q/0cSKYFOr+7bojp1aAYOmO7Dl1PIYx4CcRZ2WEKYpiOp4QT0iWlLR59yfkcNuXv7FYO
         nsXw==
X-Received: by 10.60.15.38 with SMTP id u6mr41868786oec.26.1399415420528;
        Tue, 06 May 2014 15:30:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p1sm30063406obn.20.2014.05.06.15.30.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 15:30:19 -0700 (PDT)
In-Reply-To: <xmqqy4yed0jq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248262>

Junio C Hamano wrote:
>    But recording the merge to have parents <Z C> does not give us
>    "the first-parent is the trunk" worldview, in the presense of B.
>    We would prefer to end up with a history more like this:
> 
>     -----A       ----O
>           \           \
>            X---Y---Z---B'--C'
> 
>    so that your work, your contribution with two commits of yours,
>    was to merge the work done on a side branch and then made one
>    commit directly on top of it.

Yes, _ideally_, but as it has been explained multiple times most Git
beginners have no idea what is a rebase.

We might evenaully do this by default, but first we should start
rejecting the update by default and recommending `git update --merge` as
it has been discussed quite a lot should be the behavior of `git pull`.

>    Hence, I think the ideal behaviour of the new command is to
>    replay the first-parent history on top of the updated tip of your
>    upstream (which by the way is different from how "rebase
>    --preserve-merges" works; it is more like how J6t wanted to make
>    "rebase --preserve-merges" work, IIRC).

What is the difference with 'rebase -p'?

-- 
Felipe Contreras
