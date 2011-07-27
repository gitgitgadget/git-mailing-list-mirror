From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/18] revert: Save command-line options for continuing
 operation
Date: Wed, 27 Jul 2011 07:05:15 +0200
Message-ID: <20110727050515.GH18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 07:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlwJH-000414-DI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 07:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab1G0FF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 01:05:27 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:56025 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab1G0FFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 01:05:25 -0400
Received: by eye22 with SMTP id 22so1585151eye.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 22:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kfoMa3lZ4ebNxMoC0Mcv/BR/mgK3fMoHAbFHKkMGxE8=;
        b=BscH/r53o8Awas4O43gYay4zgy5DMMkyz71PV3QIxmp4EL23JtfSnJP4Phe34dtSn2
         RxsKj+lAnwsGdlllLs9gHI/385ZBtLkRGiLYWBE68zQOn2TVs0o8RxwLi9C0f7swVHZ/
         YL1Up2rGl1hBuJOKjtbFKndbM1cIYJKYINSL0=
Received: by 10.213.9.194 with SMTP id m2mr1295776ebm.25.1311743124581;
        Tue, 26 Jul 2011 22:05:24 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id y9sm827040eeh.34.2011.07.26.22.05.22
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 22:05:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-13-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177930>

Ramkumar Ramachandra wrote:

> In the same spirit as ".git/sequencer/head" and ".git/sequencer/todo",
> introduce ".git/sequencer/opts" to persist the replay_opts structure
> for continuing after a conflict resolution.  Use the gitconfig format
> for this file so that it looks like:
>
> [core]
> 	signoff = true
> 	record-origin = true
> 	mainline = 1
> 	strategy = recursive
> 	strategy-option = patience
> 	strategy-option = ours

Maybe "[options]" instead of "[core]" would be more self-explanatory.

If this is meant to be closely analagous to the gitconfig file, then
variable names should not contain dashes.  It would be nice if some
day the config parser could learn to treat dashes as insignificant,
just like it already treats case distinctions as insignificant.
