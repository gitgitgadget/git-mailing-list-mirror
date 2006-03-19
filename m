From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Sun, 19 Mar 2006 22:40:41 +0100
Message-ID: <e5bfff550603191340u466d3551t8a95c3808eb977c1@mail.gmail.com>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
	 <4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
	 <e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com>
	 <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 19 22:40:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL5dm-0003Ne-2i
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 22:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWCSVkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 16:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWCSVkn
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 16:40:43 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:31393 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751087AbWCSVkn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 16:40:43 -0500
Received: by zproxy.gmail.com with SMTP id j2so1110581nzf
        for <git@vger.kernel.org>; Sun, 19 Mar 2006 13:40:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QluwAViKt0LnD2BXaBzmzfRzb/MSkXhLqRt7+CmlMfwmwepiTmynXNTTw/8o4Za6ifY8QaEkMoWKLL9O+x/OpbCIrvDEtql5EWO052W05JN0iTOOZZgd274y3zFYfyJsqQ5EPIP4VIVtm02mvGq4XGe36Ea1gAVl/u3WJuAI2Sw=
Received: by 10.65.44.5 with SMTP id w5mr329666qbj;
        Sun, 19 Mar 2006 13:40:41 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Sun, 19 Mar 2006 13:40:41 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17726>

On 3/19/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > http://digilander.libero.it /mcostalba/scm/qgit.git/objects/8d/ea03519e75f47d
> >
> > Git does not understand object is missing and thinks what site sends
> > _is_ the requested
> > object and then founds that is (of course) corrupted.
>
> To be fair, the site is _not_ missing anything from HTTP
> protocol perspective, because when git asks 8d/ea0351... file,
> the server responds with a regular "HTTP/1.0 200 OK" response.
> So it is _your_ repository that is corrupt -- instead of
> correctly _lacking_ the file you should have removed with
> prune-packed, it has a garbage file.
>

Currently my git repo layout is as follow
$ pwd
<local master copy>/qgit.git/.git
$ ls
branches/  description  HEAD    index  objects/   refs/
config     FETCH_HEAD   hooks/  info/  ORIG_HEAD  remotes/
$ ls objects
2c/  32/  53/  5c/  6a/  info/  pack/

The host copy should be the exact mirror of the local copy (I use
sitecopy to sync
host). I have also verified this directly accessing the host with ftp.

So the 8d/ea0351... file is really not existent. BTW I have run git
prune and git-prune-packed
also.

Finally accessing the missing object with a browser

http://digilander.libero.it/mcostalba/
scm/qgit.git/objects/8d/ea03519e75f47da91108330dde3043defddd60

gives a pre-canned (in italian) 'Sorry page not found' stuff.

So I really think the site "HTTP/1.0 200 OK" response it's a fake.
Perhaps security related to avoid sniffing (just a guess because I have
absolutely zero competence in security related things).


Marco
