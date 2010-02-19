From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git fast-import / working tree status question
Date: Fri, 19 Feb 2010 15:40:47 -0800
Message-ID: <ec874dac1002191540p343889d7v5f14876cf0df14c8@mail.gmail.com>
References: <fc5ef2e01002191520u7b50c98fo3a3defe70e31292a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Fleetwood <mike.fleetwood@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 00:41:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicTE-0002dm-MS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088Ab0BSXlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 18:41:10 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46242 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab0BSXlJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 18:41:09 -0500
Received: by wwf26 with SMTP id 26so59734wwf.19
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 15:41:07 -0800 (PST)
Received: by 10.216.162.202 with SMTP id y52mr35923wek.76.1266622867518; Fri, 
	19 Feb 2010 15:41:07 -0800 (PST)
In-Reply-To: <fc5ef2e01002191520u7b50c98fo3a3defe70e31292a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140503>

On Fri, Feb 19, 2010 at 3:20 PM, Mike Fleetwood
<mike.fleetwood@googlemail.com> wrote:
> I am a newbie using git and I am testing conversion of a personal
> project into git using fast-import. =A0When fast-import completes
> all the files are in the repository but the working tree is empty
> and status reports all files are delete but uncommitted. =A0I have
> to use reset --hard HEAD to unwind the pending removal of all of
> the files. =A0Example below.
>
> Is this normal or have I missed something?

Completely normal.  fast-import is a lower level command which only
works on the object directory.  Frontend tools which automate the
conversion are supposed to checkout the working tree files after the
import is complete.  Or, run like you did, `git reset --hard HEAD`.
