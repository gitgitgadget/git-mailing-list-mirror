From: Pieter de Bie <pieter@frim.nl>
Subject: Re: [RFC] Common library for Git GUIs
Date: Tue, 17 Feb 2009 20:08:23 +0000
Message-ID: <74161B7F-A178-49CB-990D-DF7299235C58@frim.nl>
References: <20090216212459.GA25046@efreet.light.src>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonas Fonseca <fonseca@diku.dk>,
	Marco Costalba <mcostalba@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Abhijit Bhopatkar <bain@devslashzero.com>,
	Henk <henk_westhuis@hotmail.com>, Frank Li <lznuaa@gmail.com>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Feb 17 21:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZWGr-0003sk-Su
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 21:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbZBQUIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 15:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbZBQUIg
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 15:08:36 -0500
Received: from frim.nl ([87.230.85.232]:50729 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276AbZBQUIf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 15:08:35 -0500
Received: from cnat081.wlan.net.ed.ac.uk ([129.215.5.81] helo=[172.20.196.1])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1LZWF4-0001N7-De; Tue, 17 Feb 2009 21:08:30 +0100
In-Reply-To: <20090216212459.GA25046@efreet.light.src>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110448>

Hi,

On Feb 16, 2009, at 9:24 PM, Jan Hudec wrote:

> What it should use:
>
> - It should probably be in C++ or C, with bindings for at least Perl,
>   Python, Ruby, C#(CLR) and Java. The bindings can be done either  
> with Swig,
>   or using some base library that already has them.

It should be either C++ or C. If you want git devvers to work on it too,
you'll probably want to go with C.

>   I think Java or CLR, while more portable, would not be appropriate  
> because
>   there is no standard way to combine them with other languages like  
> Perl,
>   Python and Ruby and those languages are still superior for the UI
>   programming itself. I somewhat prefer C++, because polymorphism  
> and some
>   template tools would be useful here, but I am open to arguments.

I think JGit is pretty far along for someone who wants to create a Java
GUI.
>    - Bindings for languages. We can use Swig, but it has e.g. no  
> support for
>      callbacks, so having portable runtime with already existing  
> bindings
>      that support this would be an advantage.

I'd say bindings are pretty easy to create yourself.

> Portable runtime options:
>
> So what do you people think would be best? I see several options:
>
> - QtCore
>
>   Qt seems to be the most popular library among Git GUI writers and  
> since
>   version 4.5 will be LGPL, so it will be allowed to link with  
> anything.
>   It is also probably the most portable one. On the downside, it's  
> rather
>   large and it's language bindings are a bit worse (the garbage  
> collector
>   integration was a bit bad last time I looked).
>
> - Glib
>
>   This is C based, so the core could be in plain C. It is also quite  
> modular
>   and has very good support for bindings to various languages. On the
>   downside it's a bit less portable and less used among the existing  
> guis.
>   C would mean more work, but we could probably save some of it by  
> using
>   gob2 (g object builder)
>
> - STL + Boost
>
>   I don't have experience with it, though I read some of the  
> documentation.
>   It should be sensibly portable. I know it has python bindings, the  
> rest
>   would probably have to be dealt with using swig.

None of these, if you want any GUI's to use it. Noone is going to
create a Gtk / Cocoa / Windows app that depends on Qt. Nobody wants
to use Boost in any situation and Glib, while being smaller than the
rest, is also difficult as it isn't shipped with many OS's, for example
OS X.

> - POSIX + Msys on Windows
>
>   I guess it would technically be usable, but I think it would be  
> rather lot
>   of additional work. It would probably be quite lightweight, though.

I think lightweight is the way to go. If you go for C++, you can also  
use
the STL.

But, isn't this time spent better on getting libgit2 off the ground?
