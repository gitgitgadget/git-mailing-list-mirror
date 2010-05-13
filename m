From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Advice on choosing git
Date: Thu, 13 May 2010 13:31:33 -0400
Message-ID: <AANLkTikLph7SZsAt0aK2Axm7DyrsGta39LZ1vq7aW0c6@mail.gmail.com>
References: <4BEA4B46.6010009@smartmediacorp.com> <201005130018.o4D0I7iI079145@kzsu.stanford.edu> 
	<AANLkTikc6_jZoMzF1VhfJBSk1DRHCNNP3puPT0Z2Usk5@mail.gmail.com> 
	<vpqr5lgggzt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joe Brenner <doom@kzsu.stanford.edu>,
	Noah Silverman <noah@smartmediacorp.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 13 19:32:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCcGQ-0000RE-34
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 19:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375Ab0EMRbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 13:31:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53727 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab0EMRby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 13:31:54 -0400
Received: by gyg13 with SMTP id 13so682202gyg.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=CuXlgQtgppJCfL/kFo6XWEbaqW7r9uG/9iIVyCOZKCk=;
        b=VIbbgbOo7F+lwHg2HwyvtoKIBAojpspX7RGHOUvADOwYmlGuDKWwVlksX52sC3Qeuy
         kNkhLFXoiIJzY/LNnoWncnPS0KNj/iR73mrYMe42/LUDnFz2FjToitLsOk9F1oaLvijv
         76gUKNr4Q/KI38C/OE3ch2rAi9N6s5QjCyjgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=IVGubH3IL9qqrtewVuFj9vYxmOXst+FkxOXZxLj02xSnCSrEOUhBD8DEvFAJJ+3Mz2
         eWVOmknh2+vDjF0/xuPNjDctBSwph+ROsmIwphY5Fv4H3cST3Eg77jA/aGSwwrucLbQs
         9gT5mDjPYkCdtSSaVtuHQctqCNTcAXRNLFFY8=
Received: by 10.150.66.18 with SMTP id o18mr760468yba.242.1273771913200; Thu, 
	13 May 2010 10:31:53 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Thu, 13 May 2010 10:31:33 -0700 (PDT)
In-Reply-To: <vpqr5lgggzt.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147017>

On Thu, May 13, 2010 at 7:48 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> You can only fill up your disks if
>> you download tons of movies and/or create tons of VMs.
>
> Right, but if you do so, managing your movies and VMs with Git would
> be really bad idea. Typically, you don't want your backup system to
> try to diff each movie with each other to save space.

This problem is supposedly solved by the git-bigfiles project.  bup
does things a bit differently, but works well when deduplicating
things like VMs and movies, even though it uses the git repository
format.

>> Just make sure your backup/syncing software has an expiration
>> algorithm so you don't end up storing *all* the historical copies.
>
> And this is where Git will be really bad. Removing past revisions
> means editing history, and while Git knows how to edit history,
> syncing after doing that will be terrible.

Yeah, obviously an SCM doesn't really need history expiration
features, and git's transport protocols are optimized with the
assumption that expiration will never happen.  bup uses a different
protocol so it won't have this problem (but bup doesn't have any
expiration features at all, right now).  rdiff-backup, which I also
mentioned, is efficient in the face of expiration.

Have fun,

Avery
