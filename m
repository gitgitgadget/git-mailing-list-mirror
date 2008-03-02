From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Sun, 2 Mar 2008 16:55:41 +0100
Message-ID: <20080302155541.GH2973@steel.home>
References: <47C98472.8000002@gmail.com> <20080302094031.GA2973@steel.home> <1b46aba20803020454v322f061bi4f34a737e9e2b7f3@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:56:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqYK-0006NO-JQ
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYCBPzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbYCBPzo
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:55:44 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:54225 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbYCBPzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:55:44 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKcp6o=
Received: from tigra.home (Fab7c.f.strato-dslnet.de [195.4.171.124])
	by post.webmailer.de (klopstock mo14) (RZmta 16.8)
	with ESMTP id d03f1fk22FXC0n ; Sun, 2 Mar 2008 16:55:42 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BE4C0277BD;
	Sun,  2 Mar 2008 16:55:41 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 20D2156D24; Sun,  2 Mar 2008 16:55:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b46aba20803020454v322f061bi4f34a737e9e2b7f3@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75797>

Carlos Rica, Sun, Mar 02, 2008 13:54:10 +0100:
> On Sun, Mar 2, 2008 at 10:40 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> > Carlos Rica, Sat, Mar 01, 2008 17:29:38 +0100:
> >
> > > @@ -169,40 +173,31 @@ static const char *reset_type_names[] = { "mixed", "soft", "hard", NULL };
> >  >
> >  >  int cmd_reset(int argc, const char **argv, const char *prefix)
> >  >  {
> >  > -     int i = 1, reset_type = NONE, update_ref_status = 0, quiet = 0;
> >  > +     int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
> >  >       const char *rev = "HEAD";
> >  >       unsigned char sha1[20], *orig = NULL, sha1_orig[20],
> >  >                               *old_orig = NULL, sha1_old_orig[20];
> >  >       struct commit *commit;
> >  >       char *reflog_action, msg[1024];
> >  > +     struct option options[] = {
> >
> >  "static const"?
> >
> >
> 
> "static const" what?
> options? cmd_reset? reset_type_names?

"static const struct option options[] = {"

the others are already either statics or const properly
