From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 08:37:16 -0700
Message-ID: <467A9B2C.2060907@midwinter.com>
References: <20070621030622.GD8477@spearce.org> <200706211050.03519.andyparkins@gmail.com> <Pine.LNX.4.64.0706211252190.4059@racer.site> <200706211344.47560.andyparkins@gmail.com> <vpqodj9zcxf.fsf@bauges.imag.fr> <Pine.LNX.4.64.0706211417090.4059@racer.site> <vpqfy4lxwvl.fsf@bauges.imag.fr> <Pine.LNX.4.64.0706211451480.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 21 17:37:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Oiq-0002WE-25
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 17:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbXFUPhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 11:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbXFUPhV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 11:37:21 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:40065
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753402AbXFUPhU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 11:37:20 -0400
Received: (qmail 27821 invoked from network); 21 Jun 2007 15:37:20 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=SK88UoOaEzQusZorZtTQOT1/x0kk1EcuCNXpg9qkazLbiPaP2zRoUp/anOEV0Q8X  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 21 Jun 2007 15:37:20 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <Pine.LNX.4.64.0706211451480.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50633>

Johannes Schindelin wrote:
> Yes. And Git explicitely allows what I call stupid. And yes, those 
> _identical_ files in the test suit should probably all be folded into 
> single files, and the places where they are used should reference _that_ 
> single instance.
>   

Two files that are identical in the current revision have not 
necessarily been identical from the beginning. Doing what you suggest 
will cause you to lose the history of all but one of those files.

Files can absolutely become identical in the real world. I know that for 
a fact because it happened to me just this week (see my "Directory 
renames" message from a few days ago.) Are you seriously suggesting that 
every time I unpack an update from a third party, I should go through it 
and see if they have changed any files such that the contents now match 
another file in my repository, and if so, I should remove all but one of 
the copies from my repository and have a build system create it instead? 
Then undo that work when I unpack another update and the files are no 
longer identical?

Well, no, I know you're not suggesting that, but it's the logical 
conclusion of the "it's stupid to ever have duplicate files" philosophy. 
While that approach certainly makes life easier for the version control 
system, it doesn't exactly make life easier for the *developer*, which 
is kind of the whole point of why we're here.

-Steve
