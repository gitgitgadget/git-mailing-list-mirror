From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 09:53:56 -0500
Message-ID: <30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>
	 <alpine.LSU.1.00.0801111348230.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 15:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDLHC-0006ff-3R
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 15:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759589AbYAKOyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 09:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758096AbYAKOyA
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 09:54:00 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:37447 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759462AbYAKOx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 09:53:59 -0500
Received: by wr-out-0506.google.com with SMTP id c49so457724wra.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 06:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lEOZffpYUgTiuW+l+LO8z/PZOxX6qZNDPTJn7rmk7ds=;
        b=xDZ1SBe7TnUGFSkviK4jB3ga1mBLi6Nsjw2+vEC1z7RhZUvGYof+xj3QZgBKarJb8Tz7Z5a3IbO8pkzFQyPWzwjviIyiQs238Qklytv9EKarsWk68F8IVo90AIoZG0KX39Q78GrutwuiaG+rYse/wMDak12qEjEtG9MniTZpnsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zt/SeHxg6EvzD+5PC6ObydDxYjqoQ+O6HaDOG9sXMxn7NO/xl+GkrOCvtDmVyEO11hA+HuAkFzbD+N2IwP9uk/8Lk6BfZv4DUvsCMrqMliGXBGZj0rCvlMVEhd49CwKSB76hNOIo55OLMZYULfS6JVI4RulHKnP/zlFfXbuHTX0=
Received: by 10.142.201.3 with SMTP id y3mr1684825wff.1.1200063236801;
        Fri, 11 Jan 2008 06:53:56 -0800 (PST)
Received: by 10.143.159.5 with HTTP; Fri, 11 Jan 2008 06:53:56 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801111348230.31053@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70164>

On Jan 11, 2008 8:52 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> IMHO you should optimise the communication by agreeing on one origin,
> or alternatively not talk about a server at all (which is made easy by the
> global uniqueness of commit names; just say "my tip is ac9b7192").
>

We *cannot* agree on one definition of "origin": there is no single
server accessible by all, but use of submodules currently *requires*
that each repo's upstream be given the nickname "origin". With this
change, I can enforce that each server has a unique nickname and that
one unique nickname per server is used across the program. Absent
this, I cannot and end up having to have everyone translate "origin"
into what it means for them.

SHA-1's are absolutely unique, but what do you do when "origin" does
not have  acdc101? I want to know that server-x@joe.com doesn't have
it, while server-y@mary.org does. This is the frequent problem in
conversation, and is the reason we have to be able to talk about the
particular upstream server.

This change does not eliminate the ability to obscure multiple
different server names using "origin" for those who think that is the
best way to do things, it just eliminates the requirement for doing
so.

Mark
