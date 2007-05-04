From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 02:26:38 -0700
Message-ID: <56b7f5510705040226o14d55b6euda7df1da7ad9b08a@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	 <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com>
	 <81b0412b0705040217o54d1d028j6e768bdc3eb0bad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 11:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hju3n-0005Do-EG
	for gcvg-git@gmane.org; Fri, 04 May 2007 11:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767758AbXEDJ0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 05:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422909AbXEDJ0k
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 05:26:40 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:54552 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422906AbXEDJ0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 05:26:39 -0400
Received: by nz-out-0506.google.com with SMTP id o1so799794nzf
        for <git@vger.kernel.org>; Fri, 04 May 2007 02:26:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WMnnVj3G8+eFiwhESP9XUNDyJDruwfQ7Or+FYas4rYohHsSWPpz5DU0HM/UScUopPh+8J883XKDVJnVfH1xh1f+PieqQ0uUUx8OEsrYF2qV+7/bkYi4Z4Xfq11PzHiuvQfPtVepCKbpUVOBEFMg7MKkjjIq/3YQ5GrWh5iOa+Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UorcXCNwPW2F6fOB/Xiu9mZTLNNM1Yzv83ThZAQeSroTvBc1ZozIGSLMcmBEaT1lIKg2b2o23GFS1530X+BnMEhFZuT5Xthe0TiwQ5k+t1UgglzK329ZlQa+NYHew3a2QrKclavgBm0LaWAQjB306y9PkAQ5VJ0F4m1f+HboZg8=
Received: by 10.114.134.1 with SMTP id h1mr1060855wad.1178270798708;
        Fri, 04 May 2007 02:26:38 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 02:26:38 -0700 (PDT)
In-Reply-To: <81b0412b0705040217o54d1d028j6e768bdc3eb0bad0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46152>

On 5/4/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > > My preference is (2), (3) and then (1), but I do not have
> > > > offhand a suggestion for a good metacharacter we could use.
> > >
> > > "./" :)
> > Heh.  Yes, that works in the current patch.
> >
> > I'm really starting to like the idea of introducing "="
> > as an alternative for ":" :
> > "=" assumes relative paths, ":" assumes absolute (full) paths.
> > That could be Junio's new metacharacter.
>
> Just keep in mind: "once introduced, you'll never be able to remove it".
> And I don't share your feelings regarding the special character, for instance.
Indeed.

> I'd suggest to define a special character for _top_ level. Real pity
> ":/" is taken.
We could use ://fullpath for top level,
and :relpath for relative. Then "string" in :/string couldn't start with /,
which shouldn't be a problem (right?).  I've certainly seen double
slashes before;
perforce in fact uses them for the root of the repository (depot).

This all depends on deciding that :relpath should be the (incompatible)
new default, and I'm not sure that's going to happen.

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
