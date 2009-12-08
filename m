From: David Aguilar <davvid@gmail.com>
Subject: Re: How do you best store structured data in git repositories?
Date: Mon, 7 Dec 2009 23:14:09 -0800
Message-ID: <20091208071356.GA4970@gmail.com>
References: <1259788097.3590.29.camel@nord26-amd64> <32541b130912021317y705d1d4cj28e230a3e727df2e@mail.gmail.com> <20091204001359.GA6709@gmail.com> <1260220821.3545.12.camel@nord26-amd64>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Setzer <sebastianspublicaddress@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHuGE-00030e-3T
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbZLHHNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbZLHHNN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:13:13 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:42924 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbZLHHNM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:13:12 -0500
Received: by ywh36 with SMTP id 36so5156632ywh.15
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 23:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Abt9ImJ9TCfCxhVZKittvqT3B2MEA1EKXs2jkEBCGEk=;
        b=V+JwA/cLlkq2RpgM0NPwoomUO6pe6wIt0tYlHcNRgD0L260pxQvqPleRF7AAkNhGse
         BolRlwT44tHej0ioTIWGZgaqIfHIUTuTIhsrR05ijuK3/NgbdgugfDb3r07fYDM9QBEV
         FA1PLAZFZHW7UvvR0g3wPPwWcdgrGqmYbqHQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MJzwTdrJvmzLdewcZevHlmbtt4CnMyWOWFyrnm0c7Rfjck3th5nQeDTdKttaT/gFNl
         jdV/l2o47cEtWt82WQz4gPUBKb+dv+0YdzMUmq1tES1Rm6nmMonJl9yRIIw4Qbvzj3tD
         xXsRoLtWiSkZ6aN3CQu0/gBC48RI+YKE9OZh8=
Received: by 10.150.120.41 with SMTP id s41mr13206132ybc.327.1260256399278;
        Mon, 07 Dec 2009 23:13:19 -0800 (PST)
Received: from gmail.com (cpe-76-171-7-203.socal.res.rr.com [76.171.7.203])
        by mx.google.com with ESMTPS id 15sm3306745gxk.8.2009.12.07.23.13.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 23:13:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260220821.3545.12.camel@nord26-amd64>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134828>

On Mon, Dec 07, 2009 at 10:20:21PM +0100, Sebastian Setzer wrote:
> On Thursday, Dec 03 2009 at 16:14 -0800, David Aguilar wrote:
> > On Wed, Dec 02, 2009 at 04:17:10PM -0500, Avery Pennarun wrote:
> > > On Wed, Dec 2, 2009 at 4:08 PM, Sebastian Setzer
> > > <sebastianspublicaddress@googlemail.com> wrote:
> > > > Do you use XML for this purpose?
> > > 
> > > XML is terrible for most data storage purposes.
> > 
> > I agree 100%.
> > 
> > JSON's not too bad for data structures and is known to
> > be friendly to XML expats.
> > 
> Sorry, I didn't want to start a flamewar against XML. I'm no big friend
> of XML myself, but I don't know of an (open source) diff-/merge tool for
> any general purpose file format other than XML or plain text.
> When you mention other formats, I'd be interested in
>   - why this format is good for storage in git
>   - if there are merge tools available which ensure that, after a merge,
> the structure (and maybe additional contraints) is still valid.
> 
> Thanks for your comments,
> Sebastian

Sorry, didn't mean to sound xml-flaming.  The only reason for
mentioning json, yaml, etc. is that they're good data structure
formats.  They're all plain text formats, so you can use existing
diff/merge tools.

I guess none of this has much to do with git aside from being
able to write custom merge drivers to operate on them as data.

If there's a diff/merge tool for xml that works well then
hooking it up to git-{diff,merge}tool might be something
to try too.

-- 
		David
