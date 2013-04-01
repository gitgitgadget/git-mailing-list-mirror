From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] remote-helpers: trivial test fixes
Date: Mon, 1 Apr 2013 15:56:36 -0600
Message-ID: <CAMP44s2d-gZHsgibq2E8vZ25vciJRBh5Z0hYmx5pNa+CW5gvyg@mail.gmail.com>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
	<CALWbr2wAJGemYziPsOkArJveK0F+4Pv80gdR1SGUxchb0ci-sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 23:57:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmix-0007tm-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758731Ab3DAV4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:56:39 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59739 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758717Ab3DAV4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:56:38 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so2378911lbd.38
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=KUe2AhCNkeiAzKdE9H0+mftrrFqt3Dr9ftvSPMboO+E=;
        b=iJefSTNwbeTUcEbYeXxMp8l18s/DnUb9xJA0Zi37VXxKyGT0s4pW09qFp/wYbB3hLp
         FglZd7GzyLqTdQ/Kim1IJC9rvw1U/UHb82G2LONHt36R3ytC3Dk9s6hnNaqsOx/+1KHL
         tU1l2RJYnADsnH3x/Y8syE80HGMlprdGotAbKPWByRkE8F8snt3y4fCbEb/900kN5NmS
         k74ex5/z1ERHBilfP04VZNFDWwAvboB048eH4krHzcnrU4lkOEO0Q0AqanimfTZcuhed
         G+T/f+LeNnOsWCgyfMtvY7tvS+kRF6ZKX/ihQrLQY0Tk6Np2MhBY0jpnFM6+B16Ax3Fq
         Sm2A==
X-Received: by 10.112.8.9 with SMTP id n9mr6505693lba.71.1364853396930; Mon,
 01 Apr 2013 14:56:36 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 14:56:36 -0700 (PDT)
In-Reply-To: <CALWbr2wAJGemYziPsOkArJveK0F+4Pv80gdR1SGUxchb0ci-sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219719>

Hi,

On Mon, Apr 1, 2013 at 3:48 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> I'm having an error in "contrib/remote-helpers/test-hg.sh" and it
> reproduces on every version I tested since you implemented it. Is it
> something in my environment that would make it wrong ?
>
> Cheers,
> Antoine
>
> ---
> expecting success:
>   test_when_finished "rm -rf gitrepo*" &&
>
>   (
>   cd hgrepo &&
>   hg update -r 0
>   ) &&
>
>   git clone "hg::$PWD/hgrepo" gitrepo &&
>   check gitrepo zero master
>
> 1 files updated, 0 files merged, 0 files removed, 0 files unresolved
> Cloning into 'gitrepo'...
> --- expected 2013-04-01 21:46:32.086796549 +0000
> +++ actual 2013-04-01 21:46:32.086796549 +0000
> @@ -1,2 +1,2 @@
> -zero
> -refs/heads/master
> +feature-a
> +refs/heads/feature-a
> not ok 4 - cloning with detached head

You probably have a very old version of mercurial that has a bug, this
should workaround the issue:
http://thread.gmane.org/gmane.comp.version-control.git/209491

But it shouldn't be a big deal, it's just the default branch (HEAD).

--
Felipe Contreras
