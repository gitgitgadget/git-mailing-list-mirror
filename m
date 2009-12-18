From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Fri, 18 Dec 2009 13:59:50 -0600
Message-ID: <fabb9a1e0912181159u65ae9c6fg1481ab744575475f@mail.gmail.com>
References: <4B274BDE.8000504@viscovery.net> <4B2B5085.1050906@viscovery.net> 
	<7v4onoywws.fsf@alter.siamese.dyndns.org> <200912182004.25520.j.sixt@viscovery.net> 
	<7voclwxemf.fsf@alter.siamese.dyndns.org> <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com> 
	<7veimsvz8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 21:00:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLizx-0000rw-LK
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 21:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZLRUAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 15:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbZLRUAT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 15:00:19 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:58269 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbZLRUAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 15:00:16 -0500
Received: by vws30 with SMTP id 30so1111828vws.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 12:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=2W3To7XFt648RJeebykMVnVAj5YK7KcFYUuKUdp7Xx4=;
        b=fLkNTY5xaw1PpB1X/Y5w3+MSG3VCdd1VpCzeuHE0DPhN0YSOzYlKnPxHa2skNgGX3B
         PuV8sI6OsIlpqbWjeaOyPOxqZEFg57+fcBQlwmhDyO7qc1nV78DvbLNCYRb8eiTXAsn6
         AlnUDeovU3+kJFH6B3a4zl4z+9JHMzDDRHIac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GykE5GLNJIXU/23R5zY5SUxYmeQkq5vW8SvJYREsVa7iGynVL06BNphVe9fOB7S9va
         EFhMJvSQ8cF90leQehSGGZnrlOVTbPh1NuvLxrQR/IKoc5lL2DFgsajCcXzFD7AK8jia
         o4MfFysN3QSq4H3XYaat4w9T9BhWUpNeUUHLo=
Received: by 10.220.122.215 with SMTP id m23mr3190278vcr.42.1261166410475; 
	Fri, 18 Dec 2009 12:00:10 -0800 (PST)
In-Reply-To: <7veimsvz8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135434>

Heya,

On Fri, Dec 18, 2009 at 13:49, Junio C Hamano <gitster@pobox.com> wrote:
> You might type
> "commit" when you meant to say "commit -a" and record an incomplete state;
> it is "dangerous" in that sense.

Speaking of which, it has hit me multiple times that I craft out a
commit with 'git add -p' and then do "git commit -am 'foo some bars'"
and lose all my hard work (because I'm used to typing 'git commit -am'
for temporary commits). I'd be happy if "git commit -am" learned to
second-guess me when I already have something in the index.

> These are part of their feature.

Fair enough, then perhaps it is time for "core.nodataloss" which
either logs states to a seperate reflog (so that you can go back to
the state you were in before doing 'git read-tree') or interactively
informs the user that this will command will result in data loss
(although that sounds a tad too much like Window's "Are you sure?"
dialogs).

-- 
Cheers,

Sverre Rabbelier
