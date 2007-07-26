From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 13:11:48 +0800
Message-ID: <46A82D14.6090404@midwinter.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>	 <46A73015.7020306@midwinter.com> <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 07:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDvdk-0002H0-FR
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXGZFLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbXGZFLx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:11:53 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:58458
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1751988AbXGZFLw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:11:52 -0400
Received: (qmail 25355 invoked from network); 26 Jul 2007 05:11:52 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=gis9opNDI0aVMOpdt/J6TYz4ueE8aZU9gB03eevhdZT+rh4dOSVc02CRA6ANI2nI  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 26 Jul 2007 05:11:51 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53766>

Wrote this reply privately earlier; forwarding to the list at Dmitry's 
suggestion (though it's rendered slightly less relevant by his 
clarifications)...

Dmitry Kakurin wrote:
> This actually answers my question (if it's true).
> If core team is not interested in supporting Windows then I cannot
> trust this system with my source code :-(.
>   

I certainly understand the conclusion, but I'm not sure I would share 
it. Unless you have reason to believe there's something in particular 
about the Windows environment that would cause git to lose data in 
circumstances where it wouldn't do so under UNIX-ish systems, it seems 
like your data should be perfectly safe.

In the year-and-a-bit I've been lurking on the git mailing list and 
making occasional contributions to the code, git has never lost any data 
for anyone to my knowledge. Its design is extremely paranoid in that 
regard, and the paranoia is not really anything platform-dependent. It's 
stuff like, never overwrite files in place (always write a new file 
then, once it's written successfully, get rid of the old one if needed). 
Or, as importantly, keep SHA1 hashes of *everything* and double-check 
them often. Those approaches are just as valid on Windows as on any 
other OS. The SHA1 hashes in particular are pretty unimpeachable, IMO; 
the times people have thought their git repositories have gotten 
corrupted, it has always turned out to be underlying filesystem or disk 
corruption that git's SHA1 checking has caught.

If there are data loss bugs in git (and of course it's possible, even if 
none have been reported to my knowledge) IMO they're vastly more likely 
to be generic than platform-specific.

One nice thing about git is you don't have to take its word for your 
data integrity. You can, without a whole lot of effort, dump out every 
file in the repository and verify that it is what git says it is.

Anyway, I guess my feeling would be, if I were going to choose to not 
use git on Windows it would be because of smoothness of the experience, 
lack of integration with Windows tools, difficult installation process, 
or stuff like that. Data integrity would not even cross my mind as a 
downside of git.

-Steve
