From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Git Questions
Date: Mon, 20 Aug 2007 13:59:41 +0100
Message-ID: <e1dab3980708200559v3f1def4ft85e31afb08394790@mail.gmail.com>
References: <1187603749.11595.10.camel@tom-desktop>
	 <87bqd2bgb0.fsf@morpheus.local>
	 <1187612156.11595.17.camel@tom-desktop>
	 <200708201346.21557.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Tom Schinckel" <gunny01@gmail.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 14:59:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN6rF-0007Re-Lo
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 14:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbXHTM7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 08:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbXHTM7p
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 08:59:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:36037 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbXHTM7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 08:59:44 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1227810wxd
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 05:59:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W/1YXgpzEagFlwgK94y0Yj1ccLFdla76nHAjqJBB++Z91363H1FHElQKFu+W4bifCzLuU1w7q/ESrmf2M4xW4gvBPAB5AXX5GSBFDTek6SCDb+dAD4zaHbc0ZxgZ3Res3dmO0Pbg9BI53i1oc1B/gTQd9PD9JFvtmndrAapPySw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DX6MuUYPU0pEUmHWfROf54TNFh2jLe8Mgr4v2QvjXlFakNKklixNgjmSBFSmhWTbFEVgDa3hHOU75omrZdm4AT+/b4hV2em7D52Kxdy9RVQSaaNo5CS1UOhzCsDJbU1CvehDTVET4OZGWCyrRv1G0CY5voE9CoJ4QsYxksiByyE=
Received: by 10.70.65.8 with SMTP id n8mr10646374wxa.1187614781491;
        Mon, 20 Aug 2007 05:59:41 -0700 (PDT)
Received: by 10.70.26.12 with HTTP; Mon, 20 Aug 2007 05:59:41 -0700 (PDT)
In-Reply-To: <200708201346.21557.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56213>

> On Monday 2007 August 20, Tom Schinckel wrote:
>
> > The reason I want to do that is so I can set up blind commits that I can
> > add in a anacron job or something. The information about the files isn't
> > really important

Regarding your basic intention, I've worked on something _similar_
using git and put it up on the web (although not got around to editing
the git wiki) at

http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.htm

(with a minor update is going to go up when 1.5.3 gets released & I
test it works.) There are two important differences with what you want
to do:

1. As I recall someone else saying when talking about using SCM
on their home directory (Joey Hess?), if you blanket record
everything you then end up being careful about, eg, piping a
grep search into a temporary file for some purpose, etc. So
chronoversion takes a python function that decides if a file
is "worth recording" (which can be by suffix or more general
analysis).

2. As I've got a nervous tick of saving every couple of minutes
(in case the editor or network I'm on dies), recording on save
is too fine a granularity for me, so the script is designed to
run from a cron job (I have it at once an hour) and not make
a commit if it finds nothing has changed.

As I say, not exactly what you're looking for but it might be
in the right direction.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
