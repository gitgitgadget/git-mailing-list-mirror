From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Tue, 30 Apr 2013 07:48:58 -0400
Message-ID: <CAH_OBidM2D4Nkb9tHTWqPRVz0GVUEnn9NJ++rzWGYSd+7sgTMg@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
 <20130420140051.GB29454@ruderich.org> <7vd2towdiq.fsf@alter.siamese.dyndns.org>
 <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
 <20130421102150.GJ10429@elie.Belkin> <CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
 <20130421160939.GA29341@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Tapsell <johnflux@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 13:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX93k-0007TF-9r
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 13:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759864Ab3D3LtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 07:49:20 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:57349 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759401Ab3D3LtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 07:49:19 -0400
Received: by mail-ve0-f174.google.com with SMTP id b10so281982vea.19
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jjIAVpZe2VT2yoPb+6AtjphSB5w8uBIenJEbzxxPNvs=;
        b=tmbcVklwGGMFSF7AkFc9vfjBBhmXdga8lc6H3QAW2Grl9xoB5mDWRH9CmRBwh+5zFO
         YyH3lXxyJvyvYHRwGBW1OCi6edNZy9QUHgU/BYu+pZTWuH/OpzAlelmIn+BA57g7wXyW
         9GasD7pfnFXmEQL+Vnua4M2niLVCS6HBFJdQjvuXnyxoHKn95LjZ3Gewkp0tTHykq+3p
         46pdF9NqAlcw6GcnfSsnplRtYfwE+IeOjI4iLLnZvgeme4wSXrYV16Dl5zhyDSCGQLAS
         8yImxTwrEJ+hR0PMEUGMS+V25lFlW0DXb1w7cHNEE0wTOOMojwyMEHkRxYMKK3/ZpPix
         FrlA==
X-Received: by 10.58.214.231 with SMTP id od7mr34983870vec.44.1367322558679;
 Tue, 30 Apr 2013 04:49:18 -0700 (PDT)
Received: by 10.52.103.14 with HTTP; Tue, 30 Apr 2013 04:48:58 -0700 (PDT)
In-Reply-To: <20130421160939.GA29341@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222929>

Sorta OT, but I'm curious,

On Sun, Apr 21, 2013 at 12:09 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> For example, whenever git adds (or plans) support for a new header
> line in commit objects, before you've upgraded, a prankster can
> provide a bad value for that header line in objects they hand-craft.
> "git fsck" in your older version of git will accept the resulting
> objects on the assumption that they came from a newer version of git,
> so you won't notice.  Later you upgrade Git and "git fsck" considers
> the objects malformed.  Clients with "[transfer] fsckobjects" enabled
> start to reject your history.  That is, this person has made your
> repository corrupt in the eyes of "git fsck".
>
> The usual excellent integrity checking will let you pinpoint the
> problem to the merge from that untrusted person so you can avoid
> trusting them again, and all the data will be there to recover without
> them.  So it is auditable later.  But this does mean that with the
> current design, there is some level of trust required to let someone
> commit into your history unless you inspect their work with a
> fine-toothed comb.
>

Has anyone written a test case for this?
