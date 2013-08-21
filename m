From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Wed, 21 Aug 2013 23:36:49 +0200
Message-ID: <vpqa9ka7mku.fsf@anie.imag.fr>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 23:37:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCG5N-0004bV-MT
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 23:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab3HUVg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 17:36:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49009 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab3HUVg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 17:36:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7LLalW2025408
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Aug 2013 23:36:47 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VCG5B-000238-JR; Wed, 21 Aug 2013 23:36:49 +0200
In-Reply-To: <CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 21 Aug 2013 14:48:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Aug 2013 23:36:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7LLalW2025408
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377725810.10033@Kvpt9L2Cw+LvnMBj1sfHKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232737>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Aug 13, 2013 at 8:31 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>
>> Felipe: Is this the right fix for git-remote-mediawiki? Any better idea?
>
> Why not keep track of the revisions yourself? You can have file where
> you store which was the last revision that was fetched.

I don't really understand the point of the "private namespace" anymore I
guess. Why do we have both refs/remotes/$remote and
refs/$foreign_vcs/$remote, if they are always kept in sync?

Keeping the last imported revision in a separate file would be possible,
but then we'd have information about the remote in one file plus two
refs, and I don't understand why we need to split the information in so
many places. A ref seemed the right tool to store a revision.

(These are genuine questions, you have far more experience than me with
remote-helpers)

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
