From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] qgit with tabs
Date: Sun, 14 May 2006 00:38:46 +0200
Message-ID: <e5bfff550605131538u63b87002o3e9b5542c0e15bf7@mail.gmail.com>
References: <e5bfff550605130344n75e3e55eq533c49fc2a4f5483@mail.gmail.com>
	 <20060513070726.qa5ssccws80go044@webmail.spamcop.net>
	 <e5bfff550605130431w417b8aacl2b17cf5655b46f31@mail.gmail.com>
	 <20060513142840.39c0kwkw84g8g88g@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 00:38:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff2lB-0002oU-ET
	for gcvg-git@gmane.org; Sun, 14 May 2006 00:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWEMWit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 18:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWEMWis
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 18:38:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:27171 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964783AbWEMWir convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 18:38:47 -0400
Received: by wr-out-0506.google.com with SMTP id i5so850195wra
        for <git@vger.kernel.org>; Sat, 13 May 2006 15:38:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MM4GQl9u40CDNMQgo70JId6DD/QYHxZELHeSeWk+xdO0OHBd3XYpj2sEIe6YWlJ9vaFsdPjpB9NIsMEGg+Wc9RspjBNLTpH00JC3L11E7VYhwjZMd8mG/7NQnMEuh/JubwrbLbCmOAdYKkUaNMitTaq0E5RnVrsg/p3kST/DFB8=
Received: by 10.65.73.13 with SMTP id a13mr2643984qbl;
        Sat, 13 May 2006 15:38:46 -0700 (PDT)
Received: by 10.64.131.11 with HTTP; Sat, 13 May 2006 15:38:46 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <20060513142840.39c0kwkw84g8g88g@webmail.spamcop.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19950>

Hi Pavel,

>
> Sure, but I often want to see what changed in a particular file.
>
> And of course I only mean the subwindow dislaying the files affected by the
> patch.  The file tree should still have file annotation bound to the double
> click.
>

I understand your reasons, but I have some doubts about this change:

1) The context menu is currently shared between the tree and the file
list, splitting in two subcases adds some crap to the code (ok, this
is not the real doubt ;-)  )

2) The context menu is currently shared between the file list in main
view and the file list in patch view. The file list in patch view, of
course, does not need a double click, a single click is enough to
select corresponding file's diff. In main view you currently need a
single click _plus_  a 'p' key press to change the view. So we should
add another subcase here.

3) It is true that double clicking on a revision switch to the patch
view at top position (if no file is selected), but it's also true that
you can select the file's related diff directly in patch view with a
single click on the right column file list.

4) Once a file is selected, as example with a single click, you can
browse through rev list and the selection is preserved, it means that
anytime you switch to patch view page the content will be _already_
centered on the correct diff.

5) Double clicking on a file name is currently the only way (without
opening the menu) to show the file content tab, with your suggested
change we will have two ways to switch to patch view and no one to
switch to file view.

6) Selecting from the tree view is very slow if you have to search for
the correct file, it is fast only if the file is already selected, but
in this case is faster to press 'p' key ;-)


       Marco
