From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE qgit-1.0rc1]
Date: Tue, 20 Dec 2005 04:55:29 -0800 (PST)
Message-ID: <20051220125529.1208.qmail@web26308.mail.ukl.yahoo.com>
References: <1135047865.2259.46.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 13:56:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eoh1j-0006zG-J9
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 13:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVLTMzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 07:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVLTMza
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 07:55:30 -0500
Received: from web26308.mail.ukl.yahoo.com ([217.146.176.19]:42614 "HELO
	web26308.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750731AbVLTMza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 07:55:30 -0500
Received: (qmail 1210 invoked by uid 60001); 20 Dec 2005 12:55:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Y/d65VXxOT+nruwEHvBjrb0tV6AJwi2++BjPi5MdMartRN30cushXaPdQJZr1WZ/wnNrFtqU31R3m5IjEzF4uIYWyZj5SdD5OcBejrSO2WY4oEnIWNu1xHbk/ZOJyE1PsmObv/LbNJfk9bauuIEE2TP1+1Il7XPKLMQEXmoO6Bg=  ;
Received: from [195.103.152.66] by web26308.mail.ukl.yahoo.com via HTTP; Tue, 20 Dec 2005 04:55:29 PST
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1135047865.2259.46.camel@dv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13848>

> OK, here you go.  qgit just crashed on me.  I opened the patch pane, the
> tree pane and the annotate window.  While the annotate window was
> focused, I tried to select multiple files in the tree pane. 
 
Hi Pavel,

 thanks for crash report, I will investigate it.
> 
> Also, qgit doesn't look well with large fonts (not excessively large,
> mind you, just with Sans 12):
> 
> http://red-bean.com/proski/qgit/
> 
> I see sizes are hardcoded in the *.ui files.  Probably there should be a
> way to make the widgets resize together with the font.
> 

I will investigate what Qt designer allows abot font resizing.


> I don't want to be asked about range every time I start qgit.  Can it be
> an option?  In half of the cases I just want to see commits in the last
> 2-4 days.  In other cases, I want to see the whole history.  Tags are
> usually irrelevant.
> 

I know what you mean ;-)

To avoid range select dialog simply call qgit with some command line option (arguments are feeded
to git-rev-parse, so the same options of gitk are allowed), qgit shows the dialog only if called
with no arguments.

If you don't want to type options just call qgit and press enter as soon as range select appears, 
by default you will see commits from HEAD to latest tag.

If, instead, you want to see whole the history, press "Canc" to delete "to" field tag and then
press enter. That's the reason the focus is on "to" field by default ;-)

An option at startup to bybass range select could be an idea tough.


> The "Show All" checkbox in the range select dialog doesn't seem to have
> any effect.  I think it should disable "top" and "bottom" comboboxes.
> 

"Show All" is simply a shortcut for git-rev-parse --show-all option, to see all the branches
between selected commit range.

Tags selection is to define selected commit range

Peraphs it should be better call it "Show all branches" and add a new check "Show whole history"


Thanks for your feedback.

Marco



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
