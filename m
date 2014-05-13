From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH v2] contrib/subtree bugfix: Can't `add` annotated tag
Date: Tue, 13 May 2014 23:02:01 +0000
Message-ID: <20140513230201.GA32562@debian>
References: <1399954138-2807-1-git-send-email-nod.helm@gmail.com>
 <xmqqa9alo4lm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Cagle <kcagle@micron.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLi8-0000qR-23
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 01:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbaEMXCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 19:02:08 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:63226 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaEMXCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 19:02:05 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so7861004wib.4
        for <git@vger.kernel.org>; Tue, 13 May 2014 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BmCc7JZ35nDs4PScuXr/Jbira/HuAp/Af4dOBOb4zUE=;
        b=gyWcjjjXqA8HCRssH9vtq0GmX4HYTQDdP1gRLlsTv5EdGa9SrPhRMFaUVxXxRv7jHl
         Gy/ung8EI6sFm8VuintDuzk1KD1W/KxJczRZhi8WSfmZCnqkBAEI4U4R0EarWjQRMmuj
         aWaB1+V9mL+xZpAClqyttFfciWCxHgNo/uu1DVEIBWKJFSw76rwjuwZjFWki1FGc/PM3
         Sboop1idvGkNeMmC1GkeJO/nTtwU7rTZ5Kew07P7Buf0Af0C3TucbFDQHYSkUDyd6l0G
         dWhCrnDquscG6xyz2krb62YNzEzyWaEmpZuBXlGwoLTV3Qt7qYhvqnZA9PAPNeRgkhmn
         hFIA==
X-Received: by 10.180.85.163 with SMTP id i3mr23418880wiz.14.1400022124254;
        Tue, 13 May 2014 16:02:04 -0700 (PDT)
Received: from debian ([2a04:1980:3100:1aac:21b:21ff:feda:4cbe])
        by mx.google.com with ESMTPSA id hr4sm23980927wjb.28.2014.05.13.16.02.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 16:02:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqa9alo4lm.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248883>

On Tue, May 13, 2014 at 12:34:13PM -0700, Junio C Hamano wrote:
> James Denholm <nod.helm@gmail.com> writes:
> > I felt that defining revp would be a little more self-documenting than
> > using $rev^0.
> 
> That is a good decision, but as long as we are attempting to peel,
> don't we want to stop the damage when it does not peel to a commit?

I'm not sure that can actually happen - peel_committish is essentially
implemented as `rev-parse $arg^0` (though with a bit of bling, of
course), and to my understanding FETCH_HEAD will always parse to a
committish - I could have missed something, of course.

subtree Will need error-catching at some point, of course, triggering
resets or at least suggesting instructions to the user, but I think
that's a touch out of the scope of a bugfix at this point (and, to be
honest, I personally can't allocate the time to that for about a month
due to the dark shadow of academic exams). Indeed, what to do in those
cases is probably worth (re-)discussing the overall design and aims of
subtree for, and so I'm not confident that I currently know the best way
to do that.

> I'll tentatively queue this.  Thanks.

Awesome, thanks again for this and the feedback.

---
Regards,
James Denholm.
