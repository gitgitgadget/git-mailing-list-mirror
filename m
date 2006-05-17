From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC] qgit with tabs
Date: Wed, 17 May 2006 19:21:34 -0400
Message-ID: <1147908094.32050.22.camel@dv>
References: <e5bfff550605130344n75e3e55eq533c49fc2a4f5483@mail.gmail.com>
	 <20060513070726.qa5ssccws80go044@webmail.spamcop.net>
	 <e5bfff550605130431w417b8aacl2b17cf5655b46f31@mail.gmail.com>
	 <20060513142840.39c0kwkw84g8g88g@webmail.spamcop.net>
	 <e5bfff550605131538u63b87002o3e9b5542c0e15bf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 01:21:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgVKo-0008S6-0f
	for gcvg-git@gmane.org; Thu, 18 May 2006 01:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWEQXVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 19:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWEQXVi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 19:21:38 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:28039 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750701AbWEQXVi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 19:21:38 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FgVKj-0005Jk-CA
	for git@vger.kernel.org; Wed, 17 May 2006 19:21:37 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FgVKg-0008W8-C3; Wed, 17 May 2006 19:21:34 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550605131538u63b87002o3e9b5542c0e15bf7@mail.gmail.com>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20251>

Hi, Marco!

On Sun, 2006-05-14 at 00:38 +0200, Marco Costalba wrote:
> Hi Pavel,
> 
> >
> > Sure, but I often want to see what changed in a particular file.
> >
> > And of course I only mean the subwindow dislaying the files affected by the
> > patch.  The file tree should still have file annotation bound to the double
> > click.
> >
> 
> I understand your reasons, but I have some doubts about this change:
> 
> 1) The context menu is currently shared between the tree and the file
> list, splitting in two subcases adds some crap to the code (ok, this
> is not the real doubt ;-)  )

Actually, "Get revision/patch" and "External diff" shouldn't be in the
popup used in the tree, or at least they should only appear for the
files affected by the currently selected patch.

"External diff" may be a good candidate for the toolbar if you find out
how to feed a multi-file patch to kompare (I guess you'll need two
temporary directories populated with differing files).

> 2) The context menu is currently shared between the file list in main
> view and the file list in patch view. The file list in patch view, of
> course, does not need a double click, a single click is enough to
> select corresponding file's diff. In main view you currently need a
> single click _plus_  a 'p' key press to change the view. So we should
> add another subcase here.

Yes.  It should be perfectly OK to have different menus for different
contexts.

> 3) It is true that double clicking on a revision switch to the patch
> view at top position (if no file is selected), but it's also true that
> you can select the file's related diff directly in patch view with a
> single click on the right column file list.

That's true.  But I still find myself double clicking on the file in the
file list and expecting to see the patch for the file.  It's very
natural.  

If I see the list of the recent patches, I see the descriptions and the
affected files.  If I'm interested to see what changed in the file, it's
only natural for me to double-click the corresponding entry in the list.

Full history of a file is a much more advanced operation, and it's not
something I need to do often while browsing recently merged changes.

> 4) Once a file is selected, as example with a single click, you can
> browse through rev list and the selection is preserved, it means that
> anytime you switch to patch view page the content will be _already_
> centered on the correct diff.

That's useful, but irrelevant.

> 5) Double clicking on a file name is currently the only way (without
> opening the menu) to show the file content tab, with your suggested
> change we will have two ways to switch to patch view and no one to
> switch to file view.

That's a good thing.  That's called consistency.  git is about patches,
so showing the patches should be the default whenever practical.

The file viewer is a great feature, and it should be discoverable, but
it doesn't mean it should pop up when users expect something else.

> 
> 6) Selecting from the tree view is very slow if you have to search for
> the correct file, it is fast only if the file is already selected, but
> in this case is faster to press 'p' key ;-)

That's true, but we are talking about double click behavior.  Every
reasonable person can learn shortcuts, but the software should work
predictably even if operated by the mouse.

-- 
Regards,
Pavel Roskin
