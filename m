From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 18:47:17 -0500
Message-ID: <20120710234717.GA21467@burratino>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino>
 <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
 <20120710201105.GH8439@burratino>
 <7vsjczgx3h.fsf@alter.siamese.dyndns.org>
 <20120710210901.GI8439@burratino>
 <7vehojgqgk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 01:47:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sok9W-0006TB-9t
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 01:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab2GJXr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 19:47:28 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:39724 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab2GJXr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 19:47:26 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so659378ggl.19
        for <git@vger.kernel.org>; Tue, 10 Jul 2012 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RvURAG3enkQV0Ovi/ARmHaA6cVad7915wTASn6Wpso0=;
        b=Kgh8M9XnLiM5zKIcAzS0bRskMdl1xfxOIuQGjMenYRGsdvWvLbEs2dlLYsl/uvAPjX
         SNXQHnKifBmaYQAQ+37l1aDCk0Nn8I/RqH+1JA637OGdeyyY9U8XLsyjuU9clkqHx5z1
         RiBDSPZVyRs5VTrWB6De8DS9J5O/hiFHzT/wCgVBiMK4cFJzr91p/VLlDYyO9xtt1ijE
         qbmpJDmuLCbfcPMjrj/4Ky7X71dovVAt+J3LiOohUwv2Kc6tM353dyMiMRWpVtFUiEli
         TMXqMgv6d6lxwr1szwkF5N+mjzWVN89wckwL4J+EJ+gfor8aHFmPrvYG0FPpvq88b1PB
         zMQw==
Received: by 10.50.237.1 with SMTP id uy1mr13090898igc.18.1341964046140;
        Tue, 10 Jul 2012 16:47:26 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id bj4sm12925693igc.16.2012.07.10.16.47.24
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jul 2012 16:47:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vehojgqgk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201286>

Junio C Hamano wrote:

> You can think of it this way.
>
> "git branch" can not only _create_ a new branch (or list existing
> ones, but that is another entirely different mode), but also can be
> used to set attributes to an existing branch.  Imagine a new option,
> say --set-description, to replace branch.frotz.description, for
> example.  It would be used like this:
>
> 	$ git branch --set-description='add frotz feature' frotz

That's the same question.

You say that it would be used like that.  I say that it would be
more intuitive, given how "git remote", "git config", and other
commands other than "update-index --chmod" that set attributes already
work, for it to be used like this:

	git branch --set-description frotz 'add frotz feature'

Notice how similar that is to "git remote set-head origin master".
It would just be the consistent thing to do.

The truth is that neither one of us is right.  Both conventions
could work, and which one is more intuitive will vary from person
to person.  The convention used for plain "git branch" is

	copy(target, source)

That matches memcpy() and is the opposite of what "cp" uses.  Oh
well.  The convention used for "git remote add" is

	method(this, args...)

It's generally pretty natural.  The convention used for "git
update-index --chmod" is

	action(parameters)(files...)

That matches "chmod" so it was probably a good choice.

Hoping that clarifies,
Jonathan
