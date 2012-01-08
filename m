From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] The move to sequencer.c
Date: Sun, 8 Jan 2012 14:43:38 -0600
Message-ID: <20120108204338.GN1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <20120108192853.GE1942@burratino>
 <CALkWK0=xhnXq4_uEAri74Kk9zbAgiS+z-nG7Etm3MCo2cXaNPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:38:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzVq-0006ut-PJ
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab2AHUic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 15:38:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59333 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232Ab2AHUib (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 15:38:31 -0500
Received: by iaeh11 with SMTP id h11so5716985iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=b3HW4J0aokt5eOtedhrDSSRi4TYPdmLDras0q2lgYyI=;
        b=v5esX2q4bSNop/7qs7NZ8jjWhmPFOF+x6l6jsnfsO7XnNyn7atyDpkaplt3oXEFPYv
         R5Qlpv5Jy5V0QvGRJRWfclTBP3nnjtVkM8/6ZnJabHGP/4cmaBagW/ckGLfj0XPPh6GF
         4DY6pMf8YDlhh88ehTZ0zUNIsnmS038pbJino=
Received: by 10.42.168.135 with SMTP id w7mr13481723icy.9.1326055111001;
        Sun, 08 Jan 2012 12:38:31 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id lu10sm122651640igc.0.2012.01.08.12.38.30
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 12:38:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=xhnXq4_uEAri74Kk9zbAgiS+z-nG7Etm3MCo2cXaNPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188131>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> For the sake of new and forgetful readers: what is that objective?
>
> The objective is to build a generalized sequencer
[...]
> In these examples, the instruction sheet is uniformly filled with
> "pick" or "revert" actions, which is not very interesting.  When we
> get an interface to allow easy editing of the instruction sheet and
> encompass more builtins, more interesting sequences of operations will
> be possible like:
>
>   pick rr/revert-cherry-pick^2~34
>   revert master@{12}
>   merge next
>   am /tmp/jrn.patch

Ah, okay.  So the tasks at hand are (1) allowing heterogeneous
instruction sheets (pick + revert for now) and (2) exposing the
sequencer interface in sequencer.h.  (2) does not strictly
depend on (1) but (1) has more short-term benefit that is easy
to test so it comes first.  No UI aside from editing the instruction
sheet manually for now, but that can come later.  Thanks for
explaining.

Jonathan
