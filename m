From: Petr Baudis <pasky@suse.cz>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 21:03:45 +0100
Message-ID: <20060121200345.GL28365@pasky.or.cz>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com> <20060121194826.GK28365@pasky.or.cz> <20060121144901.33b03395.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: morgad@eclipse.co.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 21:02:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0OwK-0001LG-GB
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 21:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWAUUCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 15:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWAUUCW
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 15:02:22 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50642 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932309AbWAUUCV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 15:02:21 -0500
Received: (qmail 3599 invoked by uid 2001); 21 Jan 2006 21:03:45 +0100
To: sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060121144901.33b03395.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15012>

Dear diary, on Sat, Jan 21, 2006 at 08:49:01PM CET, I got a letter
where sean <seanlkml@sympatico.ca> said that...
> On Sat, 21 Jan 2006 20:48:26 +0100
> Petr Baudis <pasky@suse.cz> wrote:
> 
> > >                 sed -e
> > > 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \
> > > 
> > > s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
> > > \
> > >                        $file > $file.new; \
> > >                 cat $file.new > $file; rm $file.new; \
> > >         done
> > > sed: -e expression #1, char 145: unterminated address regex
> 
> The problem seems to go away if you remove the quoted end-of-line:
> 
> sed -e 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g;
>         s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
> 
> 
> where the following, doesn't:
> 
> sed -e 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \
>         s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'

Yes, the problem goes away because then make will split that to two
lines, causing:

        sed -e 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/xpasky\/lib\/cogito\/}/g;
/bin/sh: -c: line 0: unexpected EOF while looking for matching `''
/bin/sh: -c: line 1: syntax error: unexpected end of file

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
