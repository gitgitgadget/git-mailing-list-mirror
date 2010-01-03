From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: suppress fatal pathspec errors from "git add"?
Date: Sun, 03 Jan 2010 01:44:02 -0800 (PST)
Message-ID: <m33a2ncyj2.fsf@localhost.localdomain>
References: <d7ac1a680912311324i85b7a5anadaf2ac13f215873@mail.gmail.com>
	<20100103074058.GB23031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: aaron smith <beingthexemplarylists@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 03 10:50:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRN6S-0006td-GT
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 10:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab0ACJoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 04:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800Ab0ACJoG
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 04:44:06 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:40111 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab0ACJoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 04:44:05 -0500
Received: by ewy19 with SMTP id 19so6359901ewy.21
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UH7LBbYmA3ETNyB6XgdDc3sdMMyZvxjNnBxx3ohBXEo=;
        b=GU5P00L2OPoaD/cezV3pYli364gV0GE5oWlqcwi+EE8N/zkFqFmVOHauxq5PA/LTEZ
         nC918O0tqxOUZwV+blThkp3DkboOjTBW9nKPskjF6teAToH77wvDELIcwzQJTlz8Z1ek
         lpsYHBGy8uBmtgJXDEDV1wo333lPR3hvCGwfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HUU9aMdbOmbJd6YMTypSUAHXnlpntgBAbI9eaW3csEZJFnrF8K5rUz63t3vhweu9Ay
         c4YvjkZAgl8reJJubaWepu6f+QvuBGNRfodA4VtayWlD3r+gmzF4ozEaE76LDN7mpl1S
         1YdVS/CXuFZIorPINGGxI2kGuinjgGuZK0pYQ=
Received: by 10.216.88.85 with SMTP id z63mr7486912wee.129.1262511843217;
        Sun, 03 Jan 2010 01:44:03 -0800 (PST)
Received: from localhost.localdomain ([72.14.240.161])
        by mx.google.com with ESMTPS id i35sm45636303gve.11.2010.01.03.01.44.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 01:44:02 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o039jcuZ019824;
	Sun, 3 Jan 2010 10:45:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o039jMtk019817;
	Sun, 3 Jan 2010 10:45:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100103074058.GB23031@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136073>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 31, 2009 at 01:24:59PM -0800, aaron smith wrote:
> 
> > I'm looking through the add documentation, I don't see a way to
> > suppress fatal pathspec errors? For example, if I'm adding 5 files,
> > but one of them is mis-spelled, can I have git just supress the errors
> > and add the other four?
> 
> Hmm. I would have thought "git add --ignore-errors" would do what you
> want, but it only ignores errors in reading the file. If we can't stat
> it, we will always die. IMHO that is an oversight in how
> "--ignore-errors" works (why should this one particular error be treated
> as fatal, when others are not?).

I have thought that this is task for --ignore-missing / --missing-ok
option, but this option(s) does not apply to git-add / git-rm; the former
is from git-write-index, the latter form from git-write-tree.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
