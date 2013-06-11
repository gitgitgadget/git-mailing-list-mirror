From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 31/45] rebase: trivial cleanup
Date: Tue, 11 Jun 2013 19:08:15 +0200
Message-ID: <20130611170815.GA20009@paksenarrion.iveqy.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
 <20130609191518.GB12122@paksenarrion.iveqy.com>
 <7vhah4d3sk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:05:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmS0f-0007p6-8w
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab3FKRFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 13:05:25 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:63237 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab3FKRFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:05:24 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so6760822lab.24
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BpHx9tv3PuO8qKb35/qv/vnh1+8SnyT8kQQjxrxwjPg=;
        b=G+O44jNMZqv1xRNbXTTp3jueAMG7VKLphGrf/kRasUBW9eCp6q3gDnvCnlO6GFPD9H
         830zvBsNfGZbVWe0lMCCy2Wqtaq0Ofyo1/GQ9Dn3pMDPeIMOwEKGtwL3pq6ZySTpsmg5
         X9KV04PrcX7tlEVTVHNV0s+5/jS2Z2djPLU5FRKqOsMr2X1MzcZMfNMwWah2ua96U/JC
         UElP1c+Si0hK6WYrV8ssPHLDN5if7Y4kq6hZA60cNCWC/hgNqCTo+XqhEnrX8WbvMsrg
         WjuVcWxyVk3TCbIq6dOzt/HL8D4hkBKJpr6YeHek+YK/I4923SIJjjJp2DiwmpXA8l0v
         E4BA==
X-Received: by 10.152.20.66 with SMTP id l2mr5839279lae.30.1370970323211;
        Tue, 11 Jun 2013 10:05:23 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id a3sm7785090lbg.2.2013.06.11.10.05.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 10:05:22 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UmS3L-0005Tl-KY; Tue, 11 Jun 2013 19:08:15 +0200
Content-Disposition: inline
In-Reply-To: <7vhah4d3sk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227465>

Thank you for your reply. Although I agree with everything you say, it
raised a few more questions.

On Tue, Jun 11, 2013 at 09:12:59AM -0700, Junio C Hamano wrote:
> Incorrect.  "git rebase" invokes "git am", not dot-sources it, so it
> does not propagate.

Then git am wouldn't be quite and this patch is doing wrong by removing
the -q argument from the git am invokation. Correct?

> I think it is irrelevant.  git-am uses many shell variables,
> e.g. HAS_HEAD, interactive, abort_safety, etc. but they are
> implementation details of the program and there is no point
> documenting it, and somebody rewriting it in C does not have to
> stick to the same name.

<--snip-->

> There are a few used as implementation details, I think.  GIT_QUIET
> is not among them.

I made a mistake here thinking that git rebase set an enviromental
variable that git am later red. That would have been a way to
communicate, that the first processes that got the -q argument sets the
enviromental variabel GIT_QUIET and all other git invokations read that
enviromental variable.

I do not like that solution. When communicating between different git
commands I prefer, pipes, files and command line arguments. I think it
will be dangerous to include temporary enviromental variables (if we
don't stick to a few of them and document them very well).

In the case of passing information with temporary enviromental variable=
s
it's no longer an implementation detail, but something a rewrite needs
to honor.

I hope I was able to make myself somewhat clear, and if I understand yo=
u
correctly we are already agreeing on this?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
