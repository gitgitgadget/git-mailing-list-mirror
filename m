From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: trivial cleanup
Date: Tue, 07 May 2013 22:43:53 -0700
Message-ID: <7vmws6gh5y.fsf@alter.siamese.dyndns.org>
References: <1367970315-5053-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 07:44:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZxAk-0000Ns-CO
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 07:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab3EHFn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 01:43:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab3EHFnz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 01:43:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B5E814587;
	Wed,  8 May 2013 05:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HC7YYS2lKOV3sE2deTe3sJwgN0c=; b=w50SoY
	Ty0C3e4wq59YvApuWRMkyGq6REuRHC2uEI+heaxWxt4wovn4a1FeGxJ+Iuu/PCVn
	Ly36r5wEMYIXC2ysOOykf8JQMSIBC7v1jB4XGW76GPli6aX0VuZaoSPwddOB5bOP
	W7OsBQ21Ojk4tk+ziVaR9mFngZ8buBBII1E8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ochGWRq72+9xXbghoEYedRemZyB5E9S3
	SYcNfomJhGZe7qK1CWuZHjCjYITvbif6BZhVygzyOaqInMYOjLbMDmCQVOk14+gD
	kgn+FFHHSynaiVu6ygJQqoHZZ/zfAOilJXaI4S9IAzQmkTAyejMUO8TQ8/7Mpjl2
	JLM0kFvLtnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73EE414586;
	Wed,  8 May 2013 05:43:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6E5014584;
	Wed,  8 May 2013 05:43:54 +0000 (UTC)
In-Reply-To: <1367970315-5053-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 7 May 2013 18:45:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 453F0664-B7A2-11E2-8E3F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223639>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The comment was copied from hg-fast-export, not used anymore.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-bzr | 1 -
>  contrib/remote-helpers/git-remote-hg  | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index c19ed0e..3604c7d 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -323,7 +323,6 @@ def export_branch(branch, name):
>          count += 1
>          if (count % 100 == 0):
>              print "progress revision %s (%d/%d)" % (revid, count, len(revs))
> -            print "#############################################################"
>  
>      repo.unlock()

THe above no longer is relevant, I think, after a39769995050
(remote-bzr: improve progress reporting, 2013-04-30).  I'll apply
only the hunk for remote-hg.

> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 06920f2..96ad30d 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -453,7 +453,6 @@ def export_ref(repo, name, kind, head):
>          count += 1
>          if (count % 100 == 0):
>              print "progress revision %d '%s' (%d/%d)" % (rev, name, count, len(revs))
> -            print "#############################################################"
>  
>      # make sure the ref is updated
>      print "reset %s/%s" % (prefix, ename)
