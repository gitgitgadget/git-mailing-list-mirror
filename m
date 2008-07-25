From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFC] custom strategies in builtin-merge
Date: Fri, 25 Jul 2008 13:50:40 +0200
Message-ID: <bd6139dc0807250450m25a932b8h68fcee13f8c343dc@mail.gmail.com>
References: <20080725113316.GF32057@genesis.frugalware.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 13:51:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMLpn-0003ar-Au
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 13:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYGYLum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 07:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbYGYLum
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 07:50:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:45276 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbYGYLul (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 07:50:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4059591wfd.4
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DFk1l1Rz3PjpnywzueT2ZGkJ+eL7hOiYld4ulIp3/Vw=;
        b=Nup/7k84p6dKOE4b8emaCy9UryLuF4Z/0APoRUI+d2IlhHmp70cpFnPELfEK5VnNTp
         u5TRXUGfsiD/v39v7MMFbkpwi02rG9W5/dFXVneNk9Xa+Ziuw9oyTA9SQZUmWucKnQxY
         rXYIjN0dezCrd4lLkXcalVImmo/kjNbd2T55w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=ajihiPmJzuFX+UaClIKDbXY+xcwTokGk7B13wsqu7reFagjL3lSvZXQkVvxk4Vaggi
         Cj8CcqDKAQK2xgCHPlQT3eMblPGyCfa3zeHAFGRUsEnfLYN9I/8zqfZBZ60EMhSngvaN
         byTP1lmeCmmwCNCwzwLs2Ho4Co1OJ3MY2dov8=
Received: by 10.142.172.12 with SMTP id u12mr516867wfe.116.1216986640910;
        Fri, 25 Jul 2008 04:50:40 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 25 Jul 2008 04:50:40 -0700 (PDT)
In-Reply-To: <20080725113316.GF32057@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90037>

On Fri, Jul 25, 2008 at 13:33, Miklos Vajna <vmiklos@frugalware.org> wrote:
> 1) Maintain a list of commands that has a git-merge- prefix, but not a
> strategy. This list would currently contain "base, file, index,
> one-file and tree".

Sounds a bit error prone, and could lead to unexpected results if/when
someone creates a new command ('git merge status' anyone?) which is
then suddenly treated as a merge strategy.

> 2) Require custom strategies to have a different naming scheme, like
> if "foo" is a custom strategy, then it would have to be named
> git-merge-custom-foo, _not_ git-merge-foo.

I think this is cleaner, what would be even nicer is to change the
current names too, so name them all "git-merge-stragegy-foo".

-- 
Cheers,

Sverre Rabbelier
