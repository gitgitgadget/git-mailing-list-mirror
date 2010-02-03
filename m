From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 3 Feb 2010 18:18:59 -0500
Message-ID: <32541b131002031518t1017d351xcf9071f0a937474e@mail.gmail.com>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> 
	<ron1-5F71CB.11234903022010@news.gmane.org> <alpine.LFD.2.00.1002031436490.1681@xanadu.home> 
	<ron1-34F9C6.12273203022010@news.gmane.org> <32541b131002031240p6b67536ame6b69c6d662a7968@mail.gmail.com> 
	<ron1-9FA846.14332803022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:20:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcoWH-0005qP-7C
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 00:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553Ab0BCXTV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 18:19:21 -0500
Received: from mail-gx0-f228.google.com ([209.85.217.228]:54940 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516Ab0BCXTU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 18:19:20 -0500
Received: by gxk28 with SMTP id 28so1795396gxk.9
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 15:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ieuQEwD8qLNw52rLGHlJPXRG4oKjT8XZWt7ti77xwVk=;
        b=OYCxl7TyFIJjzrexhNcu2DJeI9oBpAbolyUQQYltHZ91p5BxQnHxytRs+C7VrHkQPu
         MVkfLl4Nmc/yGS4QOzsFRo+ulEsH8NG8zG+Rl8+hpZqULqVkeNYhEPbQmFYPsaNSpJ4a
         zMoLNN3K4Nez8cQpNhkvvIch/UEBUwVbNUD7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eXJEOn2RpcZRMZn+VSCho6PcmuDtkgrfB7J/NUs1GN3HUCExI0tTurWqV6NbikGOvu
         PfbVFDJYEu0W+OHie77tXnar7TJk3VItT7VfQw0oPRqRiPR+2LGKOJC+JAm6zFMJlvH7
         PCPWZiNSFc7St6ha8yWl4VvcsUHuy8B8fCtRE=
Received: by 10.151.89.37 with SMTP id r37mr904502ybl.60.1265239159174; Wed, 
	03 Feb 2010 15:19:19 -0800 (PST)
In-Reply-To: <ron1-9FA846.14332803022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138915>

On Wed, Feb 3, 2010 at 5:33 PM, Ron Garret <ron1@flownet.com> wrote:
> Here's a realistic case where keeping explicit track of renames could=
 be
> useful.
>
> A and B start with a file named config. =A0A and B both make edits. =A0=
In
> addition, B renames config to be config1 and creates a new, very simi=
lar
> file called config2. =A0B then merges from A with the expectation tha=
t B's
> edits to config would end up in config1 and not config2. =A0It seems =
to me
> that without tracking renames, it would be luck of the draw which fil=
e
> the patch got applied to.

The problem is that this single "realistic case" is not actually very
common, and it's dwarfed by the other realistic cases: developer
forgets to use 'git mv' to rename the file; developer accidentally
deletes a file, commits, and then readds it later; etc.

Have I been bitten by exactly your example?  Yup.  But I've been
bitten by lots of other related things too, and explicit rename
tracking (at least in svn) has quite frequently made the problems
*worse*.  In my personal experience, git screws up less often.  The
fact that it's also elegant is a nice bonus too :)

More about this: http://marc.info/?l=3Dgit&m=3D114123702826251

Have fun,

Avery
