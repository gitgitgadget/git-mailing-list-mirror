From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Thu, 20 Oct 2011 03:03:28 -0500
Message-ID: <20111020080328.GA12337@elie.hsd1.il.comcast.net>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
 <1319058208-17923-4-git-send-email-artagnon@gmail.com>
 <7v8vogbgai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 10:03:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGnbM-00068k-1W
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 10:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab1JTIDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 04:03:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64493 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1JTIDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 04:03:36 -0400
Received: by iaek3 with SMTP id k3so3118007iae.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qf6SuMm4rNIzd6QnBeO536tjsQ0w2ePLe7HoXKmIhAE=;
        b=x2zyBqy6K1+NUjIYxhoto5ENf6NlGG7V4TjVGE2foKicA/KTgaH3ckFZGGrJXWtJjL
         GXSXpOZhG3gT4WYjfQ4Fwp6iBmKrVoHw37Hw3EmDqQ6UfTzNsd5NburMz2ADhbiooYre
         B46gePfMU6Vhlw4N7opHZPF01F8IQ3s25cggg=
Received: by 10.231.82.2 with SMTP id z2mr3911876ibk.67.1319097815959;
        Thu, 20 Oct 2011 01:03:35 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g16sm21639616ibs.8.2011.10.20.01.03.34
        (version=SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 01:03:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8vogbgai.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184015>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> Check that the commit name argument to a "pick" or "revert" action in
>> '.git/sequencer/todo' is not too long
[...]
> Given that this function is going to be fixed properly so that it does not
> even need to use the "on-stack buffer", is this really necessary?

Right, I don't think it is.  Keeping a testcase sounds worthwhile,
though.
