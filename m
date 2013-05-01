From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 5/6] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 09:03:51 +0700
Message-ID: <CACsJy8D_-S_BvQAa5b2+XpfM2-fJcEQ5EJa4RRtV1vQPEe1emA@mail.gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com> <1367358554-4257-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 04:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXMPC-0005lx-I1
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 04:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934097Ab3EACEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 22:04:23 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:50166 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934089Ab3EACEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 22:04:21 -0400
Received: by mail-oa0-f41.google.com with SMTP id g12so1116876oah.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 19:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lYGOz6u8NvL5k+MCnOW+oQIH3BDS7Wun6p470CaSXbY=;
        b=WeXbzggWBUwBnypXjgzHMlJY8eh0jOJT+3ns/Qe7+qwr4/dHVEDGI6FlGUvUW8xRmR
         c4gaLrwyVMMjzR5bk8Wgl9FOI8PT9bqlDydDs7f/+PTFhU/9G79GbE3ucFktmK1hRT6V
         Zd46Rf13tpBMTuQkIerL1oplQyEInnyLcnBKIdhPkb3mBoNlAxZ9v3/uBPt20CZCxZXF
         HRJZPMs8u9CSs5EjnRCzDPv3wO8HrlZUenqYRP4rMxyJXXYzEA3Rx8bSMS/st683UUF8
         KmJv/Kw9HuvfmhYmqc1efSbG87bErTL2VTU1WRFGFv9IRxWbumCP9VRS7DboFBs/nKjA
         HxpQ==
X-Received: by 10.60.56.102 with SMTP id z6mr202940oep.110.1367373861230; Tue,
 30 Apr 2013 19:04:21 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 19:03:51 -0700 (PDT)
In-Reply-To: <1367358554-4257-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223064>

On Wed, May 1, 2013 at 4:49 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
> can't remove '{0}'?
>
> This patch allows '@' to be the same as 'HEAD'.
>
> So now we can use 'git show @~1', and all that goody goodness.
>
> Until now '@' was a valid name, but it conflicts with this idea, so lets
> make it invalid. Very few people if any probably used this name, if they
> did, they can rename it by using the full-path (e.g. refs/heads/@).

People can write master short for refs/heads/master, but can't with
refs/heads/@. Would it be better to detect if dwim_ref("@") exists,
then disable special '@' and warn user to rename '@' to something
else? After they have renamed it, make '@' special and forbid it in
any component in the ref (i.e. refs/heads/@ is forbidden too).
--
Duy
