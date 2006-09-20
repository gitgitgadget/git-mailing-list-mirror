From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read refs
Date: Wed, 20 Sep 2006 13:00:08 +0200
Message-ID: <200609201300.09266.jnareb@gmail.com>
References: <20060920085200.GA21865@shadowen.org> <eer19l$6hm$1@sea.gmane.org> <4511173D.7020702@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Wed Sep 20 13:00:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPzoV-00044v-JK
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 13:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWITLAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 07:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWITLAQ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 07:00:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:8768 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751107AbWITLAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 07:00:14 -0400
Received: by nf-out-0910.google.com with SMTP id o25so449009nfa
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 04:00:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OGrhBkpvbbcsyuyex17d3tHNOIjTboKjsYMYK01V5N8JHaycwpHpxDO0jzX4khvKbFk2cHNU2202UYY2isYdP9OeioBb6+DHEyaazvE+j7srngNIEWfTyVHj1Ds75WVNSNS0T7XdDMwfUQxxNHRn7q+NHt3PZ05+U94olFHTTxo=
Received: by 10.78.136.9 with SMTP id j9mr1624596hud;
        Wed, 20 Sep 2006 04:00:12 -0700 (PDT)
Received: from host-81-190-26-22.torun.mm.pl ( [81.190.26.22])
        by mx.gmail.com with ESMTP id 4sm600504hud.2006.09.20.04.00.10;
        Wed, 20 Sep 2006 04:00:12 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <4511173D.7020702@shadowen.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27341>

Andy Whitcroft wrote:
> Jakub Narebski wrote:
> > Andy Whitcroft wrote:
> > 
> >> +       open(H, "git-for-each-ref --format='%(objectname) %(refname)'|") or
> > 
> > By the way, this is equivalent to using "git-show-ref" introduced by Linus.
> > But if you want commit timestamp
> > 
> >> cvsimport opens all of the files in $GIT_DIR/refs/heads and reads
> >> out the sha1's in order to work out what time the last commit on
> >> that branch was made (in CVS) thus allowing incremental updates.
> > 
> > you can use it in --format as well.
> 
> Unfortuantly, for-each-ref only offers us the textual version of this
> information not the numeric offset from the epoch which is what
> cvsimport is after.
> 
> I guess we could teach for-each-ref to output this as well?  Perhaps
> something like authorstamp?

Or authorepoch. 

I thought about following rpm idea of format modifiers, like 
authorepoch:date for strftime(3) "%c" format or 
commiterepoch:day for strftime(3) "%a %b %d %Y" format.

Feel free to provide patches ;-)
-- 
Jakub Narebski
Poland
