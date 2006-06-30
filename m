From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Incorporating gitweb-xmms2 features in trunk gitweb
Date: Fri, 30 Jun 2006 11:59:37 +0200
Message-ID: <200606301159.38431.jnareb@gmail.com>
References: <200606210845.31807.jnareb@gmail.com> <449EF8A9.3080301@xmms.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 30 11:59:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwFmk-0003AH-Al
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 11:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWF3J7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 05:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWF3J7f
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 05:59:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:25304 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932495AbWF3J7e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 05:59:34 -0400
Received: by nf-out-0910.google.com with SMTP id c2so212740nfe
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 02:59:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ISxvo8TS4VwHuIGVV2zTq1qJrxIS29AA9Nk/uiUrJdU2Xc35ivVHJWPaK6j4Tc77XyncymvOyel/u0JUjp7FflGM60KbOLJWJNHL5FRGdQvSHTZsgKcFv7LB+yBJsS0Uwt7WFVshtBpKlCSio862wvEABE70c+PepAZ+wacIZko=
Received: by 10.49.21.14 with SMTP id y14mr152123nfi;
        Fri, 30 Jun 2006 02:59:31 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id a23sm1404288nfc.2006.06.30.02.59.30;
        Fri, 30 Jun 2006 02:59:31 -0700 (PDT)
To: Sham Chukoury <eleusis@xmms.org>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <449EF8A9.3080301@xmms.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22975>

Sham Chukoury <eleusis[@]xmms[.]org> wrote:
> Jakub Narebski wrote:
>> Now (from git 1.4.0) that gitweb is incorporated in main git.git 
>> repository, and patches to it are accepted by Junio on git mailing 
>> list, I have taken to adding new features to gitweb.
>> 
>> I've planned on adding gitweb-xmms2 features (using separate topic 
>> branches for each feature, like snapshots, hightlighting, committags).
>> Perhaps we could coordinate efforts?
> 
> Coordination sounds great. What do you have in mind? :)

Actually it seems that I wouldn't have much time (at least in near future)
for work on gitweb. The main thing stopping me is that gitweb needs
refactoring before adding (or re-adding) new features, as it is written
partially at least in copy'n'paste style, AND waiting for Git.pm Perly git
interface (I'd like to have perl-only Git.pm and use it in gitweb, but 
pasky who develops it uses XS for speed).
 
An example of such refactoring is your separation of navbar generation
code. Similar work was done by Sven Verdoolaege when introducing in-gitweb
snapshot code in
  "gitweb and tar snapshots"
  http://marc.theaimsgroup.com/?l=git&m=111909432415478&w=2
  http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=summary
  http://www.liacs.nl/~sverdool/gitweb.git#master
In my opinion your navbar code is too tied up with current navbar, while
sverdool is a little too perl-hackerish (e.g. there is only one instance,
i.e. root commit, where "top" part of navbar is not default, i.e. it
lacks "commitdiff" (to parent)).

>> For now from gitweb-xmms2.git I have only cherry-picked "Make CSS 
>> readable" commit 561262030d58a6325f500b36d836dbe02a5abc68.
> 
> Bear in mind that, since 'forking' (for lack of a better word) from v264, I 
> haven't merged any changes from the 'official' gitweb tree.. Last time I 
> checked, there's at least one changeset I reimplemented differently (perhaps 
> wrongly). I need to go back and see what needs to be fixed properly..

gitweb-xmms2 merged quite cleanly with 1.4.0. It was later changes in next
(among  others adding optional "blame" view for blobs, using old navbar 
generation) that makes automatic merge fail. 

> Going back to the point on coordination - I currently track bugs and feature 
> requests for gitweb-xmms2 using the xmms2 bug tracker at 
> http://bugs.xmms2.xmms.se (You'll need to select the 'Misc - gitweb' project 
> from the dropdown at the top right of the page to see the relevant reports)

Check my two threads on gitweb wishlist features, and plans on refactoring
on git mailing list:
  "[RFC] gitweb wishlist and TODO list"
  Message-ID: <e79921$u0e$1@sea.gmane.org>
  http://permalink.gmane.org/gmane.comp.version-control.git/22213
  http://marc.theaimsgroup.com/?l=git&m=115082279425118&w=2
and
  "gitweb refactoring"
  Message-ID: <e7ed1r$9ve$1@sea.gmane.org>
  http://permalink.gmane.org/gmane.comp.version-control.git/22345
  http://marc.theaimsgroup.com/?l=git&m=115099031220954&w=2


P.S. Now that gitweb is included in git.git (from git version 1.4.0), you should
have easier to have your patches accepted into gitweb trunk.

-- 
Jakub Narebski
ShadeHawk on #git
