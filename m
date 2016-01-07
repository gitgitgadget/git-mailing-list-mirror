From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: how to fetch entire heirarchy of refs from a remote?
Date: Thu, 7 Jan 2016 15:39:25 -0800
Message-ID: <CA+P7+xptfL2YfNR9g7bmnmfYPoJ0HW4gLEfvRbxmNZ1B=pU1RQ@mail.gmail.com>
References: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 00:39:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHK9m-0006qp-PS
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 00:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbcAGXjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 18:39:46 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38436 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbcAGXjp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 18:39:45 -0500
Received: by mail-ig0-f180.google.com with SMTP id mw1so64277961igb.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 15:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=0QhwT4ohctRcOFYf2VzpT/AkqLWm5SmF6aKxuc/4pAQ=;
        b=F0Axp3nNbEvwsyHZkctitmW0l2G585n5mlqBsih0Ju6PTk+SKhCySM0aQeM0D5+bd6
         8Men9wgL6eEPdfKGL6spu+ztsV8j+eF9U/tAd3RM0vt6Kd67Llm8s2wJG7/mwaJYiBfM
         bVg61lOaefK5cucE66H4lzndT6a9eM+OacUVT1t2IMp63q6ElM2Sgb6LWu/lxHe08VQS
         uC6PubfKJLfnE7bvnI/hYcAOyDSn0D3VyZNuym1glv5U6W3QVL1oVNVUOHhWbUYC/YFC
         gUhIPLFL05dy4ow0ExVIyPQsNL4ECZQiRlwCAY7L+ozxpZG7iNk35Sjocb7/F8sIHO+Z
         S47w==
X-Received: by 10.50.28.19 with SMTP id x19mr18998894igg.92.1452209984595;
 Thu, 07 Jan 2016 15:39:44 -0800 (PST)
Received: by 10.107.63.130 with HTTP; Thu, 7 Jan 2016 15:39:25 -0800 (PST)
In-Reply-To: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283519>

On Thu, Jan 7, 2016 at 3:06 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hi,
>
> Say I have a repository which has a series of refs in a heirarchy such
> as a gerrit repository with changes specified something like:
>
> refs/changes/96/55596/3
> refs/changes/96/55596/4
> refs/changes/96/57496/1
> refs/changes/96/57496/2
> refs/changes/96/69796/1
> refs/changes/96/69796/2
> refs/changes/96/71696/1
> refs/changes/96/71696/2
> refs/changes/97/40197/1
> refs/changes/97/40197/2
> refs/changes/97/40197/3
> refs/changes/97/40197/4
> ...
> refs/changes/97/71697/2
> refs/changes/97/71697/3
> refs/changes/98/47298/1
> refs/changes/98/47298/2
> refs/changes/98/47298/3
> refs/changes/98/57298/1
> refs/changes/98/57298/2
> refs/changes/98/73598/1
> refs/changes/99/44099/1
> refs/changes/99/69299/1
>
>
> Is it possible to specify a refspec such that all of these will be
> fetched? I tried doing
>
> +refs/changes/*:refs/changes/*
>
> but this doesn't work since the * can only be one portion of a refspec
>
> The problem is that I would like to be able to pull all of these
> changes in a git mirror so that I can reduce network traffic I use to
> the gerrit server, by updating my local copy once and using the local
> copy on the other tasks I need. This is necessary since the gerrit
> server is (a) far away and (b) closes my connection when I have too
> many requests.
>
> But, git clone --mirror and git fetch have failed to pull every ref,
> and only end up with heads and tags.
>
> Regards,
> Jake

So, sorry for the list spam. Things work correctly, it just is using
packed-refs, which is a feature I wasn't aware of :) Git already did
what I expected but in a way I did not, so I was very confused.

Regards,
Jake
