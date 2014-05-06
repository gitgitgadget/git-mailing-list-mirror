From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: What's cooking in git.git (May 2014, #01; Tue, 6)
Date: Tue, 06 May 2014 18:17:30 -0500
Message-ID: <53696d8aa12d2_747f15213089@nysa.notmuch>
References: <xmqqlhuecz1b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 01:28:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whomb-0006H3-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 01:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbaEFX2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 19:28:18 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:41359 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaEFX2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 19:28:17 -0400
Received: by mail-ob0-f179.google.com with SMTP id gq1so237535obb.38
        for <git@vger.kernel.org>; Tue, 06 May 2014 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=GV7NuAvuFRh9FiiZ+YIg0LPSm75X29FyiP2ZvroirRA=;
        b=Zw81eAqmJeVlMCekkhBJDOnAx7DpBe3YLw3qRHYYrOrnUTmyUCoqdDK0at7PqEa2ik
         JuPYxUSEAAUgyYYJPUMoJwCw4w2iUJ7obQ9LkUNaoe2HDi3pAd+6SzgR98jIalKCNpWU
         ns7eRUa4nzqN/IYZrkAI4ry0uzChH1dXuhPmqokUrasQsFiL2Dxb/ujk2qinDSxKtTB6
         6Gd2kNk/e1050UDLWN8ggsJ5WAsxs5HAQJR3gvWJooc7iKVtEf/tgOV2bFf8XFV4FCfq
         S4MEPs6iB5vgJYvcaFAJCOcvcQoqauP9rFQDijrWnzR5PLxr9Z7mpnz4mqvhcDbZ1nCj
         supQ==
X-Received: by 10.182.213.168 with SMTP id nt8mr40365586obc.7.1399418897059;
        Tue, 06 May 2014 16:28:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm58199479oej.5.2014.05.06.16.28.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 16:28:15 -0700 (PDT)
In-Reply-To: <xmqqlhuecz1b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248269>

Junio C Hamano wrote:
> * fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
>  - remote-hg: trivial cleanups
>  - remote-hg: make sure we omit multiple heads
>  - git-remote-hg: use internal clone's hgrc
>  - t: remote-hg: split into setup test
>  - remote-hg: properly detect missing contexts
>  - remote-{hg,bzr}: store marks only on success
>  - remote-hg: update to 'public' phase when pushing
>  - remote-hg: fix parsing of custom committer
>   (merged to 'next' on 2014-04-22 at fed170a)
>  + remote-helpers: move tests out of contrib
>  + remote-helpers: move out of contrib
>  + remote-helpers: squelch python import exceptions
> 
>  Move remote-hg and remote-bzr out of contrib/.  There were some
>  suggestions on the follow-up fix patches still not in 'next', which
>  may result in a reroll.

I've no idea what suggestions you are talking about.

>  I tend to agree with John Keeping that remote helpers that are
>  actively maintained can and should aim to graduate from my tree and
>  given to the user directly.

Wait, I was under the impression the graduation was going to happen for
v2.0.

I don't understand what is the point of preparing the v2.0 for so long,
and then all of a sudden tag v2.0.0-rc0 and say "oops! if you wanted to
get something into v2.0 it's too late now", wait another 2-10 years for
important changes to get merged.

Such a wasted opportunity and such a disappointing release.

Therefore the release notes are still lying to the users:

 * "git push" via transport-helper interface (e.g. remote-hg) has
   been updated to allow ref deletion in a way similar to the natively
   supported transports.

That is not true.

These should obviously be part of the v2.0:

* fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
 + remote-helpers: move tests out of contrib
 + remote-helpers: move out of contrib
 + remote-helpers: squelch python import exceptions
 - remote-{hg,bzr}: store marks only on success

* fc/remote-helper-refmap (2014-04-21) 8 commits
  (merged to 'next' on 2014-04-22 at fb5a4c2)
 + transport-helper: remove unnecessary strbuf resets
 + transport-helper: add support to delete branches
 + fast-export: add support to delete refs
 + fast-import: add support to delete refs
 + transport-helper: add support to push symbolic refs
 + transport-helper: add support for old:new refspec
 + fast-export: add new --refspec option
 + fast-export: improve argument parsing

* fc/merge-default-to-upstream (2014-04-22) 1 commit
 + merge: enable defaulttoupstream by default

* fc/mergetool-prompt (2014-04-24) 2 commits
 + mergetool: document the default for --[no-]prompt
 + mergetool: run prompt only if guessed tool

Plus this one which has been completely ignored:

   completion: move out of contrib


Since you are not going to do so, I do not feel compelled to fix the
synchronization crash regression that is present in v2.0.0-rc2 and I
already warned you about.

-- 
Felipe Contreras
