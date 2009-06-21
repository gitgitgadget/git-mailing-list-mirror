From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/2] rebase -i: use config file format to save author information
Date: Sun, 21 Jun 2009 11:53:03 +0200
Message-ID: <200906211153.03969.chriscool@tuxfamily.org>
References: <20090621050846.3554.31660.chriscool@tuxfamily.org> <alpine.LNX.2.00.0906210244510.2147@iabervon.org> <7vhbyat6qc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 11:54:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJl9-00038c-UN
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 11:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbZFUJwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 05:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbZFUJwx
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 05:52:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55889 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbZFUJww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 05:52:52 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 63499818181;
	Sun, 21 Jun 2009 11:52:46 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1FAB68180B5;
	Sun, 21 Jun 2009 11:52:44 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vhbyat6qc.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121980>

On Sunday 21 June 2009, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> >> Why is this a good change?
> >
> > It was always using a temporary file; it just used to use a temporary
> > file that was a shell script fragment and needed to be read with
> > "eval". It can't be done entirely in core because it may be determined
> > before a conflict and only used when run with --continue after the user
> > resolves the conflict.
>
> Ahh, Ok.
>
> Using a _known_ and defined format, instead of ad-hoc scriptlet, is an
> improvement.
>
> I still wonder if we can avoid using three separate "git show" and "git
> config" invocations, though.  But a half of that inefficiency will go
> away when this is migrated to C, as a single git_config() will grab all
> three, although the writing side is still very inefficient X-<.

It may be possible to write a ref to the commit we need information from. 
And then when "git rebase --continue" is called, we would read this ref and 
then get information from the referenced commit?

Best regards,
Christian.
