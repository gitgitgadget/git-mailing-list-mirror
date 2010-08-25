From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug report: %h for abbreviated hashes broken after 1.7.1
Date: Wed, 25 Aug 2010 01:24:03 -0500
Message-ID: <20100825062403.GA15858@burratino>
References: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com>
 <20100825041440.GH11619@burratino>
 <AANLkTi=+tGLfs-t6+fjRu68Mt76dJw4sbNCoO9q9+uyp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <tjacobs@si2services.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 08:26:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo9R2-0005PG-5x
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 08:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab0HYGZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 02:25:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59947 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab0HYGZy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 02:25:54 -0400
Received: by gxk23 with SMTP id 23so60573gxk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6UeOM3fBDRcpsZyiTW0cE85Lsh8puTDZXnsbFO/P3Hw=;
        b=HH7AyVa/xcB33I/P9KNqzOiuCGvus98d4tKsS52SiosEuFmwln+hhkH9aDdTSC/87g
         vh98HO2W1TjAPtq8YTNkiYRnVHfZ+aFqg1SQDJ6lw6iewRVqwM5+xIkSgwT7Ag3rddq5
         XEL9mdLG8jkNguwxpqKBj/o8MyZ2CS3Yyd86Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Zd5ynpb+IZDuBExshJX1gz3Drkmdr+zQf/Ai3LovvWxGQvDAW5QeBGyRtonkeKks2h
         RymnCURVaMskPDmBLIlyxWtkxAeY9aePE2nmo9+L5TI7aF60SuJxGSN38E32AFvj09id
         Fnei1ikL766BQ7OPm5w7j9Fah2BzTZAVJttTU=
Received: by 10.100.120.14 with SMTP id s14mr8513362anc.151.1282717552546;
        Tue, 24 Aug 2010 23:25:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u14sm1497395ann.0.2010.08.24.23.25.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 23:25:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=+tGLfs-t6+fjRu68Mt76dJw4sbNCoO9q9+uyp@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154426>

Hi again,

Todd A. Jacobs wrote:
> On Wed, Aug 25, 2010 at 12:14 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> $ git log --oneline v1.7.2.2..35039ced9296786bc0971bf5385c0d6f6ea5ea1e
>> 35039ce archive: abbreviate substituted commit ids again
>
> I'm not at all sure I understand your point.

Sorry, let me try again.

As you know, in a distributed development model, history is not
linear.  It is possible to have multiple lines of development by
people who are not aware of each other:

   o --- o --- o --- o
  /
 o --- o --- o --- o

that are only later merged.

   o --- o --- o ----- o
  /                     \
 o --- o --- o --- o --- o

Sometimes even a single person will use history like this, for
release management purposes.  A change that has not yet been
released will be kept on one branch while releases are cut from
another branch.

The command

 $ git log --oneline v2.9..topic

lists commits that are in the history of the "topic" branch but
are not part of the v2.9 release.

So my response was to indicate that there is no contradiction
here: that fix has been prepared but it is not part of the v1.7.2.2
release.

Regards,
Jonathan
